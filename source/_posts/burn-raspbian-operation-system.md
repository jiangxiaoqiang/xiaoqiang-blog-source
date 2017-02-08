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

入手Raspberry Pi后，启动Raspberry Pi之前需要将Raspbian系统烧录到SD卡中。此时需要自备读卡器和Micro SD卡。由于此处试用的是Ubuntu操作系统，输入如下命令进行烧录：

```shell
sudo dd if=2012-12-16-wheezy-raspbian.img of=/dev/mmcblk0 bs=2M
```

烧录完成之后，将SD卡插入Raspberry Pi的卡槽中，接通电源启动Raspberry。



参考资料：

[INSTALLING OPERATING SYSTEM IMAGES](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)