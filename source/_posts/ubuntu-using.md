---
title: Ubuntu使用
date: 2016-12-20 22:58:25
tags:
- Ubuntu
categories: Programming
---

使用的Ubuntu版本为14.04 LTS和16.04 LTS版本。

#### 小技巧

* 长按Windows键会出现全局快捷键页面

##### 设置Terminal默认路径

一般情况下，在终端里有一个最高频的使用目录，希望打开终端时默认切换到此目录下。在Ubuntu里可以在Home目录下的bashrc`~/.bashrc`脚本里添加如下代码即可：

```Bash
if [ -d ~/document/blogs/jiangxiaoqiang/xiaoqiang-blog-source ];then
    cd ~/document/blogs/jiangxiaoqiang/xiaoqiang-blog-source
fi
```

下一次打开终端时默认路径即为：`~/document/blogs/jiangxiaoqiang/xiaoqiang-blog-source`

#### 快捷键

| 快捷键 | 作用 |
| ----------------- |:-------------:|
| Ctrl + Alt + + | 放大终端 |
| Ctrl + - | 缩小终端 |
| Ctrl + Window + Up | 最大化窗口，注意按下时按顺序按下相应键 |
| Ctrl + Window + Down | 最小化窗口，注意按下时按顺序按下相应键 |
| Alt + F1 | 调出侧边栏(如果有设置自动隐藏的话) |
