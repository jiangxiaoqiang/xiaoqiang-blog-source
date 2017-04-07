---
title: 修改Mac地址
date: 2017-04-02 21:52:05
tags:
- Mac
categories: OS
---



#### 暂时修改

​    首先必须关闭网卡设备，否则会报告系统忙，无法更改。

        ```shell
sudo /sbin/ifconfig eth0 down
        ```

​    修改 MAC 地址，这一步较 Windows 中的修改要简单。

        ```shell
sudo /sbin/ifconfig eth0 hw ether 00:AA:BB:CC:DD:EE （你的MAC地址）
        ```

重新启用网卡

        ```shell
sudo /sbin/ifconfig eth0 up
        ```

网卡的 MAC 地址更改就完成了