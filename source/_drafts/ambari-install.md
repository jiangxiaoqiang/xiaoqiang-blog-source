---
title: Apache Ambari 2.2.2.0
tags: [Ambari]
---

* Apache Ambari 2.2.2.0

* CentOS 7.0

#### 安装Java

```Bash
tar xzvf jdk-7u25-linux-x64.tar.gz -C /usr/jdk64/
```

#### 下载

在线安装很慢，可以先下载离线包：

```Bash
wget -c http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.2.2.0/ambari/ambari-server-2.2.2.0-460.x86_64.rpm
```
-c参数代表断点续传(continue)。

#### 安装

可以直接通过如下命令安装。
```Bash
yum install ambari-server -y
```

下载完毕后离线安装

```Bash
rpm -ivh ambari-server-2.2.2.0-460.x86_64.rpm
```

#### 配置

```Bash
ambari-server setup
```

#### 启动

```Bash
ambari-server start
```

在浏览器上访问http://ip:8080 即可进入Apache Ambari登录页，默认用户名<code>admin</code>，密码：<code>admin</code>。

#### 配置集群

下载Private Key：

```Bash
scp root@192.168.24.226:~/.ssh/id_rsa ./
```
提示不是有效的FQDNs：

```
The following hostnames are not valid FQDNs:

zwlbs6, zwlbs7

This may cause problems during installation. Do you want to continue?
```

FQDNs指代Fully Qualified Domain Name，需要和配置文件<code>/etc/hosts</code>中的名字与IP对应的名称一致。


```
Failed to connect to https://test.org:8440/ca due to [Errno 111] Connection refused
```


```
Ambari agent machine hostname (41.244.204.221.ty.sx.cn) does not match expected ambari server hostname (zwlbs6.com). Aborting registration. Please check hostname, hostname -f and /etc/hosts file to confirm your hostname is setup correctly
```

请确认Ambari-Agent在各节点上是否已经启动，如果未启动使用命令<code>ambari-agent start</code>启动。

```
Registration with the server failed
```

升级OpenSSL。用如下命令查看当前安装的OpenSSL：

```Bash
rpm -qa | grepopenssl openssl-1.0.1e-15.el6.x86_64
```

如果提示是<code>openssl-1.0.1e-15.x86_64 (1.0.1 build 15)</code>则需要升级。
升级命令：

```Bash
yum upgrade openssl
```

需要注意的2点(重要)：

1.主机名一定要配置正确。如何验证主机名(DQDN)配置是否OK，输入命令<code>hostname -f</code>进行查看。

2.免密登录要配置正确。验证免密登录OK，可以直接使用如下命令<code>ssh hostname</code>登录相关主机。

#### 启动ntpd服务

在Linux下，默认情况下，系统时间和硬件时间，并不会自动同步。在Linux运行过程中，系统时间和硬件时间以异步的方式运行，互不干扰。硬件时间的运行，是靠Bios电池来维持，而系统时间，是用CPU tick来维持。为了避免主机时间因为长期运作下所导致的时间偏差，进行时间同步(synchronize)的工作是非常必要的。Linux系统下，一般使用ntp服务器 来同步不同机器的时间。一台机器，可以同时是ntp服务器和ntp客户机。在网络中，推荐使用像DNS服务器一样分层的时间服务器来同步时间。Network Time Protocol（NTP）是用来使计算机时间同步化的一种协议，它可以使计算机对其服务器或时钟源（如石英钟，GPS等等)做同步化，它可以提供高精准度的时间校正（LAN上与标准间差小于1毫秒，WAN上几十毫秒），且可介由加密确认的方式来防止恶毒的协议攻击。安装ntp：

```Bash
yum install ntp -y
```

启动ntpd服务：

```Bash
service ntpd start
```

