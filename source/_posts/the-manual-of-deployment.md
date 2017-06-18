---
title: 平台部署流程
date: 2017-01-22 16:43:20
tags:
- deployment
categories: Programming
---
软件发布，往往需要整个团队的成员处于高度紧张的状态，随时待命排查问题。稍微大型一些的项目，加班通宵也是经常的事情。为了解决软件变化与发布的痛点，引入了持续持续集成，只需要简单的几个按即可(部署、回滚、回滚到指定版本)。但是由于种种客观条件限制，平时还是需要手动处理很多部署工作，将手动部署的一些步骤记录在此，避免遗忘。不管是小到一个简单的单机独立应用，还是大到跨国跨数据中心上千节点大型集群，部署过程大致如此。

<!-- more -->

{% asset_img deploy-workflow.jpg 部署流程 %}

#### 获取最新源码(Fetch Source Code)

项目采用的源码管理软件是Git，Git目前是全球最流行的源码管理系统，由Linux内核的作者Linus Torvalds开发，包括Windows操作系统的源码，Linux内核源码等基础设施软件都采用Git作为源码管理系统。本项目的主干分支是v1分支，获取源码如下：

```Bash
# 查看本地分支情况
git branch
# 将远程的v1分支合并到当前分支
git pull osc v1
```

#### 编译程序(Compile)

本项目后端有部分Scala代码，编译时需要同时安装Java Compiler和Scala Compiler，杨老师说不需要Scala SDK只需要在Intellij Idea中安装插件即可，不过自己还是安装了Scala SDK，比较容易理解。对于Java与Scala编写的后端代码，输入如下命令编译程序：

```Bash
# 在Windows下编译后端代码
./gradlew.bat -p cc-web-boot -x test build
# 在Linux下，编译后端jar包
./gradlew -p cc-web-boot -x test build
```

编译完成后，切换到目标目录`cc-web-boot/build/libs`即可发现生成的jar包，jar包大概在70MB-90MB之间。对于Javascript、html、css编写的前端代码：

```Bash
# 在Linux下，编译前端包
./build-release.sh
```

前端包的文件大概在7MB-10MB之间。

#### 拷贝程序到服务器

在拷贝到服务器端时，如果存在覆盖的情况，会顺手备份一个版本。一般以日期作为标识，不管版本重要与否，开始时是手动备份，后面有脚本自动完成备份。一定记得备份，备份，备份。除非你有龚铁鑫同学那般的自信。使用如下命令拷贝程序到服务端：

```Bash
scp system-web-boot-1.0.0.jar dolphin@172.30.0.110:~
scp system-web-boot-1.0.0.jar dolphin@192.168.32.106:/home/app/
```

system-web-boot-1.0.0.jar是目标jar包的名称，dolphin是ssh登陆用户名，172.30.0.110是部署目标服务器IP。目前服务器Web反向代理使用的Tengine。

#### 启动新程序

使用Putty登录目标服务器系统，参考脚本：

```Bash
# 停止旧程序
cd /opt/app/backend && ./stop.sh

# 停止旧程序
ps -aux | grep system-web
kill pid
kill -9 pid

# 新开进程启动,指定配置文件
nohup java -jar system-web-boot-1.0.0.jar --spring.properties=

# 在当前Shell进程中启动，可以在界面上查看输出日志，退出Shell后程序自动退出
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

针对目前程序部署拷贝需要输入许多重复的命令，可以考虑在服务器上编写一个shell脚本，通过ansible控制脚本运行。脚本做的动作就是停止当前网站，备份当前网站的程序，从远程主机（此处的远程主机指的是程序员的开发机器）上获取最新的程序，启动程序。相应的实现回滚功能。只需要执行一条Ansible命令即可。此工具比较占优势的就是，不需要在目标机器上安装Agent，可以同时部署多台服务器。不仅仅是部署，其他的针对多台机器重复的操作都可以通过Ansible来实现自动化。

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

