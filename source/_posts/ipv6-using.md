---
title: IPv6使用经验总结
date: 2017-03-19 16:58:31
tags:
- IPv6
categories: Network
---

目前使用的长城网络，没有外网的IP，比如想做一个Git私服没有外网总归是不方便的。不知道是什么原因许多网站无法打开，可能是大部分人看看新浪、头条什么的就可以了。回家了就不再忙工作的事情了。

<!-- more -->

所以想试试IPv6能否使用，目前部分高校是开通了IPv6的，但是社会上估计是条件不成熟，基础设施不完善的缘故吧。12年实习的时候移动就已经在部署IPv6了，这么多年过去了，还是没见动静。

IPv6的特点:

- 128 bit address space, with a design goal of supporting 240 subnets organizing 250 hosts. While theoretically there are 340,282,366,920,938,463,463,374,607,431,768,211,456 addresses possible, this is unattainable in practice. IPv6 does offer multitudes of addresses per person, so we are unlikely to run out again.

340,282,366,920,938,463,46千3百3十7京4千6百07兆4千3百1十7亿6千8百2十1万1千4百5十6

#### 安装isatapd

在能够使用ipv6的网络下（目前教育网大多数是可以的），输入下面的命令，安装isatapd，就可以使用ipv6了：

```shell
sudo apt-get install isatapd
```

使用`ifconfig`命令查看网络连接，可以看到，此时ipv6已生效。但是此刻电脑并非在教育网下，并没有什么用。安装miredo，Miredo is an open-source Teredo IPv6 tunneling software, for the Linux, BSD and OS/X operating systems:

```shell
sudo apt-get install miredo -y
```

Teredo是一个IPv6转换机制，它可为运行在IPv4互联网但没有IPv6网络原生连接的支持IPv6的主机提供完全的连通性。与其他的类似协议不同，它可以在网络地址转换(NAT)设备（例如家庭路由器）后完成功能。Teredo服务器目前已经停用。所以*也没有*什么用，有IPv6地址，但是无法链接到任何一个IPv6网站。

#### 6to4















