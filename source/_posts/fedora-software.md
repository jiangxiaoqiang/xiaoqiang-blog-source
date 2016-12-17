---
title: Fedora常用软件集合
tags:
  - Fedora
categories: Programming
date: 2016-12-16 23:32:33
---

#### htop

序号 列名 含义
a PID 进程id
b PPID 父进程id
c RUSER Real user name
d UID 进程所有者的用户id
e USER 进程所有者的用户名
f GROUP 进程所有者的组名
g TTY 启动进程的终端名。不是从终端启动的进程则显示为 ?
h PR 优先级
i NI nice值。负值表示高优先级，正值表示低优先级
j P 最后使用的CPU，仅在多CPU环境下有意义
k %CPU 上次更新到现在的CPU时间占用百分比
l TIME 进程使用的CPU时间总计，单位秒
m TIME+ 进程使用的CPU时间总计，单位1/100秒
n %MEM 进程使用的物理内存百分比
o VIRT 进程使用的虚拟内存总量，单位kb。VIRT=SWAP+RES
p SWAP 进程使用的虚拟内存中，被换出的大小，单位kb。
q RES 进程使用的、未被换出的物理内存大小，单位kb。RES=CODE+DATA
r CODE 可执行代码占用的物理内存大小，单位kb
s DATA 可执行代码以外的部分(数据段+栈)占用的物理内存大小，单位kb
t SHR 共享内存大小，单位kb
u nFLT 页面错误次数
v nDRT 最后一次写入到现在，被修改过的页面数。
w S 进程状态。（D=不可中断的睡眠状态，R=运行，S=睡眠，T=跟踪/停止，Z=僵尸进程）
x COMMAND 命令名/命令行
y WCHAN 若该进程在睡眠，则显示睡眠中的系统函数名
z Flags 任务标志，参考 sched.h

默认情况下仅显示比较重要的 PID、USER、PR、NI、VIRT、RES、SHR、S、%CPU、%MEM、TIME+、COMMAND 列。可以通过下面的快捷键来更改显示内容

#### Visual Studio Code

跨平台文本编辑器。

#### Eclipse

Java开发IDE。

#### 7zip

7-Zip is open source software. Most of the source code is under the GNU LGPL license. The unRAR code is under a mixed license: GNU LGPL + unRAR restrictions.7-Zip works in Windows 10 / 8 / 7 / Vista / XP / 2012 / 2008 / 2003 / 2000 / NT. There is a port of the command line version to Linux/Unix.安装7zip用于解压.7z结尾的文件：

<!-- more -->

```Bash
dnf install -y p7zip-plugins
```

使用如下命令解压文件：

```Bash
7z e Netty权威指南\ PDF完整版带目录书签.7z
```

输出的结果如下：

```
7-Zip [64] 16.02 : Copyright (c) 1999-2016 Igor Pavlov : 2016-05-21
p7zip Version 16.02 (locale=en_US.UTF-8,Utf16=on,HugeFiles=on,64 bits,8 CPUs Intel(R) Core(TM) i7-3632QM CPU @ 2.20GHz (306A9),ASM,AES-NI)

Scanning the drive for archives:
1 file, 61246559 bytes (59 MiB)

Extracting archive: Netty权威指南 PDF完整版带目录书签.7z
--
Path = Netty权威指南 PDF完整版带目录书签.7z
Type = 7z
Physical Size = 61246559
Headers Size = 306
Method = LZMA2:24
Solid = +
Blocks = 1

Everything is Ok                                                           

Files: 3
Size:       86833121
Compressed: 61246559
```

#### VLC Media Player

#### Electronic-Wechat

基于微信网页版微信，结合Electron开发的基于Linux的微信客户端。

#### Shutter

Linux下的截图工具。

#### Intellij Idea

Linux下Java开发必备工具。

#### FileZilla

#### Slack

#### Wireshark

#### Transmission

Linux下torrent下载工具。

#### Deluge

Linux下下载工具，支持磁力链接(Magnic Link)下载。

#### MPlayer

#### Graphiz

#### Putty

#### Google Chrome

#### FireFox

#### Google Earth

#### Lantern

#### Atom

#### aMule

#### TexStudio

#### Nutstore

跨平台的云同步软件。

#### Haroopad

跨平台Markdown编辑器。

#### KeePass

KeePass是一款密码管理软件，我的密码有100多个。平时没法全部都记住的，所以只需要记住一个KeePass密码即可。KeePass可以同时安装在Windows、Linux上。
