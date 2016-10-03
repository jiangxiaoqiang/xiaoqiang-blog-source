---
title: IntelliJ Idea技巧分享
tags: [IntelliJ,IDE]
categories: Programming
date: 2016-09-26 14:23:24
---


#### 输入乱码

输入时显示乱码，如图所示。

{% asset_img intelli-idea-input-encode.jpg 输入时乱码%}


<!-- more -->

使用支持中文较好的字体，覆盖默认字体，在File-Settings-Appearance&Behavior-Appearance。如图所示。

{% asset_img intelli-idea-override-default-font.jpg 覆盖默认字体%}

#### 智能提示敏感调整

在智能提示时默认大小写敏感，比如String的智能提示就必须首字母大写才能够准确定位，经常大小写切换，不是特别方便。在settings-Editor-General-Code Completion里设置后，可以省去大小写切换操作。

{% asset_img code-completion-case-sensitive.jpg 智能提示大小写敏感调整%}


#### Live Templates

Live templates帮助你快速、高效、精准的输入经常使用的或者自定义的代码片段(Live templates let you insert frequently-used or custom code constructs into your source code file quickly, efficiently, and accurately).相当于一个代码块的缩写，输入<code>Ctrl + J</code>会显示当前上下文中所有可用的模板。快速输入foreach，在方法内(一定要在方法里敲)输入iter + TAB。

##### 快速进行空判断

输入<code>ifn</code>，按TAB即可。

```Java
if (args == null) {

}
```

##### 快速输入Main方法

输入<code>psvm</code>,按TAB键即可。

```Java
public static void main(String[] args) {

}
```

#### Surround with

用于快速添加try catch等代码块，The Surround with feature allows you easily put expressions or statements within blocks or language constructs.快捷键为：<code>Ctrl + Alt + T</code>。


#### 重构(Reflactor)

##### 重命名(Rename)

Shift + F6,可以重命名你的类、方法、变量等等。

#### 主题(Theme)

更换默认主题在settings(Ctrl + Alt + S) –> editor –> colors & fonts –> general，如下图所示，如果需要修改主题的字体等是默认是不允许的，需要复制一个新的主题，再自定义修改相应的参数。

{% asset_img change-theme.jpg 修改默认主题%}

#### Maven配置

使用Maven最头疼的就是从中央库下载jar包超级慢，等待下载jar包的感觉用重庆话讲：肚肠子把把逗紧了。解决办法就是使用私服地址，私服可以使用本地配置的Maven(不是Intellij Idea里面的boundle Maven)，修改Intellj Maven采用本机安装Maven如下图所示。

{% asset_img specify-maven-addr.jpg 修改Maven地址%}

#### 常用快捷键

Intellij Idea可以完全丢掉键盘工作，有点早期Vim和Emacs编辑器的味道。善用Intellij Idea编辑器可以大幅提高工作效率，用快捷键有一种装逼的感觉，装逼人士必备。

| 快捷键(Short Keys)        | 作用           |
| ----------------- |:-------------:|
| Ctrl + Shift + F12      | 编辑区全屏 |
| Ctrl + F4      | 关闭当前编辑文件      |
| Alt + 1 | 打开项目树视图      |
| Alt + Home | 定位到导航条 |
| Ctrl + Shift + N| 定位到某一个文件(定位到指定文件) |
| Shift + Esc | 隐藏底部(如：Debug、TODO等)窗口 |
| F12 | 把焦点从编辑器移到最近使用的工具窗口，可用于显示底部(如：Debug、TODO等)对应窗口 |
| Alt + 5 | 激活Debug窗口 |
| Alt + 7 | 打开Structure窗口(Structure前面有一个带有下划线的5是快捷键提示) |
| Ctrl + N | 查找类 |
| Ctrl + Shift + N | 查找文件 |
| Alt + Insert | 生成Getter、Setter |
| Ctrl + F12 | 在当前编辑的文件中快速导航 |
| Alt + F3(Search/Incremental Search ) |在编辑器中实现快速查查找功能 |
| Ctrl + J | a执行一些你记不起来的Live Template缩写 |
| Ctrl + X | 删除行 |

##### 进入退出全屏

使用快捷键<code>Alt + V</code>打开View菜单，移动上下键选择<code>Enter Full Screen</code>即可。也可以自定义快捷键。


#### 注释模板


参考：

[Java开发必装的IntelliJ IDEA插件]
[Java开发必装的IntelliJ IDEA插件]:http://www.hollischuang.com/archives/966

[Surrounding Blocks of Code with Language Constructs]
[Surrounding Blocks of Code with Language Constructs]:https://www.jetbrains.com/help/idea/2016.2/surrounding-blocks-of-code-with-language-constructs.html
