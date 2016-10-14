---
title: Stomp WebSocket路由
tags:
- stomp
- WebSocket
- url route
categories: Programming
---

WebSocket协议的应用层子协议STOMP（流文本定向消息协议）。在应用中直接使用WebSocket API显得有些低端，直到统一标准规范时也只有一小部分框架可以解析信息或通过注解方式使用它。这正是考虑在应用中运用子协议和产生基于WebSocket支持的Spring的STOMP的原因。当运用一个上层协议，WebSocket API的细节就显得不那么重要了，正如运用了HTTP后TCP的通信细节不再暴漏在应用中一样。STOMP是为了简单而创建的一种消息协议。它基于模仿HTTP协议的帧。帧由一个命令、可选的头和可选的体组成。

#### 服务端启动代理中继

```Java
@Override
public void configureMessageBroker(MessageBrokerRegistry config) {
    /**
     * 启用了 STOMP 代理中继功能： 并将其目的地前缀设置为 "/topic"；
     * spring就能知道 所有目的地前缀为 "/topic" 的消息都会发送到 STOMP 代理中；
     */
    config.enableSimpleBroker("/topic");
    /**
     * 方法第二行设置了 应用的前缀为 "app"：所有目的地以 "/app" 打头的消息（发送消息url not 连接url）
     * 都会路由到 带有 @MessageMapping 注解的方法中，而不会发布到 代理队列或主题中；
     */
    config.setApplicationDestinationPrefixes("/app");
}
```


#### 浏览器端



#### 服务端

[STOMP Over WebSocket]
[STOMP Over WebSocket]:http://jmesnil.net/stomp-websocket/doc/
