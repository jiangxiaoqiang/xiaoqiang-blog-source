---
title: redis-client-connect
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

可以看出目前的客户端已经超出了最大的客户端数量(配置的是10个)。应该是没有释放连接导致的问题。明显一个请求一次连接是很不靠谱的。这个问题发生有两方面的原因：

* 未正确使用对象池的空闲队列行为（LIFO“后进先出”栈方式）

* “关闭集群链接时异常导致连接泄漏”问题

修改配置可以暂时解决：

```Java
private static Dictionary<Integer, JedisPool> pools = new Hashtable();

static {
    JedisPoolConfig config = new JedisPoolConfig();
    config.setMaxIdle(2);
    config.setMaxTotal(100);
    config.setTestOnBorrow(true);
    config.setMinIdle(30);
    config.setLifo(true);
    config.setTimeBetweenEvictionRunsMillis(1);
    config.setNumTestsPerEvictionRun(10);
    config.setMinEvictableIdleTimeMillis(5);
    config.setMaxWaitMillis(2000);
    //循环创建16个redis数据库连接池,存放在字典里面
    for (int i = 0; i < 16; i++) {
        JedisPool item = new JedisPool(config, "127.0.0.1", 6379, 10 * 1000);
        pools.put(i, item);
    }
}
```

