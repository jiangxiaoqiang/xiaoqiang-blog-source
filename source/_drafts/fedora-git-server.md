---
title: Fedora 24搭建Git Server
tags:
- Fedora
- Git
- Git Server
categories: Programming
---

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
