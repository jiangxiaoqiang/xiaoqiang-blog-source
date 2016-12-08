---
title: MyBatis使用
date: 2016-12-02 19:13:59
tags:
- MyBatis
categories: Programming
---

#### MyBatis缓存

正如大多数持久层框架一样，MyBatis 同样提供了一级缓存和二级缓存的支持；

<!-- more -->

一级缓存基于 PerpetualCache 的 HashMap 本地缓存，其存储作用域为 Session，当 Session flush 或 close 之后，该Session中的所有 Cache 就将清空。
二级缓存与一级缓存其机制相同，默认也是采用 PerpetualCache，HashMap存储，不同在于其存储作用域为 Mapper(Namespace)，并且可自定义存储源，如 Ehcache、Hazelcast等。
对于缓存数据更新机制，当某一个作用域(一级缓存Session/二级缓存Namespaces)的进行了 C/U/D 操作后，默认该作用域下所有 select 中的缓存将被clear。
MyBatis 的缓存采用了delegate机制 及 装饰器模式设计，当put、get、remove时，其中会经过多层 delegate cache 处理，其Cache类别有：BaseCache(基础缓存)、EvictionCache(排除算法缓存) 、DecoratorCache(装饰器缓存)：
* BaseCache:为缓存数据最终存储的处理类，默认为 PerpetualCache，基于Map存储；可自定义存储处理，如基于EhCache、Memcached等；
* EvictionCache:当缓存数量达到一定大小后，将通过算法对缓存数据进行清除。默认采用 Lru 算法(LruCache)，提供有 fifo 算法(FifoCache)等；
* DecoratorCache：缓存put/get处理前后的装饰器，如使用 LoggingCache 输出缓存命中日志信息、使用 SerializedCache 对 Cache的数据 put或get 进行序列化及反序列化处理、当设置flushInterval(默认1/h)后，则使用 ScheduledCache 对缓存数据进行定时刷新等。

<<<<<<< HEAD
一般缓存框架的数据结构基本上都是 Key-Value 方式存储，MyBatis 对于其 Key 的生成采取规则为：[hashcode : checksum : mappedStementId : offset : limit : executeSql : queryParams]。
对于并发 Read/Write 时缓存数据的同步问题，MyBatis 默认基于 JDK/concurrent中的ReadWriteLock，使用 ReentrantReadWriteLock 的实现，从而通过 Lock 机制防止在并发 Write Cache 过程中线程安全问题。

#### MyBatis延迟加载



#### MyBatis打印出SQL

* 在方法上添加MethodLog注解即可，如下图所示。

{% asset_img mybatis-logging.png MyBatis输出日志%}


* properties文件配置

将ibatis log4j运行级别调到DEBUG可以在控制台打印出ibatis运行的sql语句,方便调试: 

```
### 设置Logger输出级别和输出目的地 ###
log4j.rootLogger=debug,stdout,logfile


### 把日志信息输出到控制台 ###
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
#log4j.appender.stdout.Target=System.err
log4j.appender.stdout.layout=org.apache.log4j.SimpleLayout


### 把日志信息输出到文件：jbit.log ###
log4j.appender.logfile=org.apache.log4j.FileAppender
log4j.appender.logfile.File=jbit.log
log4j.appender.logfile.layout=org.apache.log4j.PatternLayout
log4j.appender.logfile.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} %F %p %m%n


###显示SQL语句部分
log4j.logger.com.ibatis=DEBUG 
log4j.logger.com.ibatis.common.jdbc.SimpleDataSource=DEBUG 
log4j.logger.com.ibatis.common.jdbc.ScriptRunner=DEBUG 
log4j.logger.com.ibatis.sqlmap.engine.impl.SqlMapClientDelegate=DEBUG 
log4j.logger.java.sql.Connection=DEBUG 
log4j.logger.java.sql.Statement=DEBUG 
log4j.logger.java.sql.PreparedStatement=DEBUG
```

* xml文件配置

```XML
<!-- 调试sql日志 -->
<Logger name="com.ibatis" level="info">
    <AppenderRef ref="Console" />
</Logger>
<Logger name="com.ibatis.common.jdbc.SimpleDataSource" level="info">
    <AppenderRef ref="Console" />
</Logger>
<Logger name="org.apache.ibatis.jdbc.ScriptRunner" level="info">
    <AppenderRef ref="Console" />
</Logger>
<Logger name="com.ibatis.sqlmap.engine.impl.SqlMapClientDelegate"
    level="info">
    <AppenderRef ref="Console" />
</Logger>
<Logger name="java.sql.Connection" level="DEBUG">
    <AppenderRef ref="Console" />
</Logger>
<Logger name="java.sql.Statement" level="DEBUG">
    <AppenderRef ref="Console" />
</Logger>
<Logger name="java.sql.PreparedStatement" level="DEBUG">
    <AppenderRef ref="Console" />
</Logger>
```


=======
一般缓存框架的数据结构基本上都是 Key-Value 方式存储，MyBatis 对于其 Key 的生成采取规则为：[hashcode : checksum : mappedStementId : offset : limit : executeSql : queryParams]。对于并发 Read/Write 时缓存数据的同步问题，MyBatis 默认基于 JDK/concurrent中的ReadWriteLock，使用 ReentrantReadWriteLock 的实现，从而通过 Lock 机制防止在并发 Write Cache 过程中线程安全问题。
>>>>>>> bdc53dc27ab592072cdf63f4d5aa23d2d8717049
