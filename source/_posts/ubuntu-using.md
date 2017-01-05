---
title: Ubuntu使用
date: 2016-12-20 22:58:25
tags:
- Ubuntu
categories: OS
---

使用的Ubuntu版本为14.04 LTS和16.04 LTS版本。

#### 字体

在Ubuntu下一些漂亮的字体记录。

| 字体名字 | 说明 |
|--------|--------|
| Latin Modern Mono 10  Regular |  目前终端采用的这种字体  |

#### 小技巧

* 长按Windows键会出现全局快捷键页面

#### 设置截屏快捷键

在安装好了Shutter之后，每次截取屏幕都需要打开Shutter，点击Selection按钮。其实可以配置截屏的快捷键，就像QQ的`Ctrl + Alt + A`一样。如下图所示：

{% asset_img shutter-selection-shortkey.png Ubuntu截图设置快捷键%}

##### 设置Terminal默认路径

一般情况下，在终端里有一个最高频的使用目录，希望打开终端时默认切换到此目录下。在Ubuntu里可以在Home目录下的bashrc`~/.bashrc`脚本里添加如下代码即可：

```Bash
if [ -d ~/document/blogs/jiangxiaoqiang/xiaoqiang-blog-source ];then
    cd ~/document/blogs/jiangxiaoqiang/xiaoqiang-blog-source
fi
```

代码的含义是，如果当前目录不在`~/document/blogs/jiangxiaoqiang/xiaoqiang-blog-source`目录下，那么就切换到此目录。下一次打开终端时默认路径即为：`~/document/blogs/jiangxiaoqiang/xiaoqiang-blog-source`

#### 快捷键

| 快捷键 | 作用 |
| ----------------- |:-------------:|
| Ctrl + Alt + + | 放大终端 |
| Ctrl + - | 缩小终端 |
| Ctrl + Window + Up | 最大化窗口，注意按下时按顺序按下相应键 |
| Ctrl + Window + Down | 最小化窗口，注意按下时按顺序按下相应键 |
| Alt + F1 | 调出侧边栏(如果有设置自动隐藏的话) |
| Ctrl + Window + D(Desktop) | 显示桌面快捷键 |
| Alt + F7 | 激活窗口移动功能 |
| Alt(长按) | 激活程序的菜单，即可使用程序的Alt快捷键组合了 |
| Alt(短按) | 激活本应用程序的搜索菜单，即可在当前应用程序中搜索了 |
| Alt + E | 在Google Chrome浏览器中，可以打开浏览器右侧的菜单 |
|　Window + 1　| 打开Home目录(还可以用Window组合键打开其他目录) |
