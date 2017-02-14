---
title: Linux常用配置
date: 2017-01-13 16:51:18
tags:
- Linux
categories: Programming
---

记录Linux常见的配置。

<!-- more -->

#### 主机名

如果想通过主机名访问，那么需要在服务端和客户端的hosts文件(`/etc/hosts`)中同时配置主机名和IP地址的映射。


#### 环境变量(Environment Variable)

`/etc/profile`文件在系统启动的时候运行，注销后也会运行。注意添加的内容要正确，否则系统可能会无法启动。`~/.bash_profile`文件每次启动终端时会运行，只对当前用户有效。
