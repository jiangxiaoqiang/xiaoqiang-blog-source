---
title: Netty原理
date: 2016-12-13 23:07:35
tags:
- Netty
categories: Programming
---

Netty是一个高性能 事件驱动的异步的非堵塞的IO(NIO)框架，用于建立TCP等底层的连接，基于Netty可以建立高性能的Http服务器。支持HTTP、 WebSocket 、Protobuf、 Binary TCP |和UDP，Netty已经被很多高性能项目作为其Socket底层基础，如HornetQ Infinispan Vert.x
Play Framework Finangle和 Cassandra。其竞争对手是：Apache MINA和 Grizzly。

<!-- more -->

作为当前最流行的NIO框架，Netty在互联网领域、大数据分布式计算领域、游戏行业、通信行业等获得了广泛的应用，一些业界著名的开源组件也基于Netty的NIO框架构建。

#### 异步非阻塞通信

在IO编程过程中，当需要同时处理多个客户端接入请求时，可以利用多线程或者IO多路复用技术进行处理。IO多路复用技术通过把多个IO的阻塞复用到同一个select的阻塞上，从而使得系统在单线程的情况下可以同时处理多个客户端请求。与传统的多线程/多进程模型比，I/O多路复用的最大优势是系统开销小，系统不需要创建新的额外进程或者线程，也不需要维护这些进程和线程的运行，降低了系统的维护工作量，节省了系统资源。

JDK1.4提供了对非阻塞IO（NIO）的支持，JDK1.5_update10版本使用epoll替代了传统的select/poll，极大的提升了NIO通信的性能。


#### 零拷贝

Netty的“零拷贝”主要体现在如下三个方面：

1) Netty的接收和发送ByteBuffer采用DIRECT BUFFERS，使用堆外直接内存进行Socket读写，不需要进行字节缓冲区的二次拷贝。如果使用传统的堆内存（HEAP BUFFERS）进行Socket读写，JVM会将堆内存Buffer拷贝一份到直接内存中，然后才写入Socket中。相比于堆外直接内存，消息在发送过程中多了一次缓冲区的内存拷贝。

2) Netty提供了组合Buffer对象，可以聚合多个ByteBuffer对象，用户可以像操作一个Buffer那样方便的对组合Buffer进行操作，避免了传统通过内存拷贝的方式将几个小Buffer合并成一个大的Buffer。

3) Netty的文件传输采用了transferTo方法，它可以直接将文件缓冲区的数据发送到目标Channel，避免了传统通过循环write方式导致的内存拷贝问题。

#### 内存池


#### 高效的Reactor线程模型


#### 无锁化的串行设计理念

#### 高效的并发编程

参考文章：

[Netty系列之Netty高性能之道](http://www.infoq.com/cn/articles/netty-high-performance)
