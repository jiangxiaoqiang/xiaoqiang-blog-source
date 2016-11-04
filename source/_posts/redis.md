---
title: Redis在Windows下配置
tags:
- Redis
categories: Programming
date: 2016-11-01 11:22:57
---

#### 简介

Redis是一个开源的使用ANSI C语言编写、支持网络、可基于内存亦可持久化的日志型、Key-Value数据库，并提供多种语言的API，其实当前最热门的NoSQL数据库之一，NoSQL还包括了Memcached和mongodb。

<!-- more -->

#### 下载安装

下载在[这里](https://github.com/MSOpenTech/redis/releases)，这里下载的版本是：`Redis-x64-3.2.100.msi`。下载完毕后安装即可。安装Redis的目录`D:\Program Files\Redis`。启动Redis Service服务:

```Bash
#切换到Redis目录
cd /d D:\Program Files\Redis
#启动Redis服务
redis-server.exe redis.windows-service.conf
```

双击打开 redis-cli.exe , 如果不报错,则连接上了本地服务器,然后测试，比如 set命令，get命令，如下图所示。

{% asset_img redis-client-test.jpg Redis客户端%}

#### Java连接Redis

引入Client jar包，在Maven中引入配置：

```
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>2.8.1</version>
    <type>jar</type>
    <scope>compile</scope>
</dependency>
```

编写Java测试代码：

```Java
package com;

import redis.clients.jedis.Jedis;

/*
 * Created by jiangxiaoqiang on 2016/11/1.
 */
public class RedisServiceTest {
    public static void main(String[] args) {
        //连接本地的 Redis 服务
        Jedis jedis = new Jedis("localhost");
        System.out.println("Connection to server sucessfully");
        //查看服务是否运行
        System.out.println("Server is running: "+jedis.ping());
    }
}
```

#### 连接



```Java
static {
    JedisPoolConfig config = new JedisPoolConfig();
    config.setMaxIdle(2);
    config.setMaxTotal(10);
    config.setTestOnBorrow(true);
    config.setMaxWaitMillis(2000);
    //循环创建16个redis数据库连接池,存放在字典里面
    for (int i = 0; i < 16; i++) {
        JedisPool item  = new JedisPool(config, "127.0.0.1", 6379,10*1000);
        pools.put(i, item);
    }
}
```


