---
title: 通用程序部署手册(手动)
date: 2017-01-22 16:43:20
tags:
- deployment
categories: Programming
---

虽然理想中的程序是从来不用考虑部署，只需要简单的几个按即可。但是平时还是需要手动处理很多部署工作，将手动部署的一些步骤记录在此，避免遗忘。不管是小到一个简单的单机独立应用，还是大到跨国跨数据中心上千节点大型集群，部署过程大致如此。

<!-- more -->

#### 拷贝程序到服务器

使用如下命令拷贝程序到服务端：

```Bash
scp system-web-boot-1.0.0.jar hldev@172.30.0.110:~
```

#### 启动

使用Putty登录系统，启动：

```Bash
# 新开进程启动
nohup java -jar system-web-boot-1.0.0.jar

# 启动，可以在界面上查看输出日志
java -jar system-web-boot-1.0.0.jar

# 启动，优先使用IPv4
java -jar -Djava.net.preferIPv4Stack=true system-web-boot-1.0.0.jar
```

#### 访问

访问相应的应用程序地址：

```
http://172.30.0.110:28080/
```


