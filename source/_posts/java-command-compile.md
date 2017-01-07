---
title: 使用命令行编译运行Java
date: 2017-01-08 00:12:31
tags:
- Java
- Javac
categories: Programming
---

在旧的电脑上打开IDE还是比较慢的，有时只需要运行一段很小的代码片段(Snippet),没有必要搬出IDE,所以就直接使用命令来编译,逼格高,速度快.

<!-- more -->

直接新建一个Java文件,名字叫xiaoqiang.java,输入简单的内容:

```Java
public class xiaoqiang{
      public static void main(String args[]){
        System.out.println("My name is xiaoqiang.");
      }
    }
```

保存后,输入如下命令编译:

```Bash
# Java编译器(Compiler)
javac xiaoqiang.java
```

编译完毕后,会生成一个xiaoqiang.class文件.输入如下命令运行程序:

```Bash
java xiaoqiang
```

输出为:My name is xiaoqiang.以后就可以直接写代码片段了,查看效果就可以简单的用命令搞定即可.研究一些代码片段非常方便.
