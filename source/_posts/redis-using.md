---
title: Redis使用
date: 2016-11-15 18:21:31
tags:
---


#### 过期时间


生存时间可以通过使用 DEL 命令来删除整个 key 来移除，或者被 SET 和 GETSET 命令覆写(overwrite)。


<!-- more -->

```Bash
/**
 * 设置数据（永久有效）
 *
 * @param key     //key
 * @param value   //值
 * @param db      //数据库序号
 */
public static void set(String key, String value, Integer db) {
    Jedis jredis = null;
    try {
        JedisPool poolItem = pools.get(db);
        jredis = poolItem.getResource();
        jredis.set(key, value);
    } catch (Exception e) {
        log.error("set value encount an error", e);
    } finally {
        if (jredis != null) {
            jredis.close();
        }
    }
}
```

#### 取出包含指定规则的Key

从Redis中取出包含指定规则的Key的集合。

```Java
/**
 * 取出包含指定key的集合
 */
public void pushCacheStatusInfo() {
    JedisPool jedisPool = RedisHelper.getRedisPool(0);
    Jedis jredis = null;
    try {
        jredis = jedisPool.getResource();
        //找到包含指定Key的集合
        Set keys = jredis.keys("*websocketsession");
        Iterator iteratorKeys = keys.iterator();
        while (iteratorKeys.hasNext()) {
            String redisKey = iteratorKeys.next().toString();
            String session = jredis.get(redisKey);
            //do something
        }
    } catch (Exception ex) {
        log.error("推送信息出错", ex);
    } finally {
    	if (jredis != null) {
        	jredis.close();
        }
    }
}
```

#### 常用指令

登录Redis：

```Bash
./redis-cli -h 192.168.24.252 -p 6379
```

查看客户端数量：

```Bash
192.168.24.252:6379> info clients
```




