---
title: Raspberry Pi 3 Model B配置
date: 2017-02-18 15:51:53
tags:
- Raspberry
categories: Equipment
---

Raspberry Pi经过各种改造，可以有不同的用途，包括但不限于如下用途：

* 一个24小时在线下载的微型服务器(BitTorrent下载机)
* 一个微型的Web网络服务器，托管个人网站等
* 一个微型的科学上网代理服务器(Tor Router...)，或者叫家用 VPN 服务器
* 搭建一个微型广播站，实现自己的广播(FM广播系统)
* 一个路由器
* 家庭NAS(Network Access Storage)
* XBMC操作系统打造家庭影院(XMBC 多媒体中心)
* 添加一个摄像头做一个监控(Web Cam 服务器)
* 有声书籍播放器
* 一个Git服务器
* 私有云服务ownCloud，可以在任何地方，包括用手机，上传下载文件，同步日历等
* 一个闹钟

但是在实现如上功能之前还是需要一步一步从最开始进行配置。

<!-- more -->

#### 网络配置(Network Config)

使用ssh连接上Raspberry之后，还无法上网。使用如下命令扫描无线热点：

````shell
sudo iwlist wlan0 scan
````

修改无线配置文件：

```
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```

添加密码:

```json
network={    
  ssid="76D2"    
  psk="cxyqw138597"
}
```


编辑完毕后重启wlan0，使用命令`ifocnifg wlan0`查看是否有IP，如有，则配置成功。如果没有，使用命令`sudo reboot`重启Raspberry。重启后，到路由器管理界面查看Raspberry的IP。

{% asset_img raspberry-ip.png 链接无线网络获取的IP %}

##### ssh自动启动



##### 无线设置(WLAN Setting)

Raspberry Pi 3内置了无线网卡，以前的版本是没有无线网卡的。只要对网卡有合适的设置就可以连接网络了。

#### 安装常用软件

```shell
sudo apt-get install -y minidlna htop youtube-dl
```







参考资料：

[ETTING WIFI UP VIA THE COMMAND LINE](https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md)



