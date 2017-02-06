---
title: Hotspot JVM选项
date: 2017-02-05 20:57:33
tags:
- Hotspot JVM
categories: Java Virtual Machine
---

#### Hotspot JVM选项分类

Hotspot JVM提供以下三大类选项： 

<!-- more -->

1. 标准选项：这类选项的功能是很稳定的，在后续版本中也不太会发生变化。运行java或者java -help可以看到所有的标准选项。所有的标准选项都是以-开头，比如-version， -server等。 
2. X选项(X自己把它理解成Execute的含义)：比如-Xms(Max Execute Stack)。这类选项都是以-X开头，可能由于这个原因它们被称为X选项。运行java -X命令可以看到所有的X选项。这类选项的功能还是很稳定，但官方的说法是它们的行为可能会在后续版本中改变，也有可能不在后续版本中提供了。 
3. XX(自己把它理解成Extened Execute)选项：这类选项是属于实验性，主要是给JVM开发者用于开发和调试JVM的，在后续的版本中行为有可能会变化。

#### XX选项语法

* 如果是布尔类型的选项，它的格式为-XX:+flag或者-XX:-flag，分别表示开启和关闭该选项。
* 针对非布尔类型的选项，它的格式为-XX:flag=value

#### 指定JIT编译器的模式：-Xint，-Xcomp，-Xmixed

Java是一种解释型语言，但是随着JIT技术的进步，它能在运行时将Java的字节码编译成本地代码。以下是几个相关的选项：

-Xint表示禁用JIT，所有字节码都被解释执行，这个模式的速度最慢的。
-Xcomp表示所有字节码都首先被编译成本地代码，然后再执行。
-Xmixed，默认模式，让JIT根据程序运行的情况，有选择地将某些代码编译成本地代码。 
-Xcomp和-Xmixed到底谁的速度快，针对不同的程序可能有不同的结果，基本还是推荐用默认模式。

#### 查看XX选项的值

与-showversion类似，-XX:+PrintCommandLineFlags可以让在程序运行前打印出用户手动设置或者JVM自动设置的XX选项，建议加上这个选项以辅助问题诊断。比如在我的机器上，JVM自动给配置了初始的和最大的HeapSize以及其他的一些选项：

```
$ java -XX:+PrintCommandLineFlags -version
-XX:InitialHeapSize=134217728 -XX:MaxHeapSize=2147483648 -XX:+PrintCommandLineFlags -XX:+UseCompressedOops -XX:+UseParallelGC
java version "1.7.0_71"
Java(TM) SE Runtime Environment (build 1.7.0_71-b14)
Java HotSpot(TM) 64-Bit Server VM (build 24.71-b01, mixed mode)
```

相关另外两个选项：-XX:+PrintFlagsInitial表示打印出所有XX选项的默认值，-XX:+PrintFlagsFinal表示打印出XX选项在运行程序时生效的值。


内容来自：

* [Hotspot JVM的常用选项](https://www.zybuluo.com/jewes/note/57352)

