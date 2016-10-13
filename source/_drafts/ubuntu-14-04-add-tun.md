---
title: ubuntu 14.04添加TUN模块
tags:
- Ubuntu
- TUN
- Kernel
categories: Programming
---

在使用OpenVPN时，提示没有TUN/TAP模块，惊讶于Ubuntu怎么没有编译这些模块，根据网络教程自己一步一步编译。


切换到Source目录下：

```Bash
cd /usr/src/linux-source-3.13.0/
```

解压出文件：

```Bash
tar xvjf linux-source-3.13.0.tar.bz2
```
