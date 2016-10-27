---
title: WebSocket连接(SessionConnectEvent)、断开连接(SessionDisconnectEvent)事件
tags:
  - WebSocket
categories: Programming
date: 2016-10-27 10:51:45
---


WebSocket事件：SessionConnectEvent(连接时), SessionConnectedEvent(连接后), SessionDisconnectEvent(断开连接)。

```Java
public class WebSocketDisconnectHandler implements ApplicationListener<SessionDisconnectEvent> {

    @Override
    public void onApplicationEvent(SessionDisconnectEvent sessionDisconnectEvent) {
        StompHeaderAccessor stompHeaderAccessor = StompHeaderAccessor.wrap(sessionDisconnectEvent.getMessage());
        //do something
    }
}
```

添加了断开连接实现类后的逻辑后，还需要注入Bean，否则不会生效。在相关配置文件(<code>spring-socket-servlet.xml</code>)中增加如下配置即可。

```XML
<bean class="com.zw.socket.service.config.WebSocketDisconnectHandler"></bean>
```
