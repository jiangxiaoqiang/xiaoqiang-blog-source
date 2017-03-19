---
title: Ubuntu使用快捷键与技巧总结
date: 2016-12-20 22:58:25
tags:
- Ubuntu
categories: OS
---

使用的Ubuntu版本为14.04 LTS和16.04 LTS版本。

#### 软件管理

在Ubuntu下，常用的软件安装一条命令即搞定,跟上常用的软件名称即可，真的是一条命令安装所有软件,特别是重装系统之后，一条命令将原来的软件都安装完毕，节省了时间和精力，非常方便：

```Bash
# 安装常用软件(16.04 LTS及以后使用apt命令)
sudo apt install -y wget curl aria2 keepass2 putty vim tree unzip git
openssh-server uget maven gradle shutter nginx mysql-server nodejs 
texstudio virtualbox synaptic terminator gimp graphiz deluge zsh quiterss fail2ban
```

* synaptic是一款图形化的apt(Advance Package Tool)包管理器，可以轻松查看已经安装的包，未安装的包。terminator它支持分割终端,并可以在终端中快速切换.


查看已经安装了哪些软件：

```shell
sudo apt list --installed
```

卸载软件：

```Bash
# 卸载libreoffice，包括二进制文件、配置文件和数据文件
sudo apt remove -y --purge libreoffice*
# 移除包，包括二进制文件、配置文件和数据文件
sudo apt-get purge packagename
# 仅仅移除二进制文件而不会移除配置和数据文件
sudo apt-get remove packagename
```

有时在软件管理中心无法卸载，可以直接使用命令找到软件所在的目录强行删除，如下命令找到Intellij Idea的安装目录：

```shell
sudo find / \( -name intellij* -not -name "*.js" -not -name "*.svg" -not -name "*.md" \) -print
```

#### 字体

在Ubuntu下一些漂亮的字体记录。

| 字体名字                          | 说明                                       |
| ----------------------------- | ---------------------------------------- |
| Latin Modern Mono 10  Regular | 目前终端采用的这种字体                              |
| Courier                       | Courier是一个等宽的粗衬线字体，主要是依据打字机所打印出来的字形来设计，于1955年由Howard "Bud" Kettler设计完成。原来的Courier字体是IBM公司在1950年代设计给打印机使用的字体，但是并未维护他们的专利，使得这个字型成为整个打字机制造业的标准。 |
| Monospace                     | 等宽字体（英语：Monospaced Font）是指字符宽度相同的电脑字体。与此相对，字符宽度不尽相同的电脑字体称为比例字体。 |

#### 小技巧

* 长按Windows键会出现全局快捷键页面
* 在开发的过程中可以修改本机Host文件实现主机和IP的映射，这样在源码里只需要写上主机名称，如果某一个开发者想连接不同环境的主机进行调试，直接修改开发者本机的配置，这样不会影响其他开发者

##### 改变任务栏位置

改变任务栏位置是Ubuntu 16.04 LTS才加入的特性，所以低版本的运行此命令不会生效，如果要使之生效需要重新启动系统。

```Bash
# 任务栏显示在底部
gsettings set com.canonical.Unity.Launcher launcher-position Bottom
# 任务栏显示在左侧
gsettings set com.canonical.Unity.Launcher launcher-position Left
```

也可以使用GUI工具dconf-editor来设置，可以立即生效，不需重启系统。dconf is a low-level configuration system and settings management. Its main purpose is to provide a back end to GSettings on platforms that don't already have configuration storage systems. It depends on GLib. It is part of GNOME 3 and is a replacement for GConf.

```Bash
sudo apt-get install dconf-editor
```

安装好之后可以在该工具的 com – canonical – unity – launcher 中手动选择 Unity 在桌面中的所处位置。

##### 启用root用户

在Ubuntu Desktop 16.04中,root用户默认是禁用的,启用root用户:

```shell
sudo -i passwd root
```

输入root的密码即可.其中-i参数表示--login的含义.Run the shell specified by the target user's password database entry as a login shell.  This means that login-specific resource files such as .profile or .login will be read by the shell.If a command is specified, it is passed to the shell for execution via the shell's -c option.  If no command is specified, an interactive shell is executed.  sudo attempts to change to that user's home directory before running the shell.  The command is run with an environment similar to the one a user would receive at log in.

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

#### 打开程序

