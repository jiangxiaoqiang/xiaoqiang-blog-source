---
title: JVM类加载
tags:
- jvm
categories: Programming
---

#### 概述


虚拟机把描述类的数据从Class文件加载到内存，并对数据进行校验、转换解析和初始化，最终形成可以被虚拟机直接使用的Java类型。类加载和连接的过程都是在运行期间完成的。

#### 类的加载方式


1. 本地编译好的class中直接加载
2. 网络加载：java.net.URLClassLoader可以加载url指定的类
3. 从jar、zip等等压缩文件加载类，自动解析jar文件找到class文件去加载util类
4. 从java源代码文件动态编译成为class文件


#### JVM三种预定义类型类加载器

当一个 JVM 启动的时候，Java 缺省开始使用如下三种类型类装入器：

启动（Bootstrap）类加载器：引导类装入器是用本地代码实现的类装入器，它负责将 <Java_Runtime_Home>/lib 下面的类库加载到内存中。由于引导类加载器涉及到虚拟机本地实现细节，开发者无法直接获取到启动类加载器的引用，所以不允许直接通过引用进行操作。

标准扩展（Extension）类加载器：扩展类加载器是由 Sun 的 ExtClassLoader（sun.misc.Launcher$ExtClassLoader） 实现的。它负责将
< Java_Runtime_Home >/lib/ext 或者由系统变量 java.ext.dir 指定位置中的类库加载到内存中。开发者可以直接使用标准扩展类加载器。

系统（System）类加载器：系统类加载器是由 Sun 的 AppClassLoader（sun.misc.Launcher$AppClassLoader）实现的。它负责将系统类路径（CLASSPATH）中指定的类库加载到内存中。开发者可以直接使用系统类加载器。

除了以上列举的三种类加载器，还有一种比较特殊的类型就是线程上下文类加载器，这个将在后面单独介绍。

a. Bootstrap ClassLoader/启动类加载器
主要负责jdk_home/lib目录下的核心 api 或 -Xbootclasspath 选项指定的jar包装入工作.

b. Extension ClassLoader/扩展类加载器
主要负责jdk_home/lib/ext目录下的jar包或 -Djava.ext.dirs 指定目录下的jar包装入工作

c. System ClassLoader/系统类加载器
主要负责java -classpath/-Djava.class.path所指的目录下的类与jar包装入工作.

d.  User Custom ClassLoader/用户自定义类加载器(java.lang.ClassLoader的子类)
在程序运行期间, 通过java.lang.ClassLoader的子类动态加载class文件, 体现java动态实时类装入特性.



[深入JVM系列（三）之类加载、类加载器、双亲委派机制与常见问题](http://blog.csdn.net/vernonzheng/article/details/8461380)
