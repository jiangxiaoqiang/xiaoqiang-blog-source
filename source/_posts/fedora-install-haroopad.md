---
title: Fedora安装Haroopad
date: 2017-03-13 12:23:58
tags:
- Fedora
- Haroopad
categories: Tool
---

Haroopad是一款跨平台的Markdown编辑器，在Ubuntu中通过简单的命令可以安装，但是在Fedora中的安装方式第一次遇见，特此记录再此。Fedora版本是24，Haroopad版本是0.13.1 64位。

<!-- more -->

#### 下载

输入如下命令下载Haroopad对应的版本：

```shell
wget -c https://bitbucket.org/rhiokim/haroopad-download/downloads/haroopad-v0.13.1_amd64.tar.gz
```

#### 安装

输入如下命令安装Haroopad：

```shell
tar -zxvf haroopad-v0.13.1_amd64.tar.gz
tar -zxvf data.tar.gz
sudo cp -r ./usr /

tar zxf control.tar.gz
chmod 755 postinst
sudo ./postinst
```

此处安装是直接将解压出来的文件拷贝倒对应的目录下。

#### 图标

在`/usr/share/applications`目录下新建Haroopad.desktop文件。

```shell
[Desktop Entry]
Name=haroopad
Version=0.12.2
Exec='/usr/bin/haroopad'
Comment=The Next Document processor based on Markdown
Icon=/usr/share/icons/hicolor/128x128/apps/haroopad.png
Type=Application
Terminal=false
StartupNotify=true
Encoding=UTF-8
Categories=Development;GTK;GNOME;
```

将Desktop文件拷贝倒目录`/home/dolphin/Desktop`目录下，图标可显示在桌面。在快捷菜单里面显示有时需要重新启动电脑才生效。

