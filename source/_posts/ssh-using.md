---
title: ssh-using
date: 2017-04-06 21:49:32
tags:
- ssh
categories: Tool
---

ssh是Scure Shell的簡稱。

#### 端口轉發

有时，本地电脑处于NAT内网中，难以从外部访问；而远程服务器可轻易被访问。利用远程转发功能，可允许他人通过远程服务器间接访问本地电脑的某个端口。

```shell
ssh -R 9090:localhost:80 my-remote-host.com
```

这样，访问`my-remote-host.com:9090`就等同于用本机访问`localhost:8080`。