平时打开程序，可以直接按下Window键，输入程序名称，点击Enter键即可。还有可以使用`Window + Tab`快捷键，可以在启动菜单里切换相应的程序打开，因为Window+数字组合键只能打开最多9个程序，超过9个程序的可以使用此种方式打开。

#### 快捷键

|            快捷键             | 作用                                       |
| :------------------------: | :--------------------------------------- |
|       Ctrl + Alt + +       | 放大终端                                     |
|          Ctrl + -          | 缩小终端                                     |
|     Ctrl + Window + Up     | 最大化窗口，注意按下时按顺序按下相应键                      |
|    Ctrl + Window + Down    | 最小化窗口，注意按下时按顺序按下相应键                      |
|          Alt + F1          | 调出侧边栏(如果有设置自动隐藏的话)                       |
|         Alt + F10          | 打开面板上第一个菜单(注意在不同的面板里有不同的效果，多尝试并观察)       |
| Ctrl + Window + D(Desktop) | 显示桌面快捷键                                  |
|          Alt + F7          | 激活窗口移动功能                                 |
|          Alt(长按)           | 激活程序的菜单，即可使用程序的Alt快捷键组合了                 |
|          Alt(短按)           | 激活本应用程序的搜索菜单，即可在当前应用程序中搜索了               |
|          Alt + E           | 在Google Chrome浏览器中，可以打开浏览器右侧的菜单          |
|         Window + 1         | 打开Home目录(还可以用Window组合键打开其他目录)            |
|         Window + M         | 搜索音乐(Music)                              |
|         Window + A         | 搜索或浏览程序（Application）                     |
|         Window + F         | 搜索或浏览文件（File）                            |
|     Window + W(Window)     | 平铺模式列出所有窗口                               |
|       Ctrl + PageUp        | 切换到终端的上一个Tab页                            |
|      Ctrl + PageDown       | 切换到终端的下一个Tab页                            |
|      Ctrl + Shift + W      | 关闭终端当前Tab标签                              |
|      Ctrl + Shift + Q      | 关闭终端所有Tab标签                              |
|    Window + D(Desktop)     | 显示桌面，默认是没有此快捷键的，在系统的Keyboard Setting -> Navigation 中，设置Hide All Normal Windows的热键为Window + D即可 |
|          Ctrl + L          | 在Google Chrome中定位到地址栏                    |
|      Ctrl + a(ahead)       | 在Shell中光标移动到首字母                          |
|       Ctrl + e(end)        | 在Shell中光标移动到尾字母                          |
|      Ctrl + Shift + T      | 在Google Chrome浏览器中恢复历史记录                 |
|     Ctrl-Alt-Numpad 7      | 放置窗口到屏幕左上角。                              |
|     Ctrl-Alt-Numpad 8      | 置窗口到屏幕上半部分                               |
|     Ctrl-Alt-Numpad 9      | 放置窗口到屏幕右上角                               |
|     Ctrl-Alt-Numpad 4      | 放置窗口到屏幕左侧                                |
|     Ctrl-Alt-Numpad 5      | 在屏幕中间位置居中/最大化窗口                          |
|     Ctrl-Alt-Numpad 6      | 放置窗口到屏幕右侧                                |
|     Ctrl-Alt-Numpad 1      | 放置窗口到屏幕左下角                               |
|     Ctrl-Alt-Numpad 2      | 放置窗口到屏幕下半部分                              |
|     Ctrl-Alt-Numpad 3      | 放置窗口到屏幕右下角                               |
|     Ctrl-Alt-Numpad 0      | 最大化窗口                                    |

##### Bash Shell常用快捷键


| 快捷键              |             作用              |
| ---------------- | :-------------------------: |
| Ctrl + Alt + +   |            放大终端             |
| Ctrl + -         |            缩小终端             |
| Ctrl + a(ahead)  |       在Shell中光标移动到首字母       |
| Ctrl + e(end)    |       在Shell中光标移动到尾字母       |
| Ctrl + Shift + W |           关闭终端tab           |
| Ctrl + Shift + E | 在安装了Terminator之后，此快捷键水平分割终端 |
| Ctrl + Tab       |        在水平分割后的终端之间切换        |

#### 格式化U盘

卸载卷：

```Bash
umount /dev/sdb1
```

格式化:

```Bash
sudo mkfs.ext3 /dev/sdb1
```

参考资料：

* [维基百科Courier条目](https://zh.wikipedia.org/wiki/Courier)
