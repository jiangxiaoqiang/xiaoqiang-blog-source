---
title: Java缓存框架
date: 2017-02-21 14:05:10
tags:
- Cache
categories: Programming
---



#### ehCache

EhCache 是一个纯 Java 的进程内缓存框架，具有快速、精干等特点，是 Hibernate 中默认的 CacheProvider。

Ehcache 是一种广泛使用的开源 Java 分布式缓存。主要面向通用缓存,Java EE 和轻量级容器。它具有内存和磁盘存储，缓存加载器,缓存扩展,缓存异常处理程序,一个 gzip 缓存 servlet 过滤器,支持 REST 和SOAP api 等特点。

Ehcache最初是由 Greg Luck 于2003年开始开发。2009年,该项目被 Terracotta 购买。软件仍然是开源,但一些新的主要功能(例如，快速可重启性之间的一致性的)只能在商业产品中使用，例如 Enterprise EHCache and BigMemory。,维基媒体 Foundationannounced 目前使用的就是Ehcache技术。

<!-- more -->

#### EhCache 与 Memcache 和 Redis 之间的区别

EhCache的特点:

- 够快

EhCache 的发行有一段时长了，经过几年的努力和不计其数的性能测试，EhCache 终被设计于large, high concurrency systems。

- 够简单

开发者提供的接口非常简单明了，从 EhCache 的搭建到运用运行仅仅需要的是你宝贵的几分钟。其实很多开发者都不知道自己用在用 EhCache，EhCache 被广泛的运用于其他的开源项目，比如：Hibernate。

- 够袖珍

关于这点的特性，官方给了一个很可爱的名字 small foot print ，一般 EhCache 的发布版本不会到2M，V2.2.3 才 668KB。

- 够轻量

核心程序仅仅依赖 slf4j 这一个日志包.

- 好扩展
- 监听器

Redis的特点:

edis 是在 Memcache 之后编写的，大家经常把这两者做比较，如果说它是个 key-value store 的话但是它具有丰富的数据类型，我想暂时把它叫做缓存数据流中心，就像现在物流中心那样，order、package、store、classification、distribute、end。现在还很流行的 LAMP PHP 架构不知道和 redis+mysql 或者 redis + mongodb 的性能比较。

- 支持持久化

- 丰富的数据类型

- 高性能

- replication

- 更新快

希望简单高效就用 EhCache，如果开发任务比较复杂，就Redis。

参考资料:

[EhCache配置注解及使用介绍](http://www.liuqianfei.com/article/9880835ef8de4d6485b9583940e61166)

