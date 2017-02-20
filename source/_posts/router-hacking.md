---
title: Router Hacking
date: 2017-02-20 14:39:04
tags:
- Hacking
categories: Hacking
---

最近将家里的路由器密码忘了,Reset按钮也没有作用了,遂试一试能不能够暴力破解.

<!-- more -->

下载THC Hydra:

```shell
wget -c http://www.thc.org/releases/hydra-7.1-src.tar.gz
sudo yum install hydra -y
```

同时在[这里](http://sectools.org/)可以查看目前安全工具的排行.THC-HYDRA是一个支持多种网络服务的非常快速的网络登陆破解工具。这个工具是一个验证性质的工具，它被设计的主要目的是为研究人员和安全从业人员展示远程获取一个系统的认证权限是比较容易的！目前支持破解的服务:

> AFP, Cisco AAA, Cisco auth, Cisco enable, CVS, Firebird, FTP, HTTP-FORM-GET, HTTP-FORM-POST, HTTP-GET, HTTP-HEAD, HTTP-PROXY, HTTPS-FORM-GET, HTTPS-FORM-POST, HTTPS-GET, HTTPS-HEAD, HTTP-Proxy, ICQ, IMAP, IRC, LDAP, MS-SQL, MYSQL, NCP, NNTP, Oracle Listener, Oracle SID, Oracle, PC-Anywhere, PCNFS, POP3, POSTGRES, RDP, Rexec, Rlogin, Rsh, SAP/R3, SIP, SMB, SMTP, SMTP Enum, SNMP, SOCKS5, SSH (v1 and v2), Subversion, Teamspeak (TS2), Telnet, VMware-Auth, VNC and XMPP. For HTTP, POP3, IMAP and SMTP, several login mechanisms like plain and MD5 digest etc. are supported.

安装hydra:

```shell
 tar zxvf hydra-7.1-src.tar.gz
 cd hydra-7.1-src/
 make
 sudo make install
```

安装图形界面

```shell
sudo apt install hydra-gtk -y
```

#### 总结

此工具强大之处在于字典.	





