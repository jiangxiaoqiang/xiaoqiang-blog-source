---
title: Linux操作系統的啓動流程
date: 2017-04-05 22:03:27
tags:
- Linux
categories: Programming
---

Linux操作系統的啓動流程一般是經過如下幾個步驟：

<!-- more -->

boot->init->runlevel->/etc/init.d->login shell->non-login shell。

#### login shell

login shell是用戶登錄時的，一般最常用的是图形界面登录，圖形界面登錄只加载 /etc/profile 和 ~/.profile。也就是说，~/.bash_profile 不管有没有，都不会运行。

#### non-login shell

用户进入操作系统以后，常常会再手动开启一个shell。这个shell就叫做 non-login shell，意思是它不同于登录时出现的那个shell，不读取/etc/profile和.profile等配置文件。但是會讀取.bashrc文件。





