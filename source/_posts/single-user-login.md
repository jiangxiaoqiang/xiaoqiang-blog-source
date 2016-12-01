---
title: Spring中单用户登录
tags:
  - single user
categories: Programming
date: 2016-11-23 16:32:04
---


在`web.xml`文件的配置如下：

```XML
<listener>
    <listener-class>
        org.springframework.security.web.session.HttpSessionEventPublisher
    </listener-class>
</listener>
```

<!-- more -->

单用户登录，当其他用户登录时，自动退出，在`Spring-Security.xml`中作如下配置：

```XML
<!-- 配置SpringSecurity的http安全服务 -->
<sec:session-management invalid-session-url="/login?type=expired">
    <!-- 单用户登陆  -->
    <!-- 仅配置max-sessions="1",则第二次登录会让第一次登录失效。 -->
    <!-- 同时配置max-sessions="1" error-if-maximum-exceeded="true"，则可以防止第二次登录-->
    <!-- max-sessions="1" 其中1表示一个帐号可同时登录的次数  -->
    <sec:concurrency-control max-sessions="1" error-if-maximum-exceeded="false" expired-url="/login?type=expired"
    />
</sec:session-management>
```

在标签中加入concurrency-control配置，设置max-sessions=1。当另一个用户登录之后，当前用户操作时会自动跳转到登录页面。

