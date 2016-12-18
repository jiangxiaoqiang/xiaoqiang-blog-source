---
title: Java concurrent包
date: 2016-12-18 16:34:33
tags:
- Java
- concurrent
categories: Programming
---

#### 简介

 java.util.concurrent 包含许多线程安全、测试良好、高性能的并发构建块。不客气地说，创建 java.util.concurrent 的目的就是要实现 Collection 框架对数据结构所执行的并发操作。通过提供一组可靠的、高性能并发构建块，开发人员可以提高并发类的线程安全、可伸缩性、性能、可读性和可靠性。

<!-- more -->

通常所说的concurrent包基本有3个package组成  
* java.util.concurrent：提供大部分关于并发的接口和类，如BlockingQueue,Callable,ConcurrentHashMap,ExecutorService, Semaphore等  
* java.util.concurrent.atomic：提供所有原子操作的类， 如AtomicInteger, AtomicLong等；  
* java.util.concurrent.locks:提供锁相关的类, 如Lock, ReentrantLock, ReadWriteLock, Condition等；

参考文章：


* [Java concurrent包介绍及使用](https://my.oschina.net/yu120/blog/689204)
* [java.util.concurrent介绍](http://www.cnblogs.com/sarafill/archive/2011/05/18/2049461.html)
