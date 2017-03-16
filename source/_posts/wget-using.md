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

```Bash
#抓取整站
wget -r -p -np -k http://www.xxx.com
```

使用wget限速下载：

```Bash
wget --limit-rate=300k http://www.minjieren.com/wordpress-3.1-zh_CN.zip
```

使用wget -b后台下载。命令：

```Bash
wget -b http://www.minjieren.com/wordpress-3.1-zh_CN.zip
```

说明：

对于下载非常大的文件的时候，我们可以使用参数-b进行后台下载。

```Bash
wget -b http://www.minjieren.com/wordpress-3.1-zh_CN.zip
Continuing in background, pid 1840.
Output will be written to `wget-log'.
```

你可以使用以下命令来察看下载进度：

```Bash
tail -f wget-log
```

有时在低速网络环境下(真的会有低速网络，在2017年的时候，还使用过下载速度只有2KB/s左右的网络，当然了2B/s也不见怪了)，下载可能会经常中断，使用wget –tries增加重试次数。命令：

```Bash
wget --tries=40 URL
```

说明：

如果网络有问题或下载一个大文件也有可能失败。wget默认重试20次连接下载文件。如果需要，你可以使用–tries增加重试次数。