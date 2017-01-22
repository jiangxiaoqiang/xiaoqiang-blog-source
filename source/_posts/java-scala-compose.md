---
title: Java与Scala混合编程
date: 2017-01-22 14:19:52
tags:
- Scala
- Java
categories: Programming
---

#### Scala特点

* 可扩展(A Scalable language):Scala is an acronym for “Scalable Language”. This means that Scala grows with you. You can play with it by typing one-line expressions and observing the results. 

* 面向对象(Object-Oriented):Scala is a pure-bred object-oriented language. Conceptually, every value is an object and every operation is a method-call. The language supports advanced component architectures through classes and traits.

* 函数式编程(Functional):

* 类型推断(Type Inference)

* 省去异常检查(Unchecked Exception):不用写try catch了。

<!-- more -->

#### 在Java中调用Scala

在Intellij Idea中，Java中调用Scala，需要安装Scala插件，新建相应的Scala文件，写好类与方法之后，在Java类中引入相应的Scala命名空间，即可使用Scala中的方法。


参考资料：

* [what is scala](https://www.scala-lang.org/what-is-scala.html)