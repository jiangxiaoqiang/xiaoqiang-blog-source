---
title: Fedora 20安装中文输入法
tags:
  - Fedora
date: 2016-10-03 11:08:51
---


#### 安装


```Bash
yum install scim
yum install scim-pinyin
```
SCIM(Smart Common Input Method)是基于GTK引擎，为GNOME/GTK环境下非英文/ASCII字符提供的输入。SCIM is a GTK-based input method engine for inputting non-English / non-ASCII characters in a GNOME/GTK environment. There is a KDE frontend called skim. 
它本身自带拼音、内码等输入法，同时提供简单的程序接口，方便程序员便捷的对其进行扩充。


#### 配置

在系统配置中添加安装的输入法，

{% asset_img setting-add-input-method.png 配置里添加输入法%}

选择输入法生效。

{% asset_img choose-input-method.png 选择输入法%}

