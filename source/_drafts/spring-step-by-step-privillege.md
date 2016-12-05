---
title: spring-step-by-step（三）-权限管理
tags:
- Spring
categories: Programmming
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

```SQL
CREATE TABLE users(
    username VARCHAR(50) NOT NULL PRIMARY KEY,
    PASSWORD VARCHAR(50) NOT NULL,
    enabled BOOLEAN NOT NULL
);

CREATE TABLE authorities (
    username VARCHAR(50) NOT NULL,
    authority VARCHAR(50) NOT NULL,
    CONSTRAINT fk_authorities_users FOREIGN KEY(username) REFERENCES users(username)
);

CREATE UNIQUE INDEX ix_auth_username ON authorities (username,authority);

INSERT INTO users(username,PASSWORD,enabled) VALUES('admin','admin',TRUE);
INSERT INTO users(username,PASSWORD,enabled) VALUES('user','user',TRUE);

INSERT INTO authorities(username,authority) VALUES('admin','ROLE_ADMIN');
INSERT INTO authorities(username,authority) VALUES('admin','ROLE_USER');
INSERT INTO authorities(username,authority) VALUES('user','ROLE_USER');
```

Spring Security会在初始化时，从这两张表中获得用户信息和对应权限，将这些信息保存到缓存中。其中users表中的登录名和密码用来控制用户的登录，而权限表中的信息用来控制用户登陆后是否有权限访问受保护的系统资源。

* [一个简单的HelloWorld](http://www.mossle.com:8080/docs/auth/html/ch001-helloworld.html)

* [Spring Security Guides](http://docs.spring.io/spring-security/site/docs/current/guides/html5/)
