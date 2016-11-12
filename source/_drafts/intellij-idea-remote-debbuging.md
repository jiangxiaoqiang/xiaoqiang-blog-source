---
title: Intellij-Idea远程调试
tags:
- Remote Debugging
categories: Programming
---

因为我们用的是Tomcat，所以在IDEA中点击右上角那个“Edit Configurations”按钮，然后在弹出的界面中点击左上角的加号，选择tomcat server->remote。

要让远程服务器运行的代码支持远程调试，则启动的时候必须加上特定的JVM参数，这些参数是：

<!-- more -->

```Bash
-Xdebug -Xrunjdwp:transport=dt_socket,suspend=n,server=y,address=${debug_port}
```

其中的${debug_port}是用户自定义的，为debug端口，本例以53996端口为例。在Windows下到tomcat目录下的catalina.bat文件中，添加如下内容，设置catalina环境变量：

```Bash
set CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,address=53996,suspend=n,server=y"
```

运行如下命令启动Tomcat：

```Bash
catalina.bat start
```

使用如下命令查看是否配置成功：

```Bash
netstat -ano
```

查看是否有53996的端口处于监听状态。如下图所示：




