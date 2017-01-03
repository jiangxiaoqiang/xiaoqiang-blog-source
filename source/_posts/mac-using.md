---
title: Mac使用
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
```

有些命令安装软件是brew，而有些命令安装软件是brew cask。brew是从下载源码解压然后`./configure && make install`，同时会包含相关依存库。并自动配置好各种环境变量，而且易于卸载。而brew cask是已经编译好了的应用包(.dmg[Apple Disk Image]/.pkg)，仅仅是下载解压，放在统一的目录中(/opt/homebrew-cask/Caskroom)，省掉了自己去下载、解压、拖拽（安装）等步骤，同样，卸载相当容易与干净。这个对一般用户来说会比较方便，包含很多在AppStore里没有的常用软件。

#### 设置Java环境变量

在当前用户的根目录下新建.bash_profiile隐藏文件。文件中添加如下内容：

```Bash
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home #jdk安装路径   
export PATH=$JAVA_HOME/bin:$PATH 
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
```

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
