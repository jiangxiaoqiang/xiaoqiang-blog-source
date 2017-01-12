---
title: Ubuntu使用
date: 2016-12-20 22:58:25
tags:
- Ubuntu
categories: OS
---

使用的Ubuntu版本为14.04 LTS和16.04 LTS版本。

#### 软件安装

在Ubuntu下，常用的软件安装一条命令即搞定,跟上常用的软件名称即可，真的是一条命令安装所有软件,非常方便：

```Bash
# 安装常用软件(16.04 LTS及以后使用apt命令)
sudo apt install -y wget curl aria2 keepass2 putty vim tree unzip git
openssh-server uget maven gradle shutter nginx mysql-server nodejs 
texstudio virtualbox synaptic
```

synaptic是一款图形化的apt(Advance Package Tool)包管理器，可以轻松查看已经安装的包，未安装的包。

#### 字体

在Ubuntu下一些漂亮的字体记录。

| 字体名字 | 说明 |
|--------|--------|
| Latin Modern Mono 10  Regular |  目前终端采用的这种字体  |
| Courier | Courier是一个等宽的粗衬线字体，主要是依据打字机所打印出来的字形来设计，于1955年由Howard "Bud" Kettler设计完成。原来的Courier字体是IBM公司在1950年代设计给打印机使用的字体，但是并未维护他们的专利，使得这个字型成为整个打字机制造业的标准。 |
| Monospace | 等宽字体（英语：Monospaced Font）是指字符宽度相同的电脑字体。与此相对，字符宽度不尽相同的电脑字体称为比例字体。 |

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

参考资料：

* [维基百科Courier条目](https://zh.wikipedia.org/wiki/Courier)
