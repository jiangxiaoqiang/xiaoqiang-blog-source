---
title: meld使用
date: 2016-12-25 22:19:48
tags:
- Git
- Linux
- meld
categories: Programming
---

#### 简介

Meld is a visual diff and merge tool targeted at developers. Meld helps you compare files, directories, and version controlled projects. It provides two- and three-way comparison of both files and directories, and has support for many popular version control systems.

Meld helps you review code changes and understand patches. It might even help you to figure out what is going on in that merge you keep avoiding.

<!-- more -->

#### 安装与配置

输入如下命令安装：

```Bash
#在Fedora 24中安装
dnf install meld -y
#在Ubuntu 16.04中安装
sudo apt install meld -y
```

配置：

```Bash
#配置meld为默认的合并工具(Merge Tool)
git config --global merge.tool meld
```

使用合并工具：

```Bash
#使用merge tool合并
git mergetool
```
