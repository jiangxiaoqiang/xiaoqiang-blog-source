---
title: Linux压缩包管理
date: 2016-12-24 22:08:38
tags:
- Linux
categories: Programming
---


#### tar.bz2

解压tar.bz2的命令如下：

```Bash
 tar -jxvf xx.tar.bz2
```

<!-- more -->

#### tar.gz

```Bash
tar -xzvf example.tar.gz
```

#### rar

在Ubuntu中处理rar(WinRAR Compressed Archive)文件类型，安装相应包：

```Bash
sudo apt install -y unrar
```

输入如下命令解压缩：

```Bash
unrar x -r simple.rar
```
