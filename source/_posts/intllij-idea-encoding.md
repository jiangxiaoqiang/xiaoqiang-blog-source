---
title: IntelliJ Idea使用总结与快捷键技巧
tags: [IntelliJ,IDE]
categories: Tool
date: 2016-09-26 14:23:24
---


#### 输入乱码

在控制台输入中文时显示的不是输入的汉字，而是显示正方形符号，此时输入的汉字显示乱码，如图所示。

{% asset_img intelli-idea-input-encode.jpg 输入时乱码%}

<!-- more -->

解决此问题，可使用支持中文较好的字体，覆盖默认字体，在Intellig Idea中的File-Settings-Appearance&Behavior-Appearance中(Ctrl + Alt + S)。如下图所示。

{% asset_img intelli-idea-override-default-font.jpg 覆盖默认字体%}

不过自己发现有一款英文字体TeXGyreAdventor特别喜欢，不想解决乱码问题，中文就只能眼睁睁看着它乱码了，一定要用这个字体。TeX Gyre Adventor字体家族是基于URW Gothic L字体家族，由Herb Lubalin和Tom Car­nase在1970年设计(The TEX Gyre Ad­ven­tor fam­ily of sans serif fonts is based on the URW Gothic L fam­ily. The orig­i­nal font, ITC Avant Garde Gothic, was de­signed by Herb Lubalin and Tom Car­nase in 1970; the URW font is com­monly used as a sub­sti­tute for the ITC orig­i­nal.)。在Debug控制台中Tomcat中输出乱码，可以打开Run/Debug Configuration,选择你的tomcat。在Server > VM options设置为<code>-Dfile.encoding=UTF-8</code> ，重启tomcat，其中参数-D代表Default，设置默认的文件编码是UTF-8。

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

使用Maven最头疼的就是从中央库下载jar包超级慢，等待下载jar包的感觉用重庆话讲：肚肠子把把逗紧了。解决办法就是使用私服地址，私服可以使用本地配置的Maven(不是Intellij Idea里面的boundle Maven)，修改Intellj Maven采用本机安装Maven在设置(Ctrl + Alt + S)中输入Maven，修改地址(例如：<code>D:\Source\zwnewplatform\javasoftware\runtime\apache-maven-3.3.9</code>)即可，如下图所示。

{% asset_img specify-maven-addr.jpg 修改Maven地址%}

#### 常用快捷键

Intellij Idea可以完全丢掉键盘工作，有点早期Vim和Emacs编辑器的味道。善用Intellij Idea编辑器可以大幅提高工作效率，用快捷键有一种装逼的感觉，装逼人士必备。如下是在Windows下的快捷键：

