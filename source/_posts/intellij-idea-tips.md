---
title: Intellij Idea小技巧(tips)
tags:
  - Intellij Idea
  - tips
categories: Programming
date: 2016-11-03 09:51:27
---


#### 键盘调整Debug窗口的大小


键盘调整Debug窗口的大小快捷键是`Ctrl + Shift + Up/Down`，注意一定要定位到Debug视图，也就是Debug视图但是当前窗口的活跃(Active)视图才会生效。

<!-- more -->

同理，在调整项目树宽度时，可以使用快捷键`Ctrl + Alt + Left/Right`。

#### Debug视图Tab页切换

快捷键是Shift + Tab，如下图所示。

{% asset_img intelli-idea-debug-view-convert.jpg Intellij Idea的Debug视图Tab页切换%}

#### Debug视图日志滚动到末尾

如果想在Debug视图中将日志始终定位到末尾，可以点击左侧的Scroll To End按钮，也可以使用快捷键`Ctrl + End`。

#### Debug视图清空日志

清空日志没有快捷键，但是可以使用键盘上的鼠标右键来做到。

#### 关闭Editor Tabs

在Editor Tabs中切换比较耗费时间，可以尝试关闭Editor Tabs功能，关闭掉Editor Tabs功能还有一个好处是加载的时候会变快，因为不用加载Editor Tabs里打开的页面的内容了。关闭Editor Tabs功能按下Ctrl + Alt + S快捷键。搜索Editor Tabs关键字即可，在右侧Tab Appearence中选择None即可。关闭掉后直接可以通过Ctrl + E快捷键或者Ctrl + Shift + E快捷键访问文件。

#### 跳转到特定文件夹

在Intellij Idea中可以跳转到特定的文件夹，只需要按下两次Shift之后，在搜索的关键字前面加一个斜杠即可，如下图所示。

{% asset_img search-folder.jpg Intellij Idea跳转到指定文件夹%}
