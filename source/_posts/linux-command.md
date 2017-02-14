---
title: Linux常用命令总结
tags:
  - Linux
categories: Programming
date: 2017-01-25 10:22:45
---


查看文件占用情况：

```Bash
du -alh
```

<!-- more -->

#### scp

```Bash
#将本地文件夹上传到服务器
scp -r /tmp/local_dir username@servername:remote_dir
```

#### lsof命令

```Bash

```

#### top命令

在top命令界面中，按x可以打开或者关闭排序列的加亮效果，默认是以CPU的使用率进行排序。按键盘b可以高亮当前正在运行的进程。按住`Shift + <`或者`Shift + >`可以在高亮不同列，并在对应列上进行升序排序。命令`top -c(command)`可以列出command列的完整参数。

交互参数：

* M：根据驻留内存大小进行排序
* k:终止一个进程
* P：根据CPU使用率的百分比大小进行排序
