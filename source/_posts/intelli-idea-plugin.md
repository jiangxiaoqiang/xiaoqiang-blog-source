---
title: Intellij IDEA推荐插件
tags:
  - Plugin
  - Intellij
categories: Tool
date: 2016-10-08 13:46:41
---


#### presentation assistant

这款插件可以实时的在Intellij屏幕底部展示当前按下的快捷键，包括Windows的快捷键和Mac的快捷键，可以帮助您记忆快捷键，清楚当前的行为(Action)。效果如下图所示。

<!-- more -->

{% asset_img presentation-assistant-tips.jpg Presentation Assistant提示%}

#### Grep Console

允许你定义一系列将通过控制台输出或文件测试的正则表达式。匹配代码行的每个表达式将会影响整行的样式，或播放声音。例如，错误消息可以被设置在一个红色的背景中显示。例如错误(ERROR)输出为红色，报警(WARNING)输出为黄色，信息(INFO)输出为绿色。

#### JRebel for IntelliJ(Commercial)

JRebel的热部署可以让你修改代码以后不用重新启动项目即可加载效果，即所谓的热部署，可以大大提高开发效率。在IntelliJ Idea->Setting->Plugin->Browse Repositories中，输入JRebel for IntelliJ关键字即可。针对jar形式的开发，需要手动配置热替换代码的快捷键，这里配置的是`Ctrl + \`。

##### 激活

JRebel激活可以直接到[这里](https://my.jrebel.com),只需要在Facebook或者Twitter上面分享，即可获取1年使用时长的激活码。

##### 常见问题

###### IllegalArgumentException: Bean factory must allow eager class loading

在使用JRebel版本7.0.6时，提示如下错误：

> "IllegalArgumentException: Bean factory must allow eager class loading"

Spring Boot的版本是1.4.5。在GitHub上浏览到这篇[Issue](https://github.com/spring-projects/spring-boot/issues/8488)，原来是JRebel Plugin for Intellij Idea的Bug，下载了一个[每日构建版本(nightly build)](https://zeroturnaround.com/software/jrebel/download/nightly-build/)替换掉原来安装的发布版本即可正常使用JRebel。安装完毕后，在JRebel->Advance中显示如下图所示的安装信息。

{% asset_img jrebel-daily-build.png JRebel每日构建%}

#### Lombok

自动生成实体的Getter、Setter，可以大大减少实体的编码量。
