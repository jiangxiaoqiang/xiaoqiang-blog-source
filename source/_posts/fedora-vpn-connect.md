---
title: Fedora设置VPN连接
tags:
  - Fedora
  - VPN
categories: OS
date: 2016-12-10 21:46:18
---


在家里需要连接学校的VPN，家里的电脑安装的时Fedora 24。原以为会非常复杂，其实设置非常简单。

<!-- more -->

家里的电脑使用的时Wi-Fi,打开Wi-Fi设置（Wi-Fi Settings）,如下图所示。

{% asset_img open-vpn-add.jpg VPN设置 %}

选择VPN之后，选择与微软兼容的点对点隧道协议(Point-to-Point Tunneling Protocol-PPTP),Compatible with Microsoft and other PPTP VPN servers。在进入的新界面中，General下的Gatway填写域名。Optional中填写好用户名即可，密码会在打开VPN时提示填入。下图是设置成功后的界面：

{% asset_img open-vpn-setting-result.jpg 设置成功 %}
