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
# 将服务器文件拷贝到本地
scp -r pi@192.168.1.113:/var/lib/daemon/GK ./
```

#### ss命令

ss(Socket Statistics)命令用于显示本机Sock统计信息。相比于其他工具，它可以显示更多的信息(It can display more TCP and state informations than other tools)。l查看监听端口。
```Bash
# 显示所有TCP Sockets
ss -t -a
# 查看ssh端口是否已经打开
ss -t -n -a|grep 22
```

t参数表示只显示TCP端口，n(number)表示以数字的方式显示，可以使用`ss --help`查看帮助。

#### lsof命令

```Bash

```

#### top命令

在top命令界面中，按x可以打开或者关闭排序列的加亮效果，默认是以CPU的使用率进行排序。按键盘b可以高亮当前正在运行的进程。按住`Shift + <`或者`Shift + >`可以在高亮不同列，并在对应列上进行升序排序。命令`top -c(command)`可以列出command列的完整参数。

交互参数：

* M：根据驻留内存大小进行排序
* k:终止一个进程
* P：根据CPU使用率的百分比大小进行排序

#### pushd命令

有时需要在不同的目录之间进行切换，当然可以使用cd命令，但是有一些问题，一是需要输入很多重复的命令，其次是记忆这些长的路径也比较费力。pushd命令可以部分解决这个痛点：

```shell
pushd /home/hldev/summarize/blogs/xiaoqiang-blogs
```

此命令会把当前目录压栈，并跳转到目标目录`/home/hldev/summarize/blogs/xiaoqiang-blogs`。使用`dirs -v`命令可以查看当前已经压入栈中的目录。

```shell
hldev@hldev-100:~/hldata/backend/credit-system$ dirs -v
 0  ~/hldata/backend/credit-system
 1  /home
 2  ~/summerize/xiaoqiang-blog-source/themes/next
 3  ~/summerize/xiaoqiang-blog-source/themes/next
 4  ~/summerize/jiangxiaoqiang.github.io
 5  ~
```

切换到压入栈中指定的目录只需要输入`pushd +N(pushd +2)`即可，N代表栈的编号。删除栈中的数据使用popd命令即可。