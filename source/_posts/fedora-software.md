---
title: Fedora常用软件集合
tags:
  - Fedora
categories: Programming
date: 2016-12-16 23:32:33
---

使用Fedora 24有一段时间了，这里列出了平时总结的在Fedora上可以使用的一些软件，完成平时的任务。如果您也要尝试使用Fedora，或许可以节省不少时间。列出的软件大多数是跨平台(Crossplatform)的，可以运行在其他Linux发行版上，以及Mac OS和Windows上。

<!-- more -->

### 网络(Network)

#### httrack

网页下载与缓存。

#### wget

```Bash
wget -c http://dl.zeroturnaround.com/idea/jr-ide-intellij-6.5.0_13-16.zip
```

-c参数表示断点续传。--continue： Continue getting a partially-downloaded file.  This is useful when you want to finish up a download started by a previous instance of Wget, or by another program.


#### uGet

uGet is the #1 Open Source Download Manager app.uGet is a multi-platform app for Linux, BSD, Android & Windows (XP - 8)



#### 编程开发（Development）

#### NodeJS

本博客就是基于NodeJS生成，虽然不是很懂NodeJS，但是感觉很牛逼的样子。

#### nmap

端口扫描。

#### Fiddler for Linux

#### Apache Tomcat

#### OpenVPN

#### StarDict

#### htop

htop是实时显示当前系统运行情况的，不同于ps、pstree、pidof、vmsta等这些快照工具，快照工具只能显示命令执行前一秒系统的情况。htop 对关键信息实行高亮显示，对于我们用肉眼查看进程信息的情况相当友好。



| 列名 | 含义 |
| ----------------- |:-------------:|
| PID | 进程id |
| PPID | 父进程id |
| RUSER | Real user name |
| UID | 进程所有者的用户id |
| TTY | 启动进程的终端名。不是从终端启动的进程则显示为 ?|
| PR | 优先级 |
| NI | nice值。负值表示高优先级，正值表示低优先级 |
| P | 最后使用的CPU，仅在多CPU环境下有意义 |
| %CPU | 上次更新到现在的CPU时间占用百分比 |
| VIRT(Virtual) | 进程使用的虚拟内存总量，单位kb。VIRT=SWAP+RES |
| TIME | 进程使用的CPU时间总计，单位秒 |
| SHR(Share) | 共享内存大小，单位kb |
| TIME+ | 进程使用的CPU时间总计，单位1/100秒 |
| %MEM | 进程使用的物理内存百分比 |
| SWAP | 进程使用的虚拟内存中，被换出的大小，单位kb |
| S(Status) | 进程状态（D=不可中断的睡眠状态，R=运行，S=睡眠，T=跟踪/停止，Z=僵尸进程） |
| RES | 进程使用的、未被换出的物理内存大小，单位kb。RES=CODE+DATA |
| CODE | 可执行代码占用的物理内存大小，单位kb |
| DATA | 可执行代码以外的部分(数据段+栈)占用的物理内存大小，单位kb |
| nFLT | 页面错误次数 |
| nDRT | 最后一次写入到现在，被修改过的页面数 |
| WCHAN | 若该进程在睡眠，则显示睡眠中的系统函数名 |
| Flags | 任务标志，参考 sched.h |

默认情况下仅显示比较重要的 PID、USER、PR、NI、VIRT、RES、SHR、S、%CPU、%MEM、TIME+、COMMAND 列。可以通过下面的快捷键来更改显示内容

{% asset_img htop-ui.jpg htop界面 %}

上图说明计算机有8个内核，8GB的内存，8GB的交换空间(Swap Space)。

#### Visual Studio Code

跨平台文本编辑器。

#### Eclipse

Java开发IDE。

#### 7zip

7-Zip is open source software. Most of the source code is under the GNU LGPL license. The unRAR code is under a mixed license: GNU LGPL + unRAR restrictions.7-Zip works in Windows 10 / 8 / 7 / Vista / XP / 2012 / 2008 / 2003 / 2000 / NT. There is a port of the command line version to Linux/Unix.安装7zip用于解压.7z结尾的文件：



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

### 影音娱乐(Media&Entertainment)

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

Google Chrome浏览器的好处之一就是，只要登陆Google的账号后，它会把你的搜索记录、插件、Cookie等同步到云端，这样回家之后可以接着处理工作上遗留的问题。比如在办公室研究某个问题到一半，回家打开浏览器搜索关键字会快速出现办公时研究的关键字，相当方便。还有你的历史浏览记录，在不同的设备上使用即时同步，不同设备（PC、Laptop）、平台（Windows和Fedora）使用习惯无缝对接。

#### FireFox

#### Google Earth

#### Lantern

如果平时需要用Google搜索一些资料，Lantern是一款必不可少的工具。

#### xx-net

如果平时需要用Google搜索一些资料，xx-net是一款必不可少的工具。

#### Atom

#### aMule

#### TexStudio

#### Nutstore

跨平台的云同步软件。

#### Haroopad

跨平台Markdown编辑器。

### 工具(Tools)

#### KeePass

KeePass是一款密码管理软件，我的密码有100多个。平时没法全部都记住的，所以只需要记住一个KeePass密码即可。KeePass可以同时安装在Windows、Linux上。

#### albert

Albert is a desktop agnostic launcher, inspired by the ease of use of OSX' Alfred launcher. Its goals are usability and beauty, performance and extensability. It is written in C++ and based on the Qt framework.

