---
title: HBase重复数据问题解决思路
date: 2016-11-19 21:59:43
tags:
- HBase
categories: Programming
---

解决思路1可以设计消息主键，每次插入数据时，查询判断此消息是否已经写入，可以排除重复写入数据问题。但是此种手段需要查询HBase，由于写入并发量相对较高>1000条/s。会影响写入速度。由于此时有单点的Redis,由于数据到达的时间相隔不会太长，可以考虑将数据持久化到Redis中，插入时，到Redis中查询，Redis中查询复杂度为常数，基本可以忽略查询对性能的影响。判断是否已经写入。而写入到Redis中的数据可以设置过期时间，可以自动清除。

<!-- more -->

采用此种方式，需要考虑，新的消费者不能消费数据from beginning。如果新消费者从头开始消费数据，此时Redis缓存已经清除，也会重复写入数据。需要在写入时作相应判断，超过Redis缓存到达的数据不用写入。


```Java
public void positionInfoHandler(KafkaRecievedLocationMessage<KafkaRecievedLocationMessageBody> kafkaRecievedLocationMessage, String groupId) {
    if (groupId != null && groupId.equals(PublicVariable.HBASE_GROUPID)) {

        /**
         * 将最近的位置数据缓存到Redis中
         * 判断重复数据查询Redis数据库
         * Redis的Key设计采用topic+消息类型+时间来标志消息的唯一性
         * 如果消息在Redis存在，代表已经写入，将忽略
         * 后期可以考虑添加事务
         *
         */
        String gpsTime = String.valueOf(kafkaRecievedLocationMessage.getData().getMsgBody().getGps_time());
        String positionKey = kafkaRecievedLocationMessage.getDesc().getTopic() + "-" + kafkaRecievedLocationMessage.getDesc().getMsgID() + "-" + gpsTime;
        String persistStatus = RedisHelper.get(positionKey, PublicVariable.REDIS_DEFAULT_DATABASE);
        if (StringUtils.isBlank(persistStatus)) {
            /**
             * 缓存的位置数据将在12小时后过期
             * 只有第一次设置会成功
             * Redis本身是原子操作
             */
            String result = RedisHelper.setValueNx(positionKey, "1", 2592000, PublicVariable.REDIS_DEFAULT_DATABASE);
            if (result != null && result.equals("OK")) {
            	//保存数据
                persistOilImpl(kafkaRecievedLocationMessage, groupId);
            }
        }
    }
}
```

设置Redis的Key，方法setValueNx，如果Key设置成功会返回OK，如果设置失败则返回null：

```
EX seconds -- Set the specified expire time, in seconds.
PX milliseconds -- Set the specified expire time, in milliseconds.
NX -- Only set the key if it does not already exist.
XX -- Only set the key if it already exist.
```


```Java
/**
 * 设置数据
 * 如果已经存在Key
 * 键已经存在，则设置失败
 *
 * @param key     //key
 * @param value   //值
 * @param timeOut //过期时间
 * @param db      //数据库序号
 */
public static String setValueNx(String key, String value, Integer timeOut, Integer db) {
    Jedis jredis = null;
    String result = null;
    try {
        JedisPool poolItem = pools.get(db);
        jredis = poolItem.getResource();
        if (timeOut > 0) {
            jredis.expire(key, timeOut);
        }
        result = jredis.set(key, value, "nx");
    } catch (Exception e) {
        log.error("set value encount an error", e);
    } finally {
        if (jredis != null) {
            jredis.close();
        }
    }
    return result;
}
```

[SET key value [EX seconds] [PX milliseconds] [NX|XX]](http://redis.io/commands/SET)
