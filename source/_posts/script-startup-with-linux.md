---
title: Linux开机自动启动程序
tags:
  - Linux
  - Startup Script
categories: Programming
date: 2016-10-14 17:45:50
---


#### 开机时自动运行

一般有守护进程的服务在Fedora 24中都可以通过systemctl命令自动运行。

```Bash
systemctl enable ServiceName
```

对于没有服务的程序，如果想在开机时随系统启动可以通过脚本来实现。

<!-- more -->

```Bash
nohup openvpn /etc/openvpn/client.conf
```

添加nohup后台启动，避免父进程结束的时候一并结束子进程。在<code>/etc/rc.d/rc.local</code>脚本中加入如下命令：

```Bash
/etc/openvpn/startopenvpn.sh
```

* 0:Halt
* 1:Single-user mode
* 2:Multi-user mode
* 3:Multi-user mode with networking
* 4:Not used/user-definable
* 5:Start the system normally with appropriate display manager (with GUI)
* 6:Reboot

#### 登录后自动运行程序

用户登录时，bash首先自动执行系统管理员建立的全局登录script:`/etc/profile`。然后bash在用户起始目录下按顺序查找三个特殊文件中的一个：`/.bash_profile`、`/.bash_login`、`/.profile`，但只执行最先找到的 一个。因此，只需根据实际需要在上述文件中加入命令就可以实现用户登录时自动运行某些程序（类似于DOS下的 Autoexec.bat）。简单的方法,在/etc/inittab 结尾加上你要启动的程序。/etc/profile： 此文件为系统的每个用户设置环境信息,当用户第一次登录时,该文件被执行。`/etc/bashrc`: 为每一个运行bash shell的用户执行此文件。`~/.bashrc`: 当登录时以及每次打开新的shell时,该文件被执行。设置登陆时启动OpenVPN,在<code>/etc/profile</code>文件中添加执行脚本：

```Bash
/etc/openvpn/startopenvpn.sh & >> /tmp/openvpn.log
```
其中startopenvpn.sh脚本中：

```Bash
cd /etc/openvpn
nohup openvpn /etc/openvpn/client.conf
```

需要注意的是，执行时需要切换到<code>/etc/openvpn</code>目录，默认的配置文件例如key等默认在当前目录下寻找。OpenVPN启动时需要root权限。需要成功启动OpenVPN客户端首次登陆时需要以root用户登陆。

Ubuntu开机之后会执行`/etc/rc.local`文件中的脚本，所以可以直接在`/etc/rc.local`中添加启动脚本。当然要添加到语句`exit 0`前面才行。如下rc.local脚本，在启动后自动运行XX-Net:

```Bash
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
nohup /opt/local/tools/XX-Net-3.2.8/start &
exit 0
```

#### 联网后自动运行程序

网络连接建立后运行的脚本可以实现诸多实用功能，如动态域名绑定、连接VPN、上网认证等。实现这一目标的大体思路有两种：在基于NetworkManager的系统中，可配置其dispatcher脚本；Fedora对这一功能支持的不是很好，只能在网络连接建立后运行一个脚本，即/sbin/ifup-local。这个文件默认不存在，需要手动创建。下面的例子用vi编辑/创建这个文件，并添加执行权限。

```Bash
vi /sbin/ifup-local
chmod 755 /sbin/ifup-local
```

[Runlevel]
[Runlevel]:https://en.wikipedia.org/wiki/Runlevel