| 快捷键(Short Keys)  | 作用  |
| ----------------- |:-------------:|
| Ctrl + Shift + F12      | 编辑区全屏 |
| Ctrl + F4      | 关闭当前编辑文件      |
| Alt + 1 | 打开项目树视图,并将光标定位到当前编辑文件在项目树上的位置 |
| Alt + Home | 定位到导航条 |
| Ctrl + Shift + N| 定位到某一个文件(定位到指定文件) |
| Shift + Esc | 隐藏底部(如：Debug、TODO等)窗口 |
| F12 | 把焦点从编辑器移到最近使用的工具窗口，可用于显示底部(如：Debug、TODO等)对应窗口 |
| Alt + 5 | 激活Debug窗口 |
| Alt + 7 | 打开Structure窗口(Structure前面有一个带有下划线的5是快捷键提示) |
| Ctrl + N | 根据输入的类名查找类文件 |
| Ctrl + Shift + N | 查找文件 |
| Alt + Insert | 生成Getter、Setter |
| Ctrl + F12 | 在当前编辑的文件中快速导航 |
| Alt + F3(Search/Incremental Search ) |在编辑器中实现快速查查找功能 |
| Ctrl + J | 如果记不住Live Template的缩写，使用此快捷键可以弹出所有Live Template的缩写 |
| Ctrl + X | 删除行，剪切(Cut) |
| Ctrl + Alt + F12 | 显示当前项目树结构文件/文件夹所在目录，可以快速打开文件夹 |
| Ctrl + Shift + T(Test) | 选中类名，按下快捷键,创建一个新的测试Case |
| Ctrl + Shift + 数字键(NumPad)+ | 展开所有 |
| Ctrl + Shift + 数字键(NumPad)- | 折叠所有 |
| Ctrl +  数字键(NumPad)- | 在项目树上应用此快捷键可以折叠所有展开的文件夹 |
| Ctrl + F12 | 打开Intellij中嵌入的终端(Terminal) |
| Ctrl + B | 跳转到实现处 |
| Ctrl + F8 | 设置断点和取消设置断点 |
| Alt + Up/Down | 跳转到下一个方法或者属性 |
| Ctrl + Tab | 编辑窗口切换(切换Debug视图、编辑区类文件等) |
| Shift + F2/F2 | 跳到上/下一个错误处 |
| Alt + F1 | 选中目标，可以定位到文件等各种对象，Alt + F1弹出的界面中选择需要定位的对象，也可以理解成对象导航 |
| Shift + F6 | 重构、重命名 |
| Ctrl + Shift + F10 | 运行测试，注意运行测试时界面需要切换到测试类的界面 |
| Alt + F8 | 计算变量值 |
| Alt + Left/Right | 按左/右方向切换当前已打开的文件视图 |
| Ctrl + F10 | 更新资源和类文件，热部署(需要配置，部署时选择Exploded模式) |
| Ctrl + Shift + T | 新建测试类，在测试类与被测试类之间跳转 |
| Ctrl + Shift +F | 全文查找，类似于Eclipse的Ctrl + H |
| Ctrl + Shift + Alt + N | 全文搜索，包含Maven引用的jar包里面的内容，在搜索界面中，需要勾选Include non-project symbols |
| Ctrl + Alt + Left/Right | 到上一次/下一次编辑的位置 |
| Ctrl + Y | 删除光标所在行或删除选中的行 |
| Ctrl + P(Parameter) | 方法参数提示显示,当调用方法时未出现参数的智能提示时，可以手动显示方法的提示 |
| Ctrl + Q | 光标所在的变量/类名/方法名等上面（也可以在提示补充的时候按），显示文档内容 |
| Ctrl + Shift + Up/Down | 代码行上下移动 |
| Ctrl + Shift + U | 单词大小写切换 |
| Ctrl + W | 选中光标所在位置的单词(Words),递进式选择代码块。可选中光标所在的单词或段落，连续按会在原有选中的基础上再扩展选中范围 |
| Ctrl + Alt + O | 优化(Optimization)类的Import |
| Ctrl + H | 显示类的层次结构(Hierarchy) |
| Alt + F12 | 激活Terminal |
| Ctrl + Shift + F10 | 运行所有测试(不是特别好用) |
| Ctrl + Delete | 删除行 |
| Ctrl + Alt + O（Optimize） | 优化包导入 |

如下是在Mac OS X中的快捷键：

| 快捷键(Short Keys)  | 作用  |
| ----------------- |:-------------:|
| Commmand + , |  调出Setting界面 |
| Commmand + ； |  调出项目Setting界面 |
| Command + F4 | 关闭界面 |

##### 进入退出全屏

使用快捷键<code>Alt + V</code>打开View菜单，移动上下键选择<code>Enter Full Screen</code>即可。也可以自定义快捷键。

#### properties显示中文

使用IntelliJ Idea打开属性文件时，如果包含中文，显示为原始的编码，正确显示中文需要做如下设置，到设置(settings)中,可以使用快捷键Ctrl + Alt + S打开设置界面，找到<code>File Encoding</code>选项卡，选中<code>Default encoding for properties file</code>即可，如下图所示.

{% asset_img intellij-properties-encoding.png 属性文件编码设置%}

#### 限制编辑器Tab页个数

有时我们并不习惯在编辑器中打开太多的Tab页，如果不小心点开了7个以上的Tab页，在Tab页面中切换也蛮让人晕眩的，设置Tab页最大个数在Settings(Ctrl + Alt + S),Editor-General-Editor Tabs中，如下图如所示。

{% asset_img intellij-tabs-number-setting.png IntelliJ Idea编辑器Tab页设置%}

#### 类文件注释

通过File--》Setting--》File and Code Template中来设置类文件注释，如下图所示：

{% asset_img setting-class-comment.png 设置类文件注释%}

#### 格式化设置

有时在按下格式化按钮后，希望同时优化导入的包，自动移除未使用的包引用，在Intellij Idea中，可以在文件夹上右键，选择Reformate Code(Ctrl + Alt + L)，在弹出的界面中勾选Optimize Import即可。这样在每次按下格式化按钮时，会自动优化导入的包，比如自动移除未使用的包引用、自动排序等等。

{% asset_img reformate-code.png 格式化时优化导入包%}

#### 调试时卡住

在调试程序时，启动到一半时卡住，也没有发现断点按钮高亮，原来是在Mapper层的接口方法上添加了断点。打开断点（Breakpoints）视图，取消断点即可。


参考：

[Java开发必装的IntelliJ IDEA插件]
[Java开发必装的IntelliJ IDEA插件]:http://www.hollischuang.com/archives/966

[Surrounding Blocks of Code with Language Constructs]
[Surrounding Blocks of Code with Language Constructs]:https://www.jetbrains.com/help/idea/2016.2/surrounding-blocks-of-code-with-language-constructs.html
