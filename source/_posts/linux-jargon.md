---
title: Linux术语含义
date: 2017-02-15 13:22:32
tags:
- Linux
categories: Programming
---



#### rc的含义

在Linux系统中，常常有结尾为rc的文件，例如:.bashrc、npmrc....。在使用linux系统中,脚本开机时自动运行，就要和/etc/rc.d/rc.local这个文件打交道，那么rc到底是什么含义呢？“**rc**”，它是“**runcomm**”的缩写――即名词“run command”(运行命令)的简写。来自麻省理工学院在 1965 年发展的 CTSS系统。相关文献曾记载这一段话："具有从档案中取出一系列命令来执行的功能；这称为 "run commands" 又称为 "runcom"。"rc”作为脚本类文件的后缀，这些脚本通常在程序的启动阶段被调用，通常是Linux系统启动时。如/etc/rc（连接到/etc/rc.d/rc）是Linux启动的主脚本，而.bashrc是当Linux的bash shell启动后所运行的脚本。.bashrc的前缀“.”是一个命名标准，它被设计用来在用户文件中隐藏那些用户指定的特殊文件;“ls”命令默认情况下不会列出此类文件，“rm”默认情况下也不会删除它们。许多程序在启动时，都需要“rc”后缀的初始文件或配置文件。

<!-- more -->

#### enp3so含义

在Ubuntu 16.04 LTS和Fedora 24中使用`ifconfig`命令查看时，发现以太网卡的名字竟然不是eth0，变成了enp3s0。是由于Ubuntu 16.04将systemd替换掉了initd来引导系统，原来习惯service什么的来控制系统服务什么的，现在竟然被systemctl这个命令替换了（虽然service依旧可用）。systemd带来的另外一个副作用（或者可以说是优点）就是网络接口的命名方式变了:

```
/*
 * Two character prefixes based on the type of interface:
 *   en — Ethernet
 *   sl — serial line IP (slip)
 *   wl — wlan
 *   ww — wwan
 *
 * Type of names:
 *   b<number>                             — BCMA bus core number
 *   c<bus_id>                             — CCW bus group name, without leading zeros [s390]
 *   o<index>[d<dev_port>]                 — on-board device index number
 *   s<slot>[f<function>][d<dev_port>]     — hotplug slot index number
 *   x<MAC>                                — MAC address
 *   [P<domain>]p<bus>s<slot>[f<function>][d<dev_port>]
 *                                         — PCI geographical location
 *   [P<domain>]p<bus>s<slot>[f<function>][u<port>][..][c<config>][i<interface>]
 *                                         — USB port number chain
 */
```

上面一段是systemd源码的注释，意思是:

1. en代表以太网卡
2. p3s0代表PCI接口的物理位置为(3, 0), 其中横座标代表bus，纵座标代表slot

