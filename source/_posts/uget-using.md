---
title: uget使用
date: 2016-12-25 13:55:12
tags:
- uget
categories: Software
---

uGet是一款Linux下的下载工具，uGet is the #1 Open Source Download Manager app.uGet is a multi-platform app for Linux, BSD, Android & Windows (XP - 8)。uGet下载最大的体会比较稳定，直观的感受是，用Google Chrome（中途可能变为速度为0的状态）和Wget(可能失去下载连接)无法下载的文件，使用uGet可以下载。

<!-- more -->

#### 安装

在Ubuntu 16.04中，输入如下命令安装uGet。

```
sudo apt install uget -y
```

打开uGet即可使用，如下图所示：

{% asset_img uget-ui.jpg uGet界面 %}

#### 插件(Plugin)

uGet可以作为aria2的UI，aria2下载工具特点：

* 支持http/https/ftp/bt协议
* 支持metalink3.0，metalink是一种可以将不同协议下载的同一文件集合到一起以达到最大下载稳定性和速度
* 支持分段下载和续传
* 支持通过http代理的ftp下载
* 可以作为守护进程(Deamon)运行

在Ubuntu 16.04中，输入如下命令安装aria2：

```Bash
sudo apt install aria2 -y
```

安装完毕后在uGet中(uget→编辑(Edit)→设置(Settings))进行设置即可，如下图所示：

{% asset_img uget-aria2-plugin-settings.jpg uGet aria2插件设置 %}
