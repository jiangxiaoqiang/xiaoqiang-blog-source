---
title: 通用部署流程
date: 2017-01-22 16:43:20
tags:
- deployment
categories: Programming
---

虽然理想中的程序是从来不用考虑部署，只需要简单的几个按即可(部署、回滚、回滚到指定版本)。但是平时还是需要手动处理很多部署工作，将手动部署的一些步骤记录在此，避免遗忘。不管是小到一个简单的单机独立应用，还是大到跨国跨数据中心上千节点大型集群，部署过程大致如此。

<!-- more -->

#### 编译程序(Compile)

对于Java与Scala编写的后端代码，输入如下命令编译程序：

```Bash
# 编译jar包
./gradlew -p cc-web-boot -x test build
```

编译完成后，切换到目标目录`cc-web-boot/build/libs`即可发现生成的jar包。命令指定项目的目录是`cc-web-boot`。对于Javascript、html、css编写的前端代码：

#### 拷贝程序到服务器

使用如下命令拷贝程序到服务端：

```Bash
scp system-web-boot-1.0.0.jar hldev@172.30.0.110:~
scp system-web-boot-1.0.0.jar hl@192.168.32.106:/home/app/
```

目前服务器Web使用的Tengine。需要将后端的jar/war包分别拷贝到12和13服务器。前端代码在11上，Nginx转发请求、负载均衡也在11服务器。在使用国产Web（默认端口9060）时要注意修改配置文件application.properties，将Cookie Domain和Datasource Url设置为相应的值。

#### 启动

使用Putty登录系统，启动：

```Bash
# 新开进程启动
nohup java -jar system-web-boot-1.0.0.jar

# 启动，可以在界面上查看输出日志
java -jar system-web-boot-1.0.0.jar

# 启动，优先使用IPv4
java -jar -Djava.net.preferIPv4Stack=true esystem-web-boot-1.0.0.jar
```

#### 访问

访问相应的应用程序地址：

```
http://172.30.0.110:28080/
```

#### 优化与思考

如何使用Chubby使多机部署自动化，部署的程序如何回滚。目前采用的方式是scp拷贝到2台web服务器，肯定可以完全自动化完成的。