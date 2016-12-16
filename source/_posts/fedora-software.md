---
title: Fedora常用软件集合
tags:
  - Fedora
categories: Programming
date: 2016-12-16 23:32:33
---


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

#### KeePass

KeePass是一款密码管理软件，我的密码有100多个。平时没法全部都记住的，所以只需要记住一个KeePass密码即可。KeePass可以同时安装在Windows、Linux上。
