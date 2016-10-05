---
title: Fedora 20 安装NodeJs
tags:
  - Fedora
  - NodeJs

categories: Programming
date: 2016-10-05 09:52:08
---


安装环境：

* Fedora 20 i386

* nodejs 6.7.0

使用Hexo写博客需要安装NodeJs,更新系统

```Bash
yum update -y
```

安装GCC编译环境

<!-- more -->

```Bash
yum install g++ curl openssl openssl-devel make gcc-c++ glibc-devel -y
```

下载NodeJS

```Bash
mkdir /root/temp ; cd /root
wget http://nodejs.org/dist/node-latest.tar.gz
tar -xvpzf node-latest.tar.gz
cd node-v*
```

编译安装,编译安装的时间较长，需要耐心等待，编译大概在15分钟左右。

```Bash
./configure
make install
```

安装NPM

```Bash
curl http://npmjs.org/install.sh | sh
```
查看安装的NodeJs版本：

```Bash
node --version
```

