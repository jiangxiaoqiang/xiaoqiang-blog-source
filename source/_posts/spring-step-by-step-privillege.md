---
title: spring-step-by-step（三）-权限管理
tags:
  - Spring
categories: Programmming
date: 2016-11-29 16:16:45
---


#### 配置过滤器

为了在项目中使用Spring Security控制权限，在项目的web.xml文件中，添加过滤器，就可以控制对这个项目的每个请求了。

<!-- more -->

```XML
<filter>
    <filter-name>springSecurityFilterChain</filter-name>
    <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
</filter>
<filter-mapping>
    <filter-name>springSecurityFilterChain</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

#### Spring Security数据库表

Spring Security默认情况下需要两张表，用户表和权限表。以下是mysql中的建表语句：




[一个简单的HelloWorld](http://www.mossle.com:8080/docs/auth/html/ch001-helloworld.html)

