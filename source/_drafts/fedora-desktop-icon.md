---
title: Fedora 24添加桌面图标
tags:
- Fedora
- Desktop Icon
categories: Programming
---

安装好了Google Chrome和Intellij Idea之后没有桌面图标，也没有快速启动图标，每次启动都要打开终端，甚是麻烦。故将图标放在桌面能够节省不少时间，同时也更加方便。首先安装gnome-tweak-tool:

```Bash
dnf install gnome-tweak-tool -y
```

运行<code>gnome-tweak-tool</code>命令，在弹出的窗口的Desktop选项卡中打开Icons on Desktop.

<!-- more -->

#### 桌面图标

切换到Desktop目录。

```Bash
cd /home/dolphin/Desktop
```

dolphin是当前用户名。新建Google-Chrome.desktop文件。内容为：

```Bash
#!/usr/bin/env xdg-open

[Desktop Entry]
Encoding=UTF-8
Name=Google Chrome
GenericName=Web Browser
Exec='/opt/google/chrome/google-chrome'
Icon=/opt/google/chrome/product_logo_256.png
Terminal=false
Type=Application
Categories=Network;
Name[en_US]=Google Chrome.desktop
```

保存之后双击打开，一定要双击打开哟，否则启动图标不会出现，会出现一个确认界面。提示需要授权启动项，选择授权即可。效果如图所示。

{% asset_img google-chrome-fedora-desktop-launcher.png Google-Chrome手动添加桌面图标%}


#### 快速启动图标

要让图标在快速启动栏里出现，直接将刚才新建Google-Chrome.desktop文件复制到<code>/usr/share/application</code>目录下即可。

```Bash
cp Google-Chrome.desktop /usr/share/application
```

{% asset_img google-chrome-startup-icon.png Google-Chrome快速启动图标%}