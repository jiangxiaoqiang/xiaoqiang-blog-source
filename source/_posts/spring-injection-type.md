---
title: Spring注入方式
date: 2016-12-14 22:24:37
tags:
- Injection
- Spring
categories: Programming
---

#### Set注入

这是最简单的注入方式，假设有一个SpringAction，类中需要实例化一个SpringDao对象，那么就可以定义一个private的SpringDao成员变量，然后创建SpringDao的set方法（这是ioc的注入入口）。

<!-- more -->

#### 构造器注入

这种方式的注入是指带有参数的构造函数注入，看下面的例子，我创建了两个成员变量SpringDao和User，但是并未设置对象的set方法，所以就不能支持第一种注入方式，这里的注入方式是在SpringAction的构造函数中注入，也就是说在创建SpringAction对象时要将SpringDao和User两个参数值传进来。

#### 静态工厂的方法注入

#### 实例工厂的方法注入

[Spring四种依赖注入方式](http://blessht.iteye.com/blog/1162131)
