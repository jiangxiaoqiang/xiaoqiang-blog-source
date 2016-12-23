---
title: wget使用
date: 2016-12-23 20:37:29
tags:
- Linux
- wget
categories: Programming
---

GNU Wget is a free software package for retrieving files using HTTP, HTTPS and FTP, the most widely-used Internet protocols. Wget是直接在命令行中使用的，可以很容易的以脚本的方式调用。

<!-- more -->

下载文件

```Bash
wget url
```

下载文件(断点续传)

```Bash
wget -c url
```

抓取整站：

```
#抓取整站
wget -r -p -np -k http://www.xxx.com
```
