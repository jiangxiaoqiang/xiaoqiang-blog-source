---
title: Tomcat 8.0 HTTP请求流程
tags: HTTP
date: 2016-09-22 22:11:14
---


假设来自浏览器的请求为：http://localhost:8080/test/index.jsp

#### Connector获取请求

请求被发送到Apache Tomcat服务器端口8080，被在那里侦听的Coyote HTTP/1.1 Connector(org.apache.tomcat.util.net.NioEndpoint)获得。Tomcat源码中与connector相关的类位于org.apache.coyote包中，Connector分为以下几类：

* **Http Connector** 基于HTTP协议，负责建立HTTP连接。它又分为BIO Http Connector与NIO Http Connector(org.apache.tomcat.util.net.NioEndpoint)两种。BIO(blocking I/O)，顾名思义，即阻塞式I/O操作，表示Tomcat使用的是传统的Java I/O操作(即java.io包 及其子包)。一般而言，bio模式是三种运行模式中性能最低的一种。NIO为Network IO，后者提供非阻塞IO与长连接Comet支持。NIO(new I/O)，是Java SE 1.4及后续版本提供的一种新的I/O操作方式(即java.nio包及其子包)。Java nio是一个基于缓冲区、并能提供非阻塞I/O操作的Java API，因此nio也被看成是non-blocking I/O的缩写。它拥有比传统I/O操作(bio)更好的并发运行性能。

<!-- more -->

* **AJP Connector**	基于AJP协议，AJP是专门设计用来为tomcat与http服务器之间通信专门定制的协议，能提供较高的通信速度和效率。如与Apache服务器集成时，采用这个协议。AJP(Apache JServ Protocol)协议：目前正在使用的AJP协议的版本是通过JK和JK2连接器提供支持的AJP13，它基于二进制的格式在Web服务器和Tomcat之间传输数据，而此前的版本AJP10和AJP11则使用文本格式传输数据。

* **APR HTTP Connector** org.apache.tomcat.util.net.AprEndpoint，用C实现，通过JNI(Java Native Interface)调用的。主要提升对静态资源(如HTML、图片、CSS、JS等)的访问性能。现在这个库已独立出来可用在任何项目中。Tomcat在配置APR之后性能非常强劲。APR(Apache Portable Runtime/Apache可移植运行时)，是Apache HTTP服务器的支持库。你可以简单地理解为，Tomcat将以JNI的形式调用Apache HTTP服务器的核心动态链接库来处理文件读取或网络传输操作，从而大大地提高Tomcat对静态文件的处理性能。Tomcat apr也是在Tomcat上运行高并发应用的首选模式。与配置nio运行模式一样，也需要将对应的Connector节点的protocol属性值改为org.apache.coyote.http11.Http11AprProtocol。

Tomcat7和Tomcat8默认设置都是http1.1，Tomcat7默认使用BIO，Tomcat8根据情况自动选择BIO还是NIO，甚至NIO2.当前调试版本是Tomcat 8，默认进入的是NioEndpoint(其实这里已经到AbstractEndpoint的Processor了，在NioEndpoint的断点始终没有命中，不知何故)，如下图所示。

{% asset_img nioendpoint-debug.jpg HTTP请求进入NioEndpoint%}

#### Engine处理请求

Connector把该请求交给它所在的Service的Engine(StandardEngine)来处理，并等待Engine的回应。Container 是容器的父接口，所有子容器都必须实现这个接口，Container 容器的设计用的是典型的责任链的设计模式，它有四个子容器组件构成，分别是：Engine、Host、Context、Wrapper，这四个组件不是平行的，而是父子关系，Engine 包含 Host,Host 包含 Context，Context 包含 Wrapper。通常一个 Servlet class 对应一个 Wrapper，如果有多个 Servlet 就可以定义多个 Wrapper，如果有多个 Wrapper 就要定义一个更高的Container。详细的关系在server.xml可以看出来：

```XML
<Server><!--顶层元素，代表一个服务器-->
  <Service><!--顶层元素，是Connector的集合，只有一个Engine-->
    <Connectior/><!--连接器类元素，代表通信接口-->
      <Engine><!--容器类元素，为特定的Service组件处理所有客户请求，可包含多个Host-->
         <Host><!--为特定的虚拟主机处理所有客户请求-->
            <Context><!--为特定的WEB应用处理所有客户请求-->
            </Context>
         </Host>
      </Engine>
  </Service>
</Server>
```


#### 匹配Host

Engine获得请求localhost:8080/test/index.jsp，匹配它所有虚拟主机Host
Engine匹配到名为localhost的Host（即使匹配不到也把请求交给该Host处理，因为该Host被定义为该Engine的默认主机）

#### 匹配Context

localhost Host获得请求/test/index.jsp，匹配它所拥有的所有Context
Host匹配到路径为/test的Context（如果匹配不到就把该请求交给路径名为""的Context去处理）

#### 匹配Servlet

path="/test"的Context获得请求/index.jsp，在它的mapping table中寻找对应的servlet
Context匹配到URL PATTERN为*.jsp的servlet，对应于JspServlet类
构造HttpServletRequest对象和HttpServletResponse对象，作为参数调用JspServlet的doGet或doPost方法

#### 返回响应

Context把执行完了之后的HttpServletResponse对象返回给Host
Host把HttpServletResponse对象返回给Engine
Engine把HttpServletResponse对象返回给Connector
Connector把HttpServletResponse对象返回给客户browser


请求流程图(Graphiz绘制)：

{% asset_img tomcat-handle-flow.jpg HTTP在Tomcat中的Handle流程%}