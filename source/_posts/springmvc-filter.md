---
title: Spring MVC拦截规则
date: 2016-12-01 11:39:18
tags:
- Spring MVC
categories: Programming
---

在Spring MVC中，需要配置Mapping规则。

<!-- more -->

#### 拦截*.do、*.htm

这是最传统的方式，最简单也最实用。不会导致静态文件（jpg,js,css）被拦截。

```XML
<servlet-mapping>
    <servlet-name>dolphin</servlet-name>
    <url-pattern>*.do</url-pattern>
</servlet-mapping>
```

#### 拦截/

```XML
<servlet-mapping>
    <servlet-name>dolphin</servlet-name>
    <url-pattern>/</url-pattern>
</servlet-mapping>
```

可以实现现在很流行的REST风格。很多互联网类型的应用很喜欢这种风格的URL。

弊端：会导致静态文件（jpg,js,css）被拦截后不能正常显示。想实现REST风格，事情就是麻烦一些。后面有解决办法还算简单。

#### 拦截/*


```XML
<servlet-mapping>
    <servlet-name>dolphin</servlet-name>
    <url-pattern>/*</url-pattern>
</servlet-mapping>
```

这是一个错误的方式，请求可以通过DispatcherServlet走到Action中，但是返回的内容，如返回的jsp还会再次被拦截，这样导致404错误，即访问不到jsp，也无法访问到html静态页面。
