---
title: Spring step by step--集成Spring MVC
tags: Spring MVC
---

#### 配置DispatcherServlet

在web.xml中配置一个DispatcherServlet，并通过<servlet-mapping>指定需要拦截的url。

```XML
<display-name>Dolphin</display-name>
<context-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>classpath:spring-config/spring-base.xml</param-value>
</context-param>
<listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
<servlet>
    <servlet-name>dolphin</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:spring-servlet.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
</servlet>
<servlet-mapping>
    <servlet-name>dolphin</servlet-name>
    <url-pattern>/</url-pattern>
</servlet-mapping>
```

拦截*.do、*.htm， 例如：/user/add.do,这是最传统的方式，最简单也最实用。不会导致静态文件（jpg,js,css）被拦截。拦截/，例如：/user/add,可以实现现在很流行的REST风格。很多互联网类型的应用很喜欢这种风格的URL。弊端：会导致静态文件（jpg,js,css）被拦截后不能正常显示。想实现REST风格，事情就是麻烦一些。后面有解决办法还算简单。拦截/*，这是一个错误的方式，请求可以走到Action中，但转到jsp时再次被拦截，不能访问到jsp。

#### 





