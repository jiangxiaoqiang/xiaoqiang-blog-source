---
title: Ubuntu主题调整
date: 2017-02-06 10:20:41
tags:
- Linux
- Ubuntu
categories: OS
---


#### 安装工具

输入如下命令安装Unity调整工具，Unity是基于GNOME桌面环境的用户界面, 由Canonical公司开发，主要用于Ubuntu操作系统。：

<!-- more -->

```Bash
sudo apt install -y unity-tweak-tool
```

#### 安装Flatabulous主题

Flatabulous主题是一款ubuntu下扁平化主题，也是我试过众多主题中最喜欢的一个！最终效果如上述图所示。

执行以下命令安装Flatabulous主题：

```Bash
sudo add-apt-repository ppa:noobslab/themes
sudo apt-get update
sudo apt-get install flatabulous-theme
```

该主题有配套的图标，安装方式如下：

```Bash
sudo add-apt-repository ppa:noobslab/icons
sudo apt-get update
sudo apt-get install ultra-flat-icons
```

安装完成后，打开unity-tweak-tool软件，修改主题和图标,进入Theme，修改为Flatabulous，效果如下图所示：

{asset_img ubuntu-flatabulous-theme.png Flatabulous主题效果}
