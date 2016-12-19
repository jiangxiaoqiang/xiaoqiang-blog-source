---
title: Spring Boot特点
date: 2016-12-19 22:49:48
tags:
- Spring Boot
categories: Programming
---

#### Spring Boot特点

2013年12月12日，Spring发布了4.0版本。Spring的4.0版本可以说是一个重大的更新，其全面支持Java8，并且对Groovy语言也有良好的支持。另外引入了非常多的新项目，比如Spring boot，Spring Cloud，Spring WebSocket等。Spring由于其繁琐的配置，一度被人成为“配置地狱”，各种XML、Annotation配置，让人眼花缭乱，而且如果出错了也很难找出原因。Spring Boot项目就是为了解决配置繁琐的问题，最大化的实现convention over configuration(约定大于配置)。熟悉Ruby On Rails（ROR框架的程序员都知道，借助于ROR的脚手架工具只需简单的几步即可建立起一个Web应用程序。而Spring Boot就相当于Java平台上的ROR。

<!-- more -->

Spring Boot的特性有以下几条：

* 创建独立Spring应用程序

* 嵌入式Tomcat，Jetty容器，无需部署WAR包

* 简化Maven及Gradle配置

* 尽可能的自动化配置Spring

* 直接植入产品环境下的实用功能，比如度量指标、健康检查及扩展配置等

* 无需代码生成及XML配置

Spring Boot是这几年微服务概念流行后，Spring开发的一套快速开发Spring应用的框架。它本身并不提供Spring框架的核心特性以及扩展功能，只是用于快速、敏捷地开发新一代基于Spring框架的应用程序。也就是说，它并不是用来替代Spring的解决方案，而是和Spring框架紧密结合用于提升Spring开发者体验的工具。同时它集成了大量常用的第三方库配置（例如Jackson, JDBC, Mongo, Redis, Mail等等），Spring Boot应用中这些第三方库几乎可以零配置的开箱即用（out-of-the-box），大部分的Spring Boot应用都只需要非常少量的配置代码，开发者能够更加专注于业务逻辑。

#### @EnableAutoConfiguration

@EnableAutoConfiguration这个注解告诉Spring Boot根据添加的jar依赖猜测你想如何配置Spring。spring-boot-starter-web添加了Tomcat和Spring MVC，所以auto-configuration将假定你正在开发一个web应用并相应地对Spring进行默认设置。

参考资料：

* [spring -boot和spring-mvc是两个平行的框架么?](https://www.tianmaying.com/qa/205)

* [值得使用的Spring Boot](http://www.cnblogs.com/huang0925/p/4347690.html)
