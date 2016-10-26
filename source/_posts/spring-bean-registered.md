---
title: Spring Bean是否注册判断
tags:
  - Spring
  - Bean
categories: Programming
date: 2016-10-18 21:31:26
---


在项目的开发过程中有许多Bean，怎么判断一个Bean是否已经纳入容器管理了呢？当然最直接的方式是直接使用，如果不能用，那么肯定就未注册成功，但是也有的情况不是那么明显的，即使没有注册成功也不会有明显的错误。如何有效的鉴别和判断是否已经注册？

<!-- more -->

#### 日志

在项目启动时会输出日志，提示注册了哪些Bean，那么只需要使用Bean的名称，在日志里面搜索一遍，即可知晓Bean是否已经注册，如果有相关注册成功输出提示，那么代表注册OK，如果没有相关日志，此时就需要排查Bean的配置了。

#### 方法获取Bean

可以通过如下方法获取特定注解的Bean的集合：

```Bash
Map<String,Object> beans = applicationContext.getBeansWithAnnotation(Foo.class);
```

其中Foo代表@Autowired、@Controller等等注解。


[Is there any way to query bean of spring container]
[Is there any way to query bean of spring container]:http://stackoverflow.com/questions/40108153/is-there-any-way-to-query-bean-of-spring-container?noredirect=1#comment67489885_40108153
