---
title: Fedora使用技巧
tags:
  - Fedora
  - Gnome
categories: Programming
date: 2016-10-21 23:53:36
---


如下是我在使用Fedora的时候整理的快捷键，网络上有许多快捷键版本，下表是经过测试可用并一直在使用的快捷键。

| 快捷键 | 作用 |
| ----------------- |:-------------:|
| Windows + A | 显示软件列表 |
| Windows + H | 隐藏当前窗口 |
| Alt + F10 | 最大化、还原当前窗口 |
| Alt + F2 | 打开命令行界面 |
| Windows/ Alt+ F2 | 在当前活动窗口和所有窗口概览视图之间切换 |
| Ctrl + Alt + Up/Down | 切换当前窗口 |
| Alt + Tab | 应用程序之间进行切换 |
| Windows + Left/Right/Up/Down | 将窗口移向左右、最大化、还原 |
| Windows + PageUp/PageDown | 切换工作区 |
| Ctrl + L | 清空终端(Terminal) |

<!-- more -->

#### 打开终端

在Ubuntu中打开终端可以使用快捷键Ctrl + Alt + T(Terminal)，在Fedora中打开All Settings->Keyboard->Custom Shortcuts，添加快捷键即可。在快捷键的command中输入：

```Bash
gnome-terminal
```

在平时使用中，总有一个目录是使用频率最高的，此时打开终端时可以默认切换到对应的目录，只需要将启动命令改为：

```Bash
gnome-terminal --working-directory=/home/dolphin/dolphin/project/blogs/xiaoqiang-blog-source
```

此时使用快捷键打开终端时默认为设置的目录，非常之方便。

#### 打开文件夹

在Fedora中打开All Settings->Keyboard->Custom Shortcuts，添加快捷键即可，这里设置的是Ctrl + Alt + H(Home)。在快捷键的command中输入命令：

```Bash
nautilus
```

即可打开文件夹。

#### 打开常用应用快捷键

在Fedora中打开All Settings->Keyboard->Custom Shortcuts，添加快捷键即可，这里设置的是。在快捷键的command中输入命令：

```Bash
#打开微信，Ctrl + Alt + W(WeChat)
/opt/electronic-wechat-linux-x64/electronic-wechat
#打开Google Chrome,快捷键设置为：Ctrl + Alt + G(Google Chrome)
/opt/google/chrome/chrome
```

即可快速打开微信,微信使用的是electronic-wechat，安装目录是/opt/electronic-wechat-linux-x64/。




[Useful keyboard shortcuts](https://help.gnome.org/users/gnome-help/3.12/shell-keyboard-shortcuts.html.en)
