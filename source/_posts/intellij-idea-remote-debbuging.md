---
title: Intellij Idea远程调试
tags:
  - Remote Debugging
categories: Tool
date: 2016-11-12 17:28:17
---

Java 调试的本质，就是和虚拟机打交道，通过操作虚拟机来达到观察调试我们自己代码的目的。远程调试在排错时帮助非常大，有时在本地无法模拟实际的线上环境，有些错误需要达到特定的边界条件才触发，而在本地环境或许无法创造出这样的边界条件和环境。也有的时候本地由于某些限制无法访问特定计算机，只能在远程机上能够访问，但是远程机器上不一定有完整的开发环境。遇到这些场景，远程调试会帮助我们发现和定位问题所在，观察远程机上的软件运行过程，从而找到问题起因。因为我们用的是Tomcat，所以在IDEA中点击右上角那个“Edit Configurations”按钮，然后在弹出的界面中点击左上角的加号，选择tomcat server->remote。

<!-- more -->

#### 服务端配置

这里的服务端泛指的是实际运行Java虚拟机端，当在本机开发的时候，实际运行Java虚拟机的是本机，实际上也是通过Socket进行通信。远程调试，无非就是Java虚拟机运行在另一台机器而已，其他和本机开发并没有什么不同，另一台机器可以是局域网另一台机器，可以是数据中心的生产机器，互联网上的其他任何机器(要能够与本机相应端口直接链接)。本机调试时有如下输出:

{%asset_img debugging-connect-localhost.png Java调试连接本机%}

要让远程服务器运行的代码支持远程调试，则启动的时候必须加上特定的JVM参数，这些参数是：

```Bash
# 自己的理解X应该是eXecute的含义，dt是Data Transport的含义
-Xdebug -Xrunjdwp:transport=dt_socket,suspend=n,server=y,address=${debug_port}
```

JDWP(Java Debug Wire Protocol)是一个为 Java 调试而设计的一个通讯交互协议，它定义了调试器和被调试程序之间传递的信息的格式。在 JPDA 体系中，作为前端（front-end）的调试者（debugger）进程和后端（back-end）的被调试程序（debuggee）进程之间的交互数据的格式就是由 JDWP 来描述的，它详细完整地定义了请求命令、回应数据和错误代码，保证了前端和后端的 JVMTI 和 JDI 的通信通畅。比如在 Sun 公司提供的实现中，它提供了一个名为 jdwp.dll（jdwp.so）的动态链接库文件，在JDK 8中，文件在`/opt/local/jdk8/jre/lib/amd64/libjdwp.so`，这个动态库文件实现了一个 Agent，它会负责解析前端发出的请求或者命令，并将其转化为 JVMTI 调用，然后将 JVMTI 函数的返回值封装成 JDWP 数据发还给后端。其中的${debug_port}是用户自定义的，为debug端口，本例以53996端口为例。在Windows下到tomcat目录下的catalina.bat文件中，添加如下内容，设置catalina环境变量：

```Bash
set CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,address=53996,suspend=n,server=y"
```

如果是Linux，在catalina.sh文件中中，设置catalina环境变量：

```Bash
export CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,address=53996,suspend=n,server=y"
```
Sun虚拟机实现需要指定命令行选项，以加载JDWP（Java Debug Wire Protocol Transport）代理来debug。JDK 5.0以前需要指定-Xdebug和-Xrunjdwp这两个参数，以后则可以使用参数-agentlib:jdwp替代之，它们指定了JVM使用的连接器。从上面的例子代码可以看到几个jdwp支持的参数选项，包括transport、server、suspend、address等等，这些都很常见，还包括timeout、launch（中断并开始调试的时候，执行什么程序）、onuncaught（如果出现无法捕获的异常是否需要中断并调试）等等。运行如下命令启动Tomcat：

```Bash
#Windows下启动Tomcat
catalina.bat start

#Linux下启动Tomcat
catalina.sh start
```

使用如下命令查看是否配置成功：

```Bash
#Windows下用此命令查看
netstat -ano

#Linux下用此命令查看
lsof -i:53996
```

查看是否有53996的端口处于监听状态。如下图所示：

{% asset_img tomcat-listening-port.png 检查服务端配置是否正确%}



#### Intellij Idea配置

Intellij Idea远程调试配置如下：

{% asset_img intellij-idea-remote-debugging.jpg Intellij Idea远程调试配置%}

#### jar包远程调试

有时项目直接使用jar包部署，此时如果需要使用远程调试,在启动jar包时，添加特定的参数：

```shell
# Java 1.5或者1.5以上版本启动命令,jdwp=Java Debug Wire Protocol
java -jar -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 example.jar
# Java 1.4版本启动命令
java -jar -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 example.jar
# Java 1.3或更早版本启动命令
java -jar -Xnoagent -Djava.compiler=NONE -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 example.jar
```

在Intellij Idea中进行配置,主机填写远程主机的IP，端口填写远程主机jar启动时指定的端口即可。




参考资料：

* [JVM问题定位工具](http://www.raychase.net/1519)
