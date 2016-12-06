---
title: Websocket发送消息长度设置
tags:
- WebSocket
categories: Programming
---

项目中用到WebSocket技术，发送文本字节比较多时出现异常，立即断开了连接。项目在Tomcat上运行，Tomcat默认的文本大小为8192。

<!-- more -->

{% asset_img websocket-disconnect-exception.png WebSocket异常断开连接%}

```
If the application does not define a MessageHandler.Partial for incoming text messages, any incoming text messages must be buffered so the entire message can be delivered in a single call to the registered MessageHandler.Whole for text messages. The default buffer size for text messages is 8192 bytes. This may be changed for a web application by setting the servlet context initialization parameter org.apache.tomcat.websocket.textBufferSize to the desired value in bytes.
```

在项目Tomcat的web.xml(`D:\Source\zwnewplatform\javasoftware\runtime\apache-tomcat-8.0.36\apache-tomcat-8.0.36\conf\web.xml`)中添加如下配置（注意单位为byte）。


```XML
<context-param>
    <param-name>org.apache.tomcat.websocket.textBufferSize</param-name>
    <param-value>327680</param-value>
</context-param>
<context-param>
    <param-name>org.apache.tomcat.websocket.binaryBufferSize</param-name>
    <param-value>327680</param-value>
</context-param>
```


如果是Eclipse，则直接在Eclipse中配置，如下图所示：

{% asset_img eclipse-websocket-message.png Eclipse配置WebSocket消息大小%}
