---
title: Raspberry搭建下载服务器
date: 2017-02-19 09:11:52
tags:
- Raspberry

---



###  Transmission

#### 安装Transmission

<!-- more -->

输入如下命令安装Transmission后端：

```shell
sudo apt-get update
sudo apt-get install transmission-daemon -y
sudo apt-get install transmission-cli -y
sudo apt-get install transmission-common -y
```

常用命令:

```shell
# 查看transmission的运行状态
service transmission-daemon status
# 启动daemon
service transmission-daemon start 
# 重新启动daemon
service transmission-daemon reload 
# 停止daemon
service transmission-daemon stop
# 添加下载任务
transmission-cli torrentfilename.torrent
```

#### 使用Transmission下载

### aMule

aMule是一款开源跨平台的文件分享(下载)工具.

#### 安装aMule

```shell
sudo apt-get install amule-daemon amule-utils -y
```

### Deluge

#### 安装

```shell
sudo apt-get install deluged -y
sudo apt-get install deluge-console -y
```





