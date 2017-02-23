---
title: Raspberry初始配置
date: 2017-02-18 15:51:53
tags:
- Raspberry
categories: Equipment
---

#### 网络配置(Network Config)

使用ssh连接上Raspberry之后，还无法上网。使用如下命令扫描无线热点：

<!-- more -->

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
  psk="cxyqw1387"
}
```


编辑完毕后重启wlan0，使用命令ifocnifg wlan0查看是否有IP，如有，则配置成功。

##### ssh自动启动



##### 无线设置(WLAN Setting)

Raspberry Pi 3内置了无线网卡，以前的版本是没有无线网卡的。只要对网卡有合适的设置就可以连接网络了。



#### 远程连接

可以使用远程桌面来访问Pi，过程也很简单，我通过iphone也连接到了Pi。在Pi上安装xrdp, 一个远程桌面的服务端：

```Bash
sudo apt-get install xrdp
```

安装好后xrdp就自动启动了，而且配置为随系统启动。在Fedora上安装rdesktop，一个远程桌面客户端：

```Bash
sudo yum install rdesktop 
```




参考资料：

[ETTING WIFI UP VIA THE COMMAND LINE](https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md)



