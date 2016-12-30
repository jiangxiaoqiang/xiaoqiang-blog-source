---
title: Java中synchronized、reentrantlock、lock区别
date: 2016-12-30 22:43:41
tags:
- Java
- synchronized
categories: Programming
---


#### synchronized



#### reentrantlock

与目前的 synchronized 实现相比，争用下的 ReentrantLock 实现更具可伸缩性。（在未来的 JVM 版本中，synchronized 的争用性能很有可能会获得提高。）这意味着当许多线程都在争用同一个锁时，使用 ReentrantLock 的总体开支通常要比 synchronized 少得多。eentrantLock 构造器的一个参数是 boolean 值，它允许您选择想要一个 公平（fair）锁，还是一个 不公平（unfair）锁。公平锁使线程按照请求锁的顺序依次获得锁；而不公平锁则允许讨价还价，在这种情况下，线程有时可以比先请求锁的其他线程先得到锁。为什么我们不让所有的锁都公平呢？毕竟，公平是好事，不公平是不好的，不是吗？（当孩子们想要一个决定时，总会叫嚷“这不公平”。我们认为公平非常重要，孩子们也知道。）在现实中，公平保证了锁是非常健壮的锁，有很大的性能成本。要确保公平所需要的记帐（bookkeeping）和同步，就意味着被争夺的公平锁要比不公平锁的吞吐率更低。作为默认设置，应当把公平设置为 false ，除非公平对您的算法至关重要，需要严格按照线程排队的顺序对其进行服务。

#### lock

Lock 和 synchronized 有一点明显的区别 —— lock 必须在 finally 块中释放。否则，如果受保护的代码将抛出异常，锁就有可能永远得不到释放！这一点区别看起来可能没什么，但是实际上，它极为重要。忘记在 finally 块中释放锁，可能会在程序中留下一个定时炸弹，当有一天炸弹爆炸时，您要花费很大力气才有找到源头在哪。而使用同步，JVM 将确保锁会获得自动释放。