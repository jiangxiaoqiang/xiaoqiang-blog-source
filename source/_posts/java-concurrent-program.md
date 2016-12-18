---
title: Java并发编程：Callable、Future和FutureTask
date: 2016-12-18 14:54:39
tags:
- Java
- Concurrent
categories: Programming
---

创建线程的2种方式，一种是直接继承Thread，另外一种就是实现Runnable接口。这2种方式都有一个缺陷就是：在执行完任务之后无法获取执行结果。如果需要获取执行结果，就必须通过共享变量或者使用线程通信的方式来达到效果，这样使用起来就比较麻烦。而自从Java 1.5开始，就提供了Callable和Future，通过它们可以在任务执行完毕之后得到任务执行结果。

<!-- more -->

#### Callable与Runnable

#### Future
多线程开发中有几个痛点：

* 主线程如何正确的关闭异步线程？
* 主线程怎么知道异步线程是否执行完成？

Future提供了三种功能：

　　1）判断任务是否完成；

　　2）能够中断任务；

　　3）能够获取任务执行结果。

#### FutureTask

参考文章：

* [Java - 使用Future模式进行多线程编程](http://gavinliu.cn/2015/12/14/Java-%E4%BD%BF%E7%94%A8Future%E8%BF%9B%E8%A1%8C%E5%A4%9A%E7%BA%BF%E7%A8%8B%E7%BC%96%E7%A8%8B/)

* [Java线程(七)：Callable和Future](http://blog.csdn.net/ghsau/article/details/7451464)
