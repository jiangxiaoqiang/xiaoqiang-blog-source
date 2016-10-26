---
title: Stomp WebSocket路由
tags:
  - stomp
  - WebSocket
  - url route
categories: Programming
date: 2016-10-20 22:28:40
---


STOMP即Simple (or Streaming) Text Orientated Messaging Protocol，简单(流)文本定向消息协议，它提供了一个可互操作的连接格式，允许STOMP客户端与任意STOMP消息代理（Broker）进行交互。STOMP协议由于设计简单，易于开发客户端，因此在多种语言和多种平台上得到广泛地应用。WebSocket协议的应用层子协议STOMP（流文本定向消息协议）。在应用中直接使用WebSocket API显得有些低端，直到统一标准规范时也只有一小部分框架可以解析信息或通过注解方式使用它。这正是考虑在应用中运用子协议和产生基于WebSocket支持的Spring的STOMP的原因。当运用一个上层协议，WebSocket API的细节就显得不那么重要了，正如运用了HTTP后TCP的通信细节不再暴漏在应用中一样。STOMP是为了简单而创建的一种消息协议。它基于模仿HTTP协议的帧。帧由一个命令、可选的头和可选的体组成。

<!-- more -->

业务中需要实现不同的消息类别分发，在客户端进行不同的处理。此时想到Stomp的路由。

#### 服务端启动代理中继



```Java
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig extends AbstractWebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        /**
         * 启用了STOMP代理中继功能：并将其目的地前缀设置为 "/topic"；
         * spring就能知道 所有目的地前缀为"/topic" 的消息都会发送到STOMP代理中；
         */
        config.enableSimpleBroker("/topic");
        /**
         * 设置了应用的前缀为"app"：所有目的地以"/app"打头的消息（发送消息url not连接url）
         * 都会路由到带有@MessageMapping注解的方法中，而不会发布到代理队列或主题中；
         */
        config.setApplicationDestinationPrefixes("/app");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/gs-guide-websocket").withSockJS();
    }
}
```

或者以XML文件的方式进行配置，两者是等价的：

```XML
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:websocket="http://www.springframework.org/schema/websocket"
    xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/websocket
        http://www.springframework.org/schema/websocket/spring-websocket.xsd">

    <websocket:message-broker application-destination-prefix="/app">
        <websocket:stomp-endpoint path="/gs-guide-websocket">
            <websocket:sockjs/>
        </websocket:stomp-endpoint>
        <websocket:simple-broker prefix="/topic, /queue"/>
    </websocket:message-broker>

</beans>
```

#### 服务端添加Controller

Spring官方的例子演示了Send-Response模型，如果需要请求之后，服务端多次推送消息，主动推送消息，可采用如下方式：

```Java
@Controller
public class GreetingController {

    public SimpMessagingTemplate template;

    @Autowired
    public GreetingController(SimpMessagingTemplate template) {
        this.template = template;
    }

    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public void greeting(HelloMessage message) throws Exception {
        template.convertAndSend("/topic/greetings", "aaaaaaa");
    }
}
```

SimpMessagingTemplate是Spring实现的一个发送模板类，直接自动注入获取相应实例即可。SimpMessagingTemplate实例可以实现服务端主动向客户端订阅的Url推送消息。第一个参数为推送地址，第二个参数为需要推送的消息内容。

#### 浏览器端

```Javascript
function connect() {
    var socket = new SockJS('/clbs/gs-guide-websocket');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        setConnected(true);
        console.log('Connected: ' + frame);
        stompClient.subscribe('/topic/greetings', function (greeting) {
            console.log(greeting.body);
        });        
    });
}
```

clbs是项目名称，gs-guide-websocket是终结点名称。greeting.body是取出服务端响应的消息体(Message Body)。Stomp协议与HTTP协议有许多相似之处，命令 + 消息头 + 空行 + 消息体。

```Javascript
stompClient.send("/app/gs-guide-websocket/location",{},JSON.stringify(requestStr));
```


[STOMP Over WebSocket]
[STOMP Over WebSocket]:http://jmesnil.net/stomp-websocket/doc/

[WebSocket Support]
[WebSocket Support]:http://docs.spring.io/spring/docs/current/spring-framework-reference/html/websocket.html
