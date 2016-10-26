---
title: port aready in use
tags:
  - Intellij Idea
  - Spring Boot
  - Stomp
categories: Programming
date: 2016-10-17 16:15:02
---


在使用Intellij Idea调试时，以Application方式启动程序时提示：

```
2016-10-17 11:28:38.537 ERROR 23156 --- [           main] o.s.b.d.LoggingFailureAnalysisReporter   : 

***************************
APPLICATION FAILED TO START
***************************

Description:

The Tomcat connector configured to listen on port 8080 failed to start. The port may already be in use or the connector may be misconfigured.

Action:

Verify the connector's configuration, identify and stop any process that's listening on port 8080, or configure this application to listen on another port.
```

<!-- more -->

提示8080端口已经被占用了，由于此时是以Application方式启动的，没有Tomcat的相关端口配置。Spring Boot uses embedded Tomcat by default, but it handles it differently without using tomcat-maven-plugin. To change the port use --server.port parameter for example。添加程序启动参数：<code>--server.port=8181</code>，更改嵌入的Tomcat的端口即可解决此问题。如图所示：

{% asset_img modify-tomcat-port.jpg 修改Tomcat的启动端口%}


解决方案来自StackOverflow：

[Launching Spring application Address already in use]
[Launching Spring application Address already in use]:http://stackoverflow.com/questions/20735205/launching-spring-application-address-already-in-use
