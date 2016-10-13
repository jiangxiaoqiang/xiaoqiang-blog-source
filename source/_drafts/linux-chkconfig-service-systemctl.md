---
title: linux中的chkconfig、service和systemctl
tags:
- linux
- chkconfig
- systemctl
categories: Programming
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

原来是systemctl命令要逐渐取代原来的chkconfig和services命令。在目前很多linux的新发行版本里，系统对于daemon的启动管理方法不再采用SystemV形式，而是使用了sytemd的架构来管理daemon的启动。如果需要服务随计算机启动时启用，以SSH服务为例：

```
systemctl enable sshd.service
```

输出的执行结果为：

```
Created symlink from /etc/systemd/system/multi-user.target.wants/sshd.service to /usr/lib/systemd/system/sshd.service.
```
