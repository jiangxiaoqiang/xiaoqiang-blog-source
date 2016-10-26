---
title: expected single matching bean but found 2
tags:
  - Java
  - Spring
categories: Programming
date: 2016-10-20 12:51:20
---



在WebSocket往客户端推送消息的开发过程中，获取推送消息实例<code>SimpMessagingTemplate</code>时，错误如下：

```
[ERROR]-[2016年-10月-19日17:53:25.026]-[RMI TCP Connection(2)-127.0.0.1]-[org.springframework.web.context.ContextLoader]-{Context initialization failed} org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name  'com.zw.socket.service.controller.InstanceMessageController#0' defined in class path resource [spring-config/spring-socket-servlet.xml]: Unsatisfied dependency expressed through constructor parameter 0; nested exception is org.springframework.beans.factory.NoUniqueBeanDefinitionException: No qualifying bean of type [org.springframework.messaging.simp.SimpMessagingTemplate] is defined: expected single matching bean but found 2:org.springframework.messaging.simp.SimpMessagingTemplate#0,brokerMessagingTemplate
```

<!-- more -->

发生此错误的原因是在配置文件<code>spring-socket-servlet.xml</code>里重复做了如下配置：

```XML
<websocket:message-broker application-destination-prefix="/app">
    <websocket:stomp-endpoint path="/vehicle">
        <websocket:handshake-interceptors>
            <bean class="org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor"/>
        </websocket:handshake-interceptors>
        <websocket:sockjs session-cookie-needed="true" />
    </websocket:stomp-endpoint>
    <websocket:simple-broker prefix="/topic"/>
</websocket:message-broker>
```
扫描配置文件时会自动生成一个<code>brokerMessagingTemplate</code>实例，与实例<code>simpMessagingTemplate</code>冲突。解决的方法就是去掉配置文件中的配置。


参考：

[Could not autowire. No beans of SimpMessagingTemplate type found]
[Could not autowire. No beans of SimpMessagingTemplate type found]:http://stackoverflow.com/questions/22925951/could-not-autowire-no-beans-of-simpmessagingtemplate-type-found

