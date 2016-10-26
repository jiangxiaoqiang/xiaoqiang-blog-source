---
title: Stomp + WebSocket消息实时推送
tags:
  - stomp
  - websocket
  - spring
categories: Programming
date: 2016-10-25 21:40:58
---


#### 消息广播

消息广播将消息发送给所有用户。

```Java
/*
 * 推送给所有用户
 */
private void pushInfoImpl(String url, String content) {
    if (simpMessagingTemplate != null) {
        simpMessagingTemplate.convertAndSend(url, content);
    }
}
```


#### 推送给指定用户



```Java
/*
 * 推送给指定用户
 */
private void pushInfoImpl(String user, String url, String content) {
    if (simpMessagingTemplate != null) {
        simpMessagingTemplate.convertAndSendToUser(user, url, content);
    }
}
```

url直接为<code>/location</code>，在发给客户端的时，会自动添加user前缀和用户名，客户端订阅的url像这样：<code>/user/admin/location</code>，订阅的url中，不包含topic。content为需要发送的消息的内容。

#### 客户端

客户端订阅消息如下代码片段所示：

```Javascript
stompClient.subscribe('/user/admin/location/', function (greeting) {
    console.log('接收到订阅的信息：' + greeting.body);
});
```

客户端订阅的URL中，admin是用户名。发送给指定用户时会默认添加user前缀。