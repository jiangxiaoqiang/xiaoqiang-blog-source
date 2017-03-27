---
title: MiniDLNA文件共享
date: 2017-03-01 15:52:54
tags:
- MiniDLNA
categories: Tool
---

MiniDLNA is server software with the aim of being fully compliant with DLNA(Digital Living Network Alliance)/UPnP clients. The MiniDNLA daemon serves media files (music, pictures, and video) to clients on a network. Example clients include applications such as totem and xbmc, and devices such as portable media players, smartphones, and televisions.MiniDLNA is a simple, lightweight alternative to MediaTomb, but has fewer features. It does not have a web interface for administration and must be configured by editing a text file.

<!-- more -->

在Raspberry Pi上下载文件完毕后，想直接通过局域网中的电脑直接播放Raspberry Pi上的媒体文件，不用再将文件拷贝到本地播放。其实再这里Raspberry Pi就是一个文件缓存服务器，可以解决视频卡顿的问题。这个任务可以使用MiniDLNA来完成，DLNA服务器搭建完毕后，就可以直接通过VLC播放Raspberry Pi上的内容了。在手机、PAD、Mac PC、Linux PC、Windows PC、高清电视上都可以播放Raspberry Pi上的内容，不用再将文件拷贝到各个设备上。

#### 安装

输入如下命令安装：

```shell
sudo dnf install -y minidlna
# Raspberry
sudo apt-get install -y minidlna
```

编辑minidlna配置文件`/etc/minidlna.conf`:

```shell
media_dir=/home/dolphin/dlna  #媒体文件目录
db_dir=/var/lib/minidlna    #minidlna通过SQLite来建立媒体库索引，因此需要定义数据库目录
listening_ip=192.168.1.111  #IP
port=8200                   #web端口，可以通过ip:port查看索引状态
friendly_name=Raspi_DLNA    #服务器命名
```

启动服务：

```shell
# 启动服务
sudo systemctl start minidlna
# 强制刷新DLNA
sudo service minidlna force-reload
#查看服务是否已经运行
ps -aux|grep minidlna
# 查看服务状态
service minidlna status
# MiniDLNA随机启动
sudo update-rc.d minidlna defaults
```

访问界面`http://127.0.0.1:8200/`。DLNA 支持的媒体格式：Image JPEG PNG, GIF, TIFF，Audio LPCM AAC, AC-3, ATRAC 3plus, MP3, WMA9，AV MPEG2 MPEG-1,MPEG-4*, AVC, WMV9

#### 常见问题

##### Media directory not accessible

启动的时候提示目录权限拒绝：

```
Mar 02 12:36:00 localhost.localdomain minidlnad[3874]: [2017/03/02 12:36:00] minidlna.c:614: error: Media directory "/home/dolphin/dlna" not accessible [Permission Denide]
```

原因是由于miniDLNA启动的时候，默认用户是minidlna。可以修改对应目录的权限为miniDLNA，也可以修改DLNA启动用户。这里采用的是后者的方式：

```shell
sudo chown -R dolphin:dolphin /var/run/minidlna
sudo chown -R dolphin:dolphin /var/lib/minidlna/
sudo chown -R dolphin:dolphin /var/cache/minidlna
rm /var/cache/minidlna/minidlna.log
```

在文件`/usr/lib/systemd/system/minidlna.service`中修改miniDLNA的启动用户为dolphin。

```shell
[Unit]
Description=MiniDLNA is a DLNA/UPnP-AV server software
After=syslog.target local-fs.target network.target

[Service]
User=dolphin
Group=dolphin
Type=simple
ExecStart=/usr/sbin/minidlnad -S

[Install]
WantedBy=multi-user.target
```

