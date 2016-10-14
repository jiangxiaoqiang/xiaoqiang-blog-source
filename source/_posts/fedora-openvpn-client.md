---
title: Fedora 24 OpenVPN客户端配置
tags:
  - Fedora
  - openvpn
categories: Programming
date: 2016-10-09 11:55:08
---

#### 安装

输入如下命令安装。

```Bash
#Fedora 24安装命令
dnf install openvpn -y
#CentOS 6.8安装命令(可输入lsb_release -a命令查看版本)
yum intall openvpn -y
```

#### 配置

##### 生成客户端文件

到OpenVPN服务端<code>easy-rsa</code>目录下，输入如下命令生成客户端key：

```Bash
build-key client
```

这里介绍在Fedora中如何设置OpenVPN客户端。将生成的客户端文件拷贝到Fedora的<code>/etc/openvpn</code>配置目录中即可，生成的客户端文件有：

* ca.crt
* client.crt
* client.key
* client.ovpn

在Fedora中将client.ovpn改为client.conf即可。启动OpenVPN客户端(root权限):

```Bash
openvpn client.conf
```

<!-- more -->

##### 开机启动

输入如下命令开启开启自动启动：

```Bash
#检查OpenVPN是否在本运行级别下设置为开机启动
chkconfig --list openvpn
#如果没设置启动就设置下
chkconfig --level 2345 openvpn on
chkconfig openvpn on
#重新启动
service sshd restart
#看是否启动了1194端口.确认下
netstat -antp |grep openvpn
#看看是否放行了1194口
iptables -nL
#setup---->防火墙设置   如果没放行就设置放行.
```

chkconfig provides a simple command-line tool for maintaining the <code>/etc/rc[0-6].d</code> directory  hierarchy by relieving system administrators of the task of directly manipulating the numerous symbolic links in those directories.


delete from positional where vtime in ( select vtime from positional group by vtime having count(*)>1) and id not in (select top 1 id from positional group by vtime having count(*)>1 );



#### 问题解决

在Fedora 24中运行<code>openvpn client.conf</code>后提示如下错误：

```
Sat Oct  8 23:32:19 2016 Socket Buffers: R=[87380->87380] S=[16384->16384]
Sat Oct  8 23:32:19 2016 Attempting to establish TCP connection with [AF_INET]114.24.5.55:1194 [nonblock]
Sat Oct  8 23:32:20 2016 TCP connection established with [AF_INET]114.24.5.55:1194
Sat Oct  8 23:32:20 2016 TCPv4_CLIENT link local: [undef]
Sat Oct  8 23:32:20 2016 TCPv4_CLIENT link remote: [AF_INET]114.24.5.55:1194
Sat Oct  8 23:32:20 2016 TLS: Initial packet from [AF_INET]114.24.5.55:1194, sid=efc00936 581068f2
Sat Oct  8 23:32:20 2016 VERIFY OK: depth=1, C=US, ST=CA, L=SanFrancisco, O=OpenVPN, OU=changeme, CN=OpenVPN_CA, name=changeme, emailAddress=mail@host.domain
Sat Oct  8 23:32:20 2016 VERIFY ERROR: depth=0, error=certificate signature failure: C=US, ST=CA, L=SanFrancisco, O=OpenVPN, OU=changeme, CN=server, name=changeme, emailAddress=mail@host.domain
Sat Oct  8 23:32:20 2016 OpenSSL: error:14090086:SSL routines:ssl3_get_server_certificate:certificate verify failed
Sat Oct  8 23:32:20 2016 TLS_ERROR: BIO read tls_read_plaintext error
Sat Oct  8 23:32:20 2016 TLS Error: TLS object -> incoming plaintext read error
Sat Oct  8 23:32:20 2016 TLS Error: TLS handshake failed
Sat Oct  8 23:32:20 2016 Fatal TLS error (check_tls_errors_co), restarting
Sat Oct  8 23:32:20 2016 SIGUSR1[soft,tls-error] received, process restarting
Sat Oct  8 23:32:20 2016 Restart pause, 5 second(s)
```

发生此错误的原因是OpenSSL包中，当前使用的OpenSSL(版本：OpenSSL 1.0.0e 6 Sep 2011)默认的摘要算法为MD5。而MD5算法在目前是非常不安全的(Hash碰撞攻击等)，较大的彩虹表可以轻易的找出Hash对应值。所以在较新的操作系统(这里是Fedora 24)已经默认不使用MD5算法，所以会有此错误(Windows 7支持MD5)。解决此问题的思路不外乎2种，一种是使用sha256、sha512等摘要算法(MD)，另一种就是启用操作系统对MD5的支持,推荐前者。

