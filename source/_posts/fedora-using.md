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
