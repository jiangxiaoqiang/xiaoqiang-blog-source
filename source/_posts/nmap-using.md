---
title: nmap的使用
tags:
  - nmap
categories: Programming
date: 2017-02-23 13:43:26
---

#### 安装

```shell
# 在Ubuntu下安装
sudo apt install nmap -y
# 安装图形界面
sudo apt install zenmap -y
```

#### 端口掃描

默認的端口掃描只掃描常用的1000個端口，如果需要掃描所有端口，使用如下命令：

```shell
nmap -p 1-65535 -A 192.168.1.12
nmap -p- -A 192.168.1.12
```

-A包含OS 探测，版本探测，脚本扫描，traceroute。

#### 查看指定端口的状态

有时我们想查看服务器具体的某一个端口是否UP，可以通过扫描实现。但是还有一种更加节省时间的方法，例如想查看凤凰网的80端口是否开启，可以输入如下命令：

<!-- more -->

```Bash
nmap -p 80 ifeng.com
```

结果可以立即出来，这样可以节省不少时间。p参数用于监控指定端口。

#### 隐藏身份

当我们在用nmap扫描时，一般情况下不建议直接扫描，直接扫描会暴露自己的IP，如果需要隐藏身份，可以有如下方法：

* 伪造访问的IP地址
* 对发送信息进行处理
* 风险进行嫁接
* 其他

##### 诱饵扫描

诱饵扫描的工作原理时伪造大量的IP与自己的IP一并去访问网站，从而混淆判断。扫描的命令如下所示：

#### 应用示例

假设主机的IP是192.168.1.2，一些扫描示例如下：

```Bash
# A参数表示启动OS和版本侦测、脚本扫描等，T4参数表示快速执行
nmap -A -T4 192.168.1.2
# 操作系统侦测,O表示Operation System
sudo nmap -O 192.168.1.2
```
#### GUI

```shell
# 在Fedora下安装Zenmap客户端
rpm -vhU https://nmap.org/dist/zenmap-7.40-1.noarch.rpm
```