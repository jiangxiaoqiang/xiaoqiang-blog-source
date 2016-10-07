---
title: install-chrome-in-fedora
tags:
  - Fedora
  - Chrome
date: 2016-10-02 23:02:56
---


一种方法是通过yum安装。yum（全称为 Yellow dog Updater, Modified）是一个在Fedora和RedHat以及SUSE中的Shell前端软件包管理器。基於RPM包管理，能够从指定的服务器自动下载RPM包并且安装，可以自动处理依赖性关系，并且一次安装所有依赖的软体包，无须繁琐地一次次下载、安装。yum提供了查找、安装、删除某一个、一组甚至全部软件包的命令，而且命令简洁而又好记。

#### 创建Repo

在目录/etc/yum.repos.d下新建google-chrome.repo文件。

```Bash
vi /etc/yum.repos.d/google-chrome.repo
```

32位操作系统写入如下代码：

```
[google-chrome]
name=google-chrome - 32-bit
baseurl=http://dl.google.com/linux/chrome/rpm/stable/i386
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
```


64位操作系统写入如下代码：

```
[google-chrome]
name=google-chrome - 64-bit
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
```


#### 安装

```Bash
yum install google-chrome-stable
```

也可以直接下载rpm包进行安装。

```Bash
rpm -ivh google-chrome-stable_current_i386.rpm
```

提示错误如下：

```
warning: google-chrome-stable_current_i386.rpm: Header V4 DSA/SHA1 Signature, key ID 7fac5991: NOKEY
error: Failed dependencies:
	lsb >= 4.0 is needed by google-chrome-stable-19.0.1084.56-140965.i386
	libXss.so.1 is needed by google-chrome-stable-19.0.1084.56-140965.i386
```

安装依赖包。

```Bash
yum install redhat-lsb -y
yum install wget -y
yum install libXScrnSaver -y
yum install libgcrypt.so.11
```

```
Transaction check error:
  file /usr/bin from install of google-chrome-stable-19.0.1084.56-140965.i386 conflicts with file from package filesystem-3.2-19.fc20.i686
```

