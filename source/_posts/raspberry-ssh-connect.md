---
title: Raspberry SSH连接
date: 2017-03-11 23:09:03
tags:
- SSH
categories: Equipment
---

装好系统的树霉派，如果没有购买屏幕，可以直接使用网线与电脑连接。剩下的步骤就是获取树霉派的IP和使用SSH进行连接了。

<!-- more -->

#### 获取IP

仅仅是网线和电脑相连还无法直接获取树霉派的IP，需要对电脑做如下图所示的设置，编辑有线网络连接，找到IPv4设定，在Method上勾选上与其他网络共享选项，此处使用的是Ubuntu：

{% asset_img share-network.png 共享有线网络%}

设置之后，使用如下命令获取树霉派的IP：

```shell
arp -a
```

这里获取到的树霉派的IP是：`10.42.0.22`。接下来就可以通过命令`ssh pi@10.42.0.22`登陆Raspberry Pi了。
