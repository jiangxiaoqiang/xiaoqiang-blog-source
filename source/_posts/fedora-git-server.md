---
title: Fedora 24搭建Git Server
tags:
  - Fedora
  - Git
  - Git Server
categories: Programming
date: 2016-10-16 21:03:39
---


想将代码拷贝到家里的电脑，在安静的时刻可以阅读消化，思考思考是否还有更好的方式。每天用U盘拷贝也是麻烦，本来Github挺好用的，闭源的托管要交钱。所以就在家里的电脑搭建一个Git Server，通过OpenVPN将家里的电脑和办公电脑做成局域网。这样就可以随时提交代码了。

<!-- more -->

#### 启动SSH服务

确定是否已经安装SSH服务：

```Bash
rpm -qa | grep openssh-server
```

如果没有安装服务，输入如下命令安装：

```Bash
dnf install openssh-server -y
```

修改配置文件:

```Bash
vi /etc/ssh/sshd_config
```

```Bash
#Port 22  监听的端口号，默认是22，可以自定义。
#Protocol 2  支持的协议，默认就好，不用修改
#PermitRootLogin yes 是否允许root直接登录，最好设置为no
#MMaxAuthTries 6 最大登录数，默认是6，建议设置为3，防止别人密码穷举。
```

修改完配置后，重启SSH服务：

```Bash
service ssh restart
```

查看SSH服务状态:

```Bash
service sshd status
```

允许此端口（22）访问：

```Bash
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```

#### 初始化Git仓库

先选定一个目录作为Git仓库，这里是<code>/home/dolphin/dolphin/source/zwlbs/plateform3.0/zwlbs.git</code>，在/srv目录下输入命令：

$ sudo git init --bare zwlbs.git

#### 签出Git库

```Bash
git clone dolphin@10.0.0.6:/home/dolphin/dolphin/source/zwlbs/plateform3.0/zwlbs.git
```

签出时会提示确定指纹，选择yes，同时需要输入用户dolphin的密码，输入即可。
