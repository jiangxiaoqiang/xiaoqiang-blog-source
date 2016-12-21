---
title: curl使用
date: 2016-11-19 02:02:32
tags:
- curl
categories: Programming
---

#### 简介

curl is a tool to transfer data from or to a server, using one of the supported protocols (DICT, FILE, FTP, FTPS, GOPHER, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP, SCP, SFTP, SMB, SMBS, SMTP, SMTPS, TELNET and TFTP). The command is designed to work without user interaction.

curl offers a busload of useful tricks like proxy support, user authentication, FTP upload, HTTP post, SSL connections, cookies, file transfer resume, Metalink, and more. As you will see below, the number of features will make your head spin!

<!-- more -->

#### 查看网页源码

直接在curl命令后加上网址，就可以看到网页源码。我们以网址www.jiangxiaoqiang.com为例：

curl www.jiangxiaoqiang.com

```HTML
<html>
<head><title>301 Moved Permanently</title></head>
<body bgcolor="white">
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx</center>
</body>
</html>
```

#### 请求API数据

比如需要在请求头中添加Key、Value键值对，可以添加-H(Header)参数，如下命令行所示：

```Bash
curl -H "APPID:123" http://localhost:28080/api/xysj?xdrShxym=addd
```

如果是需要发送多个请求头，那么多次指定-H参数即可,如下命令所示。

```Bash
curl -H "APPID:123" -H "TIMESTAMP:2016-12-19 16:58:02" -H "ECHOSTR:sdsaasf" -H "TOKEN:sdsss" http://localhost:28080/api/xysj?xdrShxym=addd
```

#### 发送Cookie
