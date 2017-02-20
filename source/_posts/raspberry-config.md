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
  psk="cxyqw138597"
}
```


编辑完毕后重启wlan0，使用命令ifocnifg wlan0查看是否有IP，如有，则配置成功。

##### ssh自动启动



##### 无线设置(WLAN Setting)

Raspberry Pi 3内置了无线网卡，以前的版本是没有无线网卡的。只要对网卡有合适的设置就可以连接网络了。









参考资料：

[ETTING WIFI UP VIA THE COMMAND LINE](https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md)



