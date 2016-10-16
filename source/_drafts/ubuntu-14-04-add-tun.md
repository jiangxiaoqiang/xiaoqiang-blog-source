---
title: ubuntu 14.04添加TUN模块
tags:
- Ubuntu
- TUN/TAP
- Kernel
categories: Programming
---

在使用OpenVPN时，提示没有TUN/TAP模块，惊讶于Ubuntu怎么没有编译这些模块，根据网络教程自己一步一步编译。

安装Source：

```Bash
sudo apt-get install linux-source
```
<!-- more -->

切换到Source目录下：

```Bash
cd /usr/src/linux-source-3.13.0/
```

解压出文件：

```Bash
tar xvjf linux-source-3.13.0.tar.bz2
```

x参数表示展开(Extract,Extract files from an archive. Arguments are optional.When given,they specify names of the archive members to be extracted.)。j参数表示Filter the archive through bzip2。切换到路径下，配置菜单：

```Bash
make menuconfig
```
编译内核模块：

```Bash
sudo make modules
```

替换为新编译内核。注意：千万不能运行命令make modules_install，否则将带来严重的后果，它会删除你系统中的所有模块，只安装刚刚编译的模块：

```Bash
sudo cp /usr/src/linux-source-3.2.0/linux-source-3.2.0/drivers/net/tun.ko /lib/modules/3.5.0-38-generic/kernel/net/tun.ko
depmod
```
.ko(Kernel Object)是内核模块文件，是内核加载的某个模块，一般是驱动程序。和linux中加载模块有关的几个命令分别如下：depmod(Dependency modules)，modprobe（modules Probe），lsmod(List modules)。
