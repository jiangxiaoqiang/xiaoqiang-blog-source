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

针对目前程序部署拷贝需要输入许多重复的命令，可以考虑在服务器上编写一个shell脚本，通过ansible控制脚本运行。脚本做的动作就是停止当前网站，备份当前网站的程序，从远程主机（此处的远程主机指的是程序员的开发机器）上获取最新的程序，启动程序。相应的实现回滚功能。只需要执行一条Ansible命令即可。

```shell
#!/bin/sh

#
# 一键部署前端项目到远程1台或多台服务器(欢迎改进)
# 发布流程为：编译构建-打包-发布包-拷贝包到指定目录-解压包
# 注：本机需要安装Ansible并与服务器做免密登录
#

# send=`date '+%Y-%m-%d %H:%M:%S'`
CURRENT_TIME=`date '+%Y%m%d%H%M%S'`

echo "$CURRENT_TIME"

echo "开始构建..."
# Build project
npm run site-dev
npm run build

echo "开始打包..."
# Package project
rm -rf dist.tar.gz
tar zcf dist.tar.gz dist

echo "开始拷贝..."
# publish project
scp dist.tar.gz root@139.23.24.22:~/app-soft

ansible webservers -m command -a "date"

echo "备份站点..."
# 备份当前站点
ansible webservers -m command -a "mv /opt/app/frontend/dist /opt/app/frontend/dist-$CURRENT_TIME"

ansible webservers -a "mv /opt/app/frontend/dist.tar.gz /opt/app/frontend/dist.tar.gz.bak"

ansible webservers -a "mv ~/app-soft/dist.tar.gz /opt/app/frontend/"

#部署
ansible webservers -a "tar -xzvf /opt/app/frontend/dist.tar.gz -C /opt/app/frontend/"
echo "部署完成"
```

同理，后端项目的脚本：

```shell
#!/usr/bin/env bash

#
# 一键部署后端项目到远程1台或多台服务器(欢迎改进)
# 发布流程为：编译构建-打包-发布包-拷贝包到指定目录-解压包
# 注：本机需要安装Ansible并与服务器做免密登录
#

# send=`date '+%Y-%m-%d %H:%M:%S'`
CURRENT_TIME=`date '+%Y%m%d%H%M%S'`
PROGRAM_PATH="/opt/app/backend"
echo "$CURRENT_TIME"

echo "开始构建..."
# Build project
./gradlew -p cc-web-boot -x test build
./gradlew -p cc-etl-sechedule -x test build

echo "开始拷贝..."
# publish project
scp cc-web-boot/build/libs/credit-system-web-boot-1.0.0.jar root@59.214.215.6:~/app-soft/

ansible webservers -m command -a "date"

echo "停止站点..."
ansible webservers -m command -a "chdir=/opt/app/backend bash ./stop.sh"

echo "等待站点停止..."
sleep 10

echo "备份站点..."
# 备份当前站点
ansible webservers -m command -a "mv /opt/app/backend/credit-system-web-boot-1.0.0.jar /opt/app/backend/credit-system-web-boot-1.0.0.jar-$CURRENT_TIME"

echo "拷贝新文件..."
ansible webservers -a "mv ~/app-soft/credit-system-web-boot-1.0.0.jar /opt/app/backend/"

echo "启动站点..."
ansible webservers -a "chdir=/opt/app/backend bash ./start.sh"

echo "部署完成"
```

Ansible常用命令：

```shell
# 切換遠程目錄，並執行腳本a.sh
ansible webservers -a 'chdir=/usr/local/src bash ./a.sh'
```

