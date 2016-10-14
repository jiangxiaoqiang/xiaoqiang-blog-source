---
title: linux中的chkconfig、service和systemctl
tags:
  - linux
  - chkconfig
  - systemctl
categories: Programming
date: 2016-10-13 09:04:58
---


最近在Fedora里使用开机自动启动命令时，提示如下：

```
Note: This output shows SysV services only and does not include native
      systemd services. SysV configuration data might be overridden by native
      systemd configuration.

      If you want to list systemd services use 'systemctl list-unit-files'.
      To see services enabled on particular target use
      'systemctl list-dependencies [target]'.
```

<!-- more -->

原来是systemctl命令要逐渐取代原来的chkconfig和services命令。在目前很多linux的新发行版本里，系统对于daemon的启动管理方法不再采用SystemV形式，而是使用了sytemd的架构来管理daemon的启动。UpStart\SystemV\systemd三种形式。Linux 操作系统的启动首先从 BIOS 开始，接下来进入 boot loader，由 bootloader 载入内核，进行内核初始化。内核初始化的最后一步就是启动 pid 为 1 的 init 进程。这个进程是系统的第一个进程。它负责产生其他所有用户进程。大多数 Linux 发行版的 init 系统是和 System V 相兼容的，被称为 sysvinit。这是人们最熟悉的 init 系统。一些发行版如 Slackware 采用的是 BSD 风格 Init 系统，这种风格使用较少。其他的发行版如 Gentoo 是自己定制的。Ubuntu 和 RHEL 采用 upstart 替代了传统的 sysvinit。而 Fedora 从版本 15 开始使用了一个被称为 systemd 的新 init 系统。如果需要服务随计算机启动时启用，在Fedora 24中，以SSH服务为例：

```
systemctl enable sshd.service
```
这样SSH守护进程就会在开机时自动启动了。
输出的执行结果为：

```
Created symlink from /etc/systemd/system/multi-user.target.wants/sshd.service to /usr/lib/systemd/system/sshd.service.
```

查看SSH守护进程当前的状态。

```Bash
systemctl start sshd.service
```

在 Linux 主要应用于服务器和 PC 机的时代，SysVinit 运行非常良好，概念简单清晰。它主要依赖于 Shell 脚本，这就决定了它的最大弱点：启动太慢。在很少重新启动的 Server 上，这个缺点并不重要。而当 Linux 被应用到移动终端设备的时候，启动慢就成了一个大问题。为了更快地启动，人们开始改进 sysvinit，先后出现了 upstart 和 systemd 这两个主要的新一代 init 系统。Upstart 已经开发了 8 年多，在不少系统中已经替换 sysvinit。Systemd 出现较晚，但发展更快，大有取代 upstart 的趋势。而SystemV对应的是service、UpStart对应的是chkconfig、systemd对应的是systemctl命令。

参考来源：

[浅析 Linux 初始化 init 系统，第 1 部分: sysvinit]
[浅析 Linux 初始化 init 系统，第 1 部分: sysvinit]:https://www.ibm.com/developerworks/cn/linux/1407_liuming_init1/
