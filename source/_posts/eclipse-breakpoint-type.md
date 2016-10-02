---
title: Eclipse断点类型
tags: Eclipse
date: 2016-09-24 16:47:20
---


本文的Eclipse版本为:Eclipse Java EE IDE for Web Developers.

Version: Neon Release (4.6.0)
Build id: 20160613-1800


#### Line Breakpoint

Line Breakpoint是最简单的Eclipse断点，只要双击某行代码对应的左侧栏，就对该行设置上断点。断点的颜色为一个蓝色的实心点。

<!-- more -->

#### Watchpoint

关注某个关键变量的变化或使用。此时，就可以为该变量设置一种特殊的断点--Watchpoint。

{% asset_img watchpoint.jpg Watch Breakpoint%}


#### Method Breakpoint

关注程序对某个方法的调用情况，即，可以设置Method Breakpoint。

{% asset_img method-breakpoint.jpg Method Breakpoint%}

断点上的左右小箭头代表进入和退出方法时命中。

#### Exception Breakpoint

某个特定异常发生时程序能够被中断，以方便查看当时程序所处的状态。

{% asset_img exception-breakpoint.jpg Exception Breakpoint%}

#### Class Load Breakpoint

当某个类被加载时，通过该断点可以中断程序。

{% asset_img class-breakpoint.jpg Class Breakpoint%}


来自：

* [详解Eclipse断点]

[详解Eclipse断点]:http://www.blogjava.net/jiangshachina/archive/2011/11/20/364367.html