##### 修改加密方式(推荐)

修改加密方式在OpenVPN目录的文件中(我的是在C:\Program Files (x86)\OpenVPN\easy-rsa\openssl-1.0.0.cnf)。将

```
default_md    = md5            # use public key default MD
```

改为

```
default_md    = sha256            # use public key default MD
```

##### 启用操作系统MD5支持

Temporally enable it.

```Bash
export NSS_HASH_ALG_SUPPORT=+MD5
export OPENSSL_ENABLE_MD5_VERIFY=1
```

Enable MD5 support through NetworkManager

```Bash
$ sudo vim /usr/lib/systemd/system/NetworkManager.service
```

Append this.

```
[Service]
Environment="OPENSSL_ENABLE_MD5_VERIFY=1 NSS_HASH_ALG_SUPPORT=+MD5"
```

And restart daemon

```Bash
$ sudo systemctl daemon-reload
$ sudo systemctl restart NetworkManager.service
```

提示如下错误：

```
Sun Oct 09 11:33:22 2016 OpenVPN 2.2.2 Win32-MSVC++ [SSL] [LZO2] [PKCS11] built on Dec 15 2011
Sun Oct 09 11:33:22 2016 NOTE: OpenVPN 2.1 requires '--script-security 2' or higher to call user-defined scripts or executables
Sun Oct 09 11:33:22 2016 LZO compression initialized
Sun Oct 09 11:33:22 2016 Control Channel MTU parms [ L:1544 D:140 EF:40 EB:0 ET:0 EL:0 ]
Sun Oct 09 11:33:22 2016 Socket Buffers: R=[8192->8192] S=[8192->8192]
Sun Oct 09 11:33:22 2016 Data Channel MTU parms [ L:1544 D:1450 EF:44 EB:135 ET:0 EL:0 AF:3/1 ]
Sun Oct 09 11:33:22 2016 Local Options hash (VER=V4): '69109d17'
Sun Oct 09 11:33:22 2016 Expected Remote Options hash (VER=V4): 'c0103fa8'
Sun Oct 09 11:33:22 2016 Attempting to establish TCP connection with 113.204.5.58:1194
Sun Oct 09 11:33:23 2016 TCP: connect to 113.204.5.58:1194 failed, will try again in 5 seconds: Connection refused (WSAECONNREFUSED)
Sun Oct 09 11:33:29 2016 TCP: connect to 113.204.5.58:1194 failed, will try again in 5 seconds: Connection refused (WSAECONNREFUSED)
Sun Oct 09 11:33:35 2016 TCP: connect to 113.204.5.58:1194 failed, will try again in 5 seconds: Connection refused (WSAECONNREFUSED)
Sun Oct 09 11:33:41 2016 TCP: connect to 113.204.5.58:1194 failed, will try again in 5 seconds: Connection refused (WSAECONNREFUSED)
```

首先检查服务端OpenVPN是否已经启动；其次检查服务端的配置文件无误，这里是将位数由1024改为2048后在服务端的配置文件没有修改为2048pem。

```
# Diffie hellman parameters.
# Generate your own with:
#   openssl dhparam -out dh1024.pem 1024
# Substitute 2048 for 1024 if you are using
# 2048 bit keys.
dh dh2048.pem #将此处由dh1024.pem修改为dh2048.pem即可
```
出现如下错误：

```
Tue Oct 11 12:44:00 2016 Socket Buffers: R=[124928->124928] S=[124928->124928]
Tue Oct 11 12:44:00 2016 UDPv4 link local: [undef]
Tue Oct 11 12:44:00 2016 UDPv4 link remote: [AF_INET]192.168.24.243:1194
Tue Oct 11 12:45:00 2016 TLS Error: TLS key negotiation failed to occur within 60 seconds (check your network connectivity)
Tue Oct 11 12:45:00 2016 TLS Error: TLS handshake failed
Tue Oct 11 12:45:00 2016 SIGUSR1[soft,tls-error] received, process restarting
Tue Oct 11 12:45:00 2016 Restart pause, 2 second(s)
```

检查防火墙是否过滤了1194端口的数据。

```Bash
iptables -A INPUT -p tcp --dport 1194 -j ACCEPT
#保存防火墙规则
/etc/init.d/iptables save
```

检查配置文件是否通过TCP协议而不是UDP。
