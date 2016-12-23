---
title: Java泛型实现原理
date: 2016-12-21 22:50:25
tags:
- Java
- Generate
categories: Programming
---


泛型编程是一种通过参数化的方式将数据处理与数据类型解耦的技术，通过对数据类型施加约束（比如Java中的有界类型）来保证数据处理的正确性，又称参数类型或参数多态性。泛型最著名的应用就是容器，C++的STL、Java的Collection Framework。

<!-- more -->

不同的语言在实现泛型时采用的方式不同，C++的模板会在编译时根据参数类型的不同生成不同的代码，而Java的泛型是一种违反型，编译为字节码时参数类型会在代码中被擦除，单独记录在Class文件的attributes域内，而在使用泛型处做类型检查与类型转换。假设参数类型的占位符为T，擦除规则如下：

* 泛型<T>擦除后变为Obecjt
* <? extends A>擦除后变为A
* <？ super A>擦除后变为Object

上述擦除规则叫做保留上界。
