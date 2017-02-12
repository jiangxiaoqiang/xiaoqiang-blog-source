---
title: Raspberry Pi动手试用
date: 2017-02-08 11:30:48
tags:
- Raspberry Pi
categories: Equipment
---



#### 烧录操作系统(Burn Operation System)

目前可以安装到Raspberry Pi上的系统有，官方推荐的系统可以点击[这里](https://www.raspberrypi.org/downloads/)：

<!-- more -->

* [Ubuntu Mate]([http://ubuntu-mate.org/raspberry-pi/)
* [Raspbian](https://www.raspberrypi.org/downloads/)
* [Pidora](http://pidora.ca/)
* [snappy-raspi2](https://developer.ubuntu.com/core/get-started)

入手Raspberry Pi后，启动Raspberry Pi之前需要将Raspbian系统烧录到SD卡中。此时需要自备读卡器和Micro SD卡。首先到[官网](https://www.raspberrypi.org/downloads/raspbian/)下载镜像，选择RASPBIAN JESSIE WITH PIXEL，可以下载zip包，也可以下载torrent文件。zip包大概有1.5GB大小，解压出来4.4GB左右。由于此处试用的是Ubuntu操作系统，输入如下命令查看Micro SD卡卷标名称：

```shell
df -h
```

h表示human readable，已人机交互友好的方式显示系统当前可用卷的信息。此处查出的卷标名称为`/media/dolphin/9016-4EF8`。然后卸载此卷，使得用户不能对此卷进行操作：

```
umount /media/dolphin/9016-4EF8
```

注意这里必须要先卸载此卷，否则在使用dd命令刻录时会提示`/media/dolphin/9016-4EF8 is a directionay`，从而导致刻录失败。输入如下命令进行烧录：

```shell
sudo dd if=2012-12-16-wheezy-raspbian.img of=/media/dolphin/9016-4EF8 bs=2M
```

of(output file)参数后面不要添加斜杠。if表示input file，bs表示block size。输入命令后系统在后台刻录，前台可能看不到进度，此时只需要耐心等待即可。烧录完成之后，将SD卡插入Raspberry Pi的卡槽中，接通电源启动Raspberry。

参考资料：

[INSTALLING OPERATING SYSTEM IMAGES](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)