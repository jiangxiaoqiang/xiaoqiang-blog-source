---
title: Mac使用与技巧总结
date: 2017-01-01 14:53:36
tags:
- Mac
categoris: OS
---

#### 安装常用软件

brew是Mac下一款包管理器，默认是没有安装的。先安装包管理工具，其他软件可以通过包管理工具方便的安装。在终端中输入如下命令安装brew。

<!-- more -->

```Bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

安装完毕brew后，可以通过brew安装其他软件：

```Bash
# 安装Lantern
brew cask install Caskroom/cask/lantern
# 安装Google Chrome
brew cask install Caskroom/cask/google-chrome
# 安装Java
brew cask install java
# 安装PyCharm
brew cask install pycharm
# 安装wget
brew cask install wget
# 安装gradle
brew install gradle
# 列出已经安装的软件名字
brew list
# 列出通过cask命令安装的软件的名字
brew cask list
# 安装常用软件
brew install htop gradle nginx aria2 node openssl pcre sbt scala wget
```

有些命令安装软件是brew，而有些命令安装软件是brew cask。brew是从下载源码解压然后`./configure && make install`，同时会包含相关依存库。并自动配置好各种环境变量，而且易于卸载。而brew cask是已经编译好了的应用包(.dmg[Apple Disk Image]/.pkg)，仅仅是下载解压，放在统一的目录中(/opt/homebrew-cask/Caskroom)，省掉了自己去下载、解压、拖拽（安装）等步骤，同样，卸载相当容易与干净。这个对一般用户来说会比较方便，包含很多在AppStore里没有的常用软件。

brew默认的安装路径在/usr/local/bin下。

#### 设置root

打开终端，键入命令`sudo passwd root`,然后提示输入当前登录用户密码，通过以后，提示输入两遍root的密码。这样就设置好root帐号密码了，可以用root来登录MacOS了。打开终端，输入命令`su root`，输入密码即可．

#### 显示隐藏的文件夹

根目录有些文件夹默认是隐藏的，但是有时候配置的时候需要查看隐藏的目录,要显示隐藏的目录，运行如下命令即可．

```Bash
defaults write com.apple.finder AppleShowAllFiles -bool true
KillAll Finder
```

前往根目录，在Finder里按快捷键`Ctrl + Alt + G`．输入根目录符号/即可，可以看到原来没有显示的隐藏目录．

#### 设置Java环境变量

在当前用户的根目录下新建.bash_profiile隐藏文件。文件中添加如下内容：

```Bash
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home #jdk安装路径   
export PATH=$JAVA_HOME/bin:$PATH 
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
```

在终端下输入`env`命令可以查看当前系统的所有的环境变量。

#### 常用快捷键

| 快捷键(Short Keys)  | 作用  |
| ----------------- |:-------------:|
| ⌃ | Control |
| Control(⌃) + Command(⌘) + F(Full Screen)  | 终端进入(退出)全屏模式，其他程序也可以使用快捷键进行最大话(最适化) |
| Command + Shift + { | 在终端(Terminal)中向左切换Tab页 |
| Command + Shift + } | 在终端(Terminal)中向右切换Tab页 |
| Command + Space | 打开Spotlight，快速搜索应用 |
| Command + left | 在Google Chrome中后退 |
| Command + Enter | 在新的标签页里打开链接 |
| Command + Tab +Q | 在按Command + Tab出现运行程序列表后，按住Command键不松手，再按下Q键即可彻底退出程序 |
| Command + L(Location) | 在Google Chrome中，可以快读定位到浏览器的链接处 |
| Ctrl + Up | 到程序Tab页概览视图 |
| Ctrl + Down | 从概览视图的当前页，视图最适化 |
| Ctrl + Left/Right | 不同程序视图之间切换 |
| Command + Tab + Option | 先按住Command + Tab，切换到需要最大化的程序,接着松开Tab，Command键不松，按住Option键，松开Command即可 |
| Command + O/Down | 在Finder中打开文件 |
| Ctrl + Space | 输入法切换(用苹果的输入法即可) |
| Command + Option + Shift + Esc | 强制关闭当前活动的程序 |
| Command + Option + Esc | 打开强制关闭程序对话框 |
| 触摸板双指上下滑动 | 上下滚动当前屏幕的页面 |
| 触摸板三指上下滑动 | 最小化和最大化当前窗口（相当于F3） |
| Ctrl + A(Ahead) | 在终端中将光标跳到行头 |
| Ctrl + E(End) | 在终端中将光标跳到行尾 |
| Ctrl + R | 在终端中搜索已经使用过的命令 |
| Ctrl + Click | 相当于点击右键 |
| Command + Up／Down | 到Finder的上／下级目录 |
| 触摸板三指左右滑动 | 在不同应用界面之间切换 |
| Ctrl + C -> Option + Command + V | 剪切 |
| Command + Option + 电源按钮 | 将Mac置于睡眠状态 |
| Command + Option + Left／Right | 在Google Chrom中左右Tab页切换 |
| Command + Shift + 3 | 整个屏幕截图 |
| Command + Shift + 4 | 屏幕指定区域截图 |
| Command + Shift + H(Home) | 打开Home目录，相当于Window + E |
| Command + Shift + G(Go) | 跳转到指定文件夹，如果想跳转到Home目录，输入～即可，注意输入的路径要是完整的绝对路径 |
| Command + Shift + C(Computer) | 跳转到我的电脑 |
| Command + Option + Space | 打开电脑Finder搜索 |
| Command + Option + D（Dock） | 显示／隐藏Dock |
| Command + Ctrl + Space | 调出Emoj界面 |
| Fn + F11 | 显示桌面 | 

在Finder中，光标高亮在文件夹上按右键可以展开（Expand）子文件夹和子文件夹，按左键可以收拢（Toggle）子文件和子文件夹。选中文件后按下空格键，可以预览当前的文件。 


#### 设置Terminal颜色显示

Mac的终端下默认时没有颜色的，比如可执行文件和文件夹应该以不同的颜色表示。必须以命令`ls -G`才可以显示颜色。可以在bash_profile文件中添加如下内容即可：

```Bash
alias ls="ls -G"
```