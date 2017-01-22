---
title: java cannot find symbol
date: 2017-01-17 22:31:13
tags:
- Java
categories: Programming
---

 在编译项目时，提示找不到符号，错误如下：

 ```
 Error:(40, 20) java: cannot find symbol
  symbol:   method setParams(java.lang.String)
  location: variable log of type creditsystem.data.model.OperationLog
 ```

<!-- more -->

启用Annotation Processor即可。Annotation Processor即为注解的处理器。与运行时注解RetentionPolicy.RUNTIME不同，Annotation Processor处理RetentionPolicy.SOURCE类型的注解。在Java代码编译阶段对标注RetentionPolicy.SOURCE类型的注解进行处理。这样在编译过程中添加代码，效率就非常高了。同样，Annotation Processor也可以实现IDE编写代码时的各种代码检验，例如当你在一个并未覆写任何父类方法的函数上添加了@Override注解，IDE会红线标识出你的函数提示错误。

同时安装Lombok插件。

在项目编译Scala文件时，提示如下错误：

```
Warning:scala: skipping Scala files without a Scala SDK in module(s) system import
```

要解决此问题，打开Project Structure(Ctrl + Alt + Shift + S)->Global Libraries，添加相应的Scala SDK即可，如下图所示。

{% asset_img scala-sdk-adding.jpg 添加scala SDK %}

所用的Intellij Idea为Ultimate版本，在Community版本里面没有作此设置可以正常运行。