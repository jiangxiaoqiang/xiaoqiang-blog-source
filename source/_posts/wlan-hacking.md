---
title: wlan破解
date: 2017-03-18 22:12:00
tags:
- WLAN
categories: Security
---

#### 激活无线网卡至monitor即监听模式

<!-- more -->

```shell
sudo airmon-ng start wlan0
```

start 后跟无线网卡设备名称。


#### 探测无线网络，抓取无线数据包

在正式抓包之前，一般都是先进行预来探测，来获取当前无线网络概况，包括AP的SSID、MAC地址、工作频道、无线客户端MAC及数量等。只需打开一个Shell，输入具体命令如下：

```shell
sudo airodump-ng mon0
```

```shell
airodump-ng --ivs -w longas -c 3 wlan0 
```

