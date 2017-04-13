---
title: Fedora使用经验总结
date: 2017-01-17 10:29:33
tags:
- Fedora
categories: Programming
---

#### 常用操作

| 字体名称                  |  字号  |
| --------------------- | :--: |
| UM Typewriter Regular |  12  |

安装常用软件：

```Bash
# Fedora 22及以上版本
sudo dnf install -y git iostat keepass htop wget curl uget shutter mplayer vlc baobab jq zeal
```

| 软件名称 |    作用     |
| ---- | :-------: |
| jq   | Json格式化工具 |
| vlc  |   视频播放    |

##### 查看本机信息

```
# 本机IP
ifconfig -a
ethtool -P eth0
# 查看内核版本
cat /proc/version
# uname命令打印系统信息(Print System Infomation),-r参数表示kernel release
uname -r
```

ifconfig表示Interface Configuration.一般Linux，在`/etc/sysconfig/network-scripts`下找到ifcfg-eth0文件，编辑：

<!-- more -->

```
10.55.10.8
```

如果不知道哪个网络是有线网络，也可以先在界面上查看有线网络的相关设置，里面有相应的网络名称。另外，无限网络的密码除了在网络设置界面上看以外，也可以在目录`/etc/sysconfig/network-scripts`下看。直接使用超级用户打开目录下对应的key文件即可看到密码。另外查看内核版本也可以使用`lsb_release -a`命令，如下所示：

```
LSB Version:	:core-4.1-amd64:core-4.1-noarch
Distributor ID:	CentOS
Description:	CentOS Linux release 7.3.1611 (Core) 
Release:	7.3.1611
Codename:	Core
```

注:这个命令适用于所有的linux，包括Redhat、SuSE、Debian等发行版。

手动设置ip

#### 常用快捷键

| 快捷键(Short Keys)  |          作用           |
| ---------------- | :-------------------: |
| Windows + Space  |         切换输入法         |
| Ctrl + Alt + Tab |        切换键盘焦点         |
| Window + V       | Verbose,显示Fedora的通知窗口 |
| Window + S       |      平铺所有已经打开的窗口      |

#### 訪問Windows共享文件夾

首先，需要在Linux端安裝Samba-Common和Samba-Client包。創建windows共享文件夾，假如共享文件夾的名字是Share，用戶名是dolphin。在Fedora下，使用如下命令訪問共享文件夾：

```shell
smbclient -L //192.168.1.101/Share -U dolphin
```

之後可以使用get命令下載文件，使用put命令上傳文件。也可以使用如下命令直接掛載文件夾：

```shell
mount -t cifs //192.168.1.101/Share mytest -o username=dolphin,password=123456
```

其中cifs是通用网际文件系统(Common Internet File System)的縮寫。这个工具是 samba软件包的一部分。mount.cifs 用于挂载 CIFS 文件系统。它通常由使用"-t cifs"选项的 mount命令间接调用。这个命令只能在支持 CIFS 文件系统的Linux内核上使用。CIFS 协议是 SMB 协议的替代版本，它被包括 Windows 在内的几乎所有操作系统所以及 NAS(Network Attached Storage)应用和Samba服务器所支持。mount.cifs 可以将 service 表示的 UNC 名称挂载到本地的 mount-point 挂载点上。       service 使用 //server/share 语法，其中的"server"是主机名或者 IP 地址，而 "share" 是共享名。mount.cifs 的选项是用逗号分隔的 key=value 列表。除了下面列出的选项外，还可以使用其他选项，只要 cifs 文件系统内核模块(cifs.ko)支持即可。       不能被 cifs 文件系统内核模块(cifs.ko)识别的选项将会被记录到内核日志中。mount.cifs 将会启动一个名为 cifsd 的进程，并保持运行直到该资源被卸载(通常是通过 umount 工具)。

#### 安装MPlayer

输入如下命令安装MPlayer：

```Bash
#安装视频播放器MPlayer
dnf install -y mplayer
```

安装完毕后在终端中输入如下命令即可播放：

```Bash
#播放文件
mplayer Heidi.2015.海蒂和爷爷.720p.Chi_Ger.ZMZ-BD-MP4.mp4

#mplayer命令加文件名
mplayer filename
```

#### 磁盘分析器

从终端里启动磁盘使用分析器，只需输入Baobab，然后按回车键。

```Bash
#启动磁盘分析器
baobab
```

界面如下图所示：

{% asset_img baobo.png Baobo界面%}界面界面

#### RPM Fusion

RPM Fusion 是为 Fedora 及 Red Hat Enterprise Linux 用户提供的一个软件包仓库。要是想要安装的软件在官方的仓库中找不到，兴许通过 RPM Fusion 你就找到了。
