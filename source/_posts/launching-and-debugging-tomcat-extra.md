---
title: 在Eclipse中启动和调试Tomcat（二）
tags: Tomcat
date: 2016-09-20 17:13:52
---


在Eclipse中启动和调试Tomcat（一）中，断点只能在自定义Servlet中命中，如果想观察详细的Tomcat运行过程，还需要从Tomcat的入口开始进行调试。详细步骤如下(未完全通过，暂勿参考)：

#### 引入Tomcat8.0.37jar包

由于Tomcat的入口类JIoEndPoint实现在tomcat-coyote.jar包中，入口org.apache.tomcat.util.net.JIoEndpoint，该类用来处理传递进来的TCP连接，它实现了一个简单的服务器模式：一个监听线程用来接收socket以及为每个进来的连接创建一个worker来处理。更加高级的功能会涉及到线程重用，如队列等。所以需要引入Tomcat8.0.37中的tomcat-coyote.jar包，在Tomcat8项目的lib目录中。

<!-- more -->

#### 附加源码

附加源码如下图所示。

{% asset_img attach-tomcat-source.jpg Tomcat源码附加%}

#### 调试

在JIoEndPoint类中的processSocket方法上新建断点，在浏览器中请求[地址](http://localhost:9090/examples/demo/test)即可命中断点，单步跟踪调试即可。Tomcat中支持两种协议的连接器：HTTP/1.1与AJP/1.3。HTTP/1.1协议负责建立HTTP连接，web应用通过浏览器访问tomcat服务器用的就是这个连接器，默认监听的是8080端口；AJP/1.3协议负责和其他HTTP服务器建立连接，监听的是8009端口，比如tomcat和apache或者iis集成时需要用到这个连接器。
协议上有三种不同的实现方式：JIO、APR、NIO。
* **JIO(java.io)**：用java.io纯JAVA编写的TCP模块，这是tomcat默认连接器实现方法；
* **APR(Apache Portable Runtime)**：有C语言和JAVA两种语言实现，连接Apache httpd Web服务器的类库是在C中实现的，同时用APR进行网络通信；
* **NIO(java.nio)**：这是用纯Java编写的连接器(Conector)的一种可选方法。该实现用java.nio核心Java网络类以提供非阻塞的TCP包特性。ProtocolHandler接口是对这些协议的抽象










