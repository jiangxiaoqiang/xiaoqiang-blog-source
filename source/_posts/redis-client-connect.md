---
title: Redis客户端连接
tags:
  - Redis
  - Connect
categories: Programming
date: 2016-11-04 13:10:45
---

#### Redis特点


* Redis 是一个 key-value 的缓存(cache)和存储(store)系统（现在我们只用它来做缓存，目前还未当作DB用，数据存放在 Cassandra 里）

* 支持丰富的数据结构，List 就专门用于存储列表型数据，默认按操作时间排序。Sorted Set 可以按分数排序元素，分数是一种广义概念，可以是时间或评分。其次，其丰富的数据结构为日后扩展提供了很大的方便。

* 提供的所有操作都是原子操作，为并发天然保驾护航。

* 超快的性能，见其官方性能测试《How fast is Redis?》。

* 拥有比较成熟的Java客户端 - Jedis，像新浪微博都是使用它作为客户端。（官方推荐的Clients）

Redis运行一段时间后，出现错误，无法获得连接：

```
redis.clients.jedis.exceptions.JedisException: Could not get a resource from the pool
```

使用命令查看客户端数量。

```Bash
D:\Program Files\Redis>redis-cli.exe info clients
```

结果如下所示：

```
# Clients
connected_clients:11
client_longest_output_list:0
client_biggest_input_buf:0
blocked_clients:0
```

#### Redis是否正确关闭连接

可以看出目前的客户端已经超出了最大的客户端数量(配置的是10个)。应该是没有释放连接导致的问题。明显一个请求一次连接是很不靠谱的。这个问题发生有两方面的原因：

* 未正确使用对象池的空闲队列行为（LIFO“后进先出”栈方式）

* “关闭集群链接时异常导致连接泄漏”问题


修改配置：

```Java
private static Dictionary<Integer, JedisPool> pools = new Hashtable();

static {
    JedisPoolConfig config = new JedisPoolConfig();
    config.setMaxTotal(200);
    config.setMaxIdle(50);
    /*设置最小空闲数,在并发量不高时可以降低最小空闲数*/
    config.setMinIdle(8);
    config.setMaxWaitMillis(10000);
    config.setTestOnBorrow(true);
    config.setTestOnReturn(true); //Idle时进行连接扫描
    config.setTestWhileIdle(true); //表示idle object evitor两次扫描之间要sleep的毫秒数
    config.setTimeBetweenEvictionRunsMillis(30000); //表示idle object evitor每次扫描的最多的对象数
    config.setNumTestsPerEvictionRun(10); //表示一个对象至少停留在idle状态的最短时间，然后才能被idle object evitor扫描并驱逐；这一项只有在timeBetweenEvictionRunsMillis大于0时才有意义
    config.setMinEvictableIdleTimeMillis(60000);
    //循环创建16个redis数据库连接池,存放在字典里面
    for (int i = 0; i < 2; i++) {
        JedisPool item = new JedisPool(config, "127.0.0.1", 6379, 0);
        pools.put(i, item);
    }
}
```
使用命令`client-cli.exe info clients`查看客户端的连接数量时，一般为最小空闲连接数量与客户端数量之和。比如查看客户端连接数量为17，设置的最小空闲连接数量是8，有2个连接池，即为16，加一个当前客户端的连接，刚好17个连接。此处`Could not get a resource from the pool`错误的原因是在打开了连接之后未关闭连接，此处使用的Redis版本为3.2.100 for Windows。

```Java
/**
* 获取数据
*
* @param key //key
* @param db  //数据库序号
*/
public static String get(String key, Integer db) {
    JedisPool poolItem = pools.get(db);
    Jedis jredis = null;
    String result = null;
    try {
        jredis = poolItem.getResource();
        result = jredis.get(key);
    } catch (Exception e) {
        log.error("get value error", e);
    } finally {
        if (jredis != null) {
        	/*
            关闭Redis连接，ReturnResource方法已经标记为Deprecated
            新的关闭连接的方式为直接调用close方法
            */
            jredis.close();
        }
    }
    return result;
}
```

#### Redis配置是否正确绑定

在Redis的配置文件中：


```
#
# ~~~ WARNING ~~~ If the computer running Redis is directly exposed to the
# internet, binding to all the interfaces is dangerous and will expose the
# instance to everybody on the internet. So by default we uncomment the
# following bind directive, that will force Redis to listen only into
# the IPv4 lookback interface address (this means Redis will be able to
# accept connections only from clients running into the same computer it
# is running).
#
# IF YOU ARE SURE YOU WANT YOUR INSTANCE TO LISTEN TO ALL THE INTERFACES
# JUST COMMENT THE FOLLOWING LINE.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bind 192.168.24.252
```

bind的地址如果和程序中配置的地址不一致，也会提示此错误。在Linux里，如果没有指定配置文件，则会使用默认的配置文件，所以在修改了配置文件之后，启动Redis服务的时候显示的指定使用修改后的配置文件：

```Bash
./redis-server ../redis.conf &
```

参考资料：

[Jedis - When to use returnBrokenResource()](http://stackoverflow.com/questions/17082163/jedis-when-to-use-returnbrokenresource)

