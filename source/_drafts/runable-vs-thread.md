---
title: Java中Runable和Thread的区别
tags: Thread
---

多线程编程优点：进程之间不能共享内存，但线程之间共享内存非常容易。系统创建线程所分配的资源相对创建进程而言，代价非常小。Java中实现多线程有3种方法：

* 继承Thread类

* 实现Runnable接口

* 实现Callable接口

直接继承Thread类有一个很大的缺点，因为“java类的继承是单一的，extends后面只能指定一个父类”，所有如果当前类继承Thread类之后就不可以继承其他类。如果我们的类已经从一个类继承（如Swing继承自 Panle 类、JFram类等），则无法再继承 Thread 类

参考：

[java多线程—Runnable、Thread、Callable区别]

[java多线程—Runnable、Thread、Callable区别]:http://www.cnblogs.com/sasuke-y/p/5677964.html