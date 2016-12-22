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

在Editor Tabs中切换比较耗费时间，可以尝试关闭Editor Tabs功能，关闭掉Editor Tabs功能还有一个好处是加载的时候会变快，因为不用加载Editor Tabs里打开的页面的内容了。关闭Editor Tabs功能按下`Ctrl + Alt + S`快捷键。搜索Editor Tabs关键字即可，在右侧Tab Appearence中选择None即可。关闭掉后直接可以通过Ctrl + E快捷键或者`Ctrl + Shift + E`快捷键访问文件。

#### 跳转到特定文件夹

在Intellij Idea中可以跳转到特定的文件夹，只需要按下两次Shift之后，在搜索的关键字前面加一个斜杠即可，如下图所示。

{% asset_img search-folder.jpg Intellij Idea跳转到指定文件夹%}

#### 自动补全分号

在语句的结尾补全分号，可以使用快捷键`Ctrl + Shift + Enter`，注意光标需要移动到补全分号的行。

#### 打开无快捷键的Tab

在Intellij Idea中有些Tab时没有快捷键的，比如Maven Projects。要打开可以使用快捷键`Ctrl + Alt + A`，输入Maven projects关键字即可。

#### 粘贴版历史

如果使用过 Mac 里面的 Alfred 的话，可能大家早就习惯了 Alfred 的粘贴板历史的能力，真是复制粘贴的神器啊。其实 Intellij IDEA 里面也提供了这样的能力，我们可以直接通过`Command + Shift + V`来进行访问历史粘贴板：

{% asset_img paste-history.jpg Intellij Idea历史粘贴板%}

#### Language Injection

在 Java 的 String 中编辑有 JSON 非常麻烦，在 Intellij IDEA 中，我们可以直接使用 Intellij IDEA 的 Language Injection 的功能（Alt + Enter）将一个字符串标记为 JSON，就可以非常方便地编写 JSON 了，再也不用担心转义的问题了：

{% asset_img language-injection.jpg Intellij Idea Language Injection%}

#### Intellij Idea注释模板

File -- Settings -- Editor -- Code Style -- File and Code Templates设置类生成模板。
