---
title: Intellij Idea远程调试
tags:
  - Remote Debugging
categories: Tool
date: 2016-11-12 17:28:17
---

远程调试在排错时帮助非常大，有时在本地无法模拟实际的线上环境，有些错误需要达到特定的边界条件才触发，而在本地环境或许无法创造出这样的边界条件和环境。也有的时候本地由于某些限制无法访问特定计算机，只能在远程机上能够访问，但是远程机器上不一定有完整的开发环境。遇到这些场景，远程调试会帮助我们发现和定位问题所在，观察远程机上的软件运行过程，从而找到问题起因。因为我们用的是Tomcat，所以在IDEA中点击右上角那个“Edit Configurations”按钮，然后在弹出的界面中点击左上角的加号，选择tomcat server->remote。

#### 服务器配置

要让远程服务器运行的代码支持远程调试，则启动的时候必须加上特定的JVM参数，这些参数是：

<!-- more -->

```Bash
-Xdebug -Xrunjdwp:transport=dt_socket,suspend=n,server=y,address=${debug_port}
```

其中的${debug_port}是用户自定义的，为debug端口，本例以53996端口为例。在Windows下到tomcat目录下的catalina.bat文件中，添加如下内容，设置catalina环境变量：

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
# Java 1.5或者1.5以上版本启动命令
java -jar -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 example.jar
# Java 1.4版本启动命令
java -jar -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 example.jar
# Java 1.3或更早版本启动命令
java -jar -Xnoagent -Djava.compiler=NONE -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 example.jar
```

在Intellij Idea中进行配置,主机填写远程主机的IP，端口填写远程主机jar启动时指定的端口即可。




参考资料：

* [JVM问题定位工具](http://www.raychase.net/1519)
