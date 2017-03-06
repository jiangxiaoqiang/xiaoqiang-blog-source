---
title: minidlna-file-share
date: 2017-03-01 15:52:54
tags:
---

MiniDLNA is server software with the aim of being fully compliant with DLNA(Digital Living Network Alliance)/UPnP clients. The MiniDNLA daemon serves media files (music, pictures, and video) to clients on a network. Example clients include applications such as totem and xbmc, and devices such as portable media players, smartphones, and televisions.MiniDLNA is a simple, lightweight alternative to MediaTomb, but has fewer features. It does not have a web interface for administration and must be configured by editing a text file.

<!-- more -->

#### 安装

在Fedora 24下，输入如下命令安装：

```shell
dnf install -y minidlna
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
```

访问界面`http://127.0.0.1:8200/`。
