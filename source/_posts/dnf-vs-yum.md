---
title: dnf与yum
tags:
  - dnf
  - yum
categories: Programming
date: 2016-10-05 20:44:41
---


Fedora 24使用yum命令时标记为过期，推荐使用dnf安装。想了解一下Fedora为什么要从yum转移到dnf。大致有如下几个原因：

<!-- more -->

* Dependency resolution of YUM is a nightmare(包依赖解析简直是噩梦--不觉得啊)
* YUM don’t have a documented API(没有API文档-很稀奇吗，没文档才正常吧)
* No support for extensions other than Python.
* Lower memory reduction and less automatic synchronization of metadata – a time taking process.

DNF包管理器克服了YUM包管理器的一些瓶颈，提升了包括用户体验，内存占用，依赖分析，运行速度等多方面的内容。DNF使用 RPM, libsolv 和 hawkey库进行包管理操作。DNF从Yum分支出来，使用专注于性能的C语言库hawkey进行依赖关系解析工作，大幅度提升包管理操作效率并降低内存消耗。Yum不能“Python 3 as default”，而DNF支持Python 2和Python 3。（Python 3分支自2008年发布以来积极开发了五年，已经成熟和稳定，而目前仍在维护的Python 2分支不增加新特性，只接受bug和安全修正，它最早的版本是在2000年发布的。）

#### dnf命令使用

```shell
# 移除软件包
sudo dnf erase packagename

```

参考资料来自：

[DNF – The Next Generation Package Management Utility for RPM Based Distributions]
[DNF – The Next Generation Package Management Utility for RPM Based Distributions]:http://www.tecmint.com/dnf-next-generation-package-management-utility-for-linux/
