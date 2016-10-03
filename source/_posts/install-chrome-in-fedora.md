---
title: install-chrome-in-fedora
tags:
  - Fedora
  - Chrome
date: 2016-10-02 23:02:56
---


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

