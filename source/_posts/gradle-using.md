---
title: Gradle使用
date: 2016-12-27 16:23:37
tags:
- Gradle
categories: Programming
---

使用以下配置文件对Gradle的构建进行配置：

* Gradle构建脚本（build.gradle）指定了一个项目和它的任务。
* Gradle属性文件（gradle.properties）用来配置构建属性。
* Gradle设置文件（gradle.settings）对于只有一个项目的构建而言是可选的，如果我们的构建中包含多于一个项目，那么它就是必须的，因为它描述了哪一个项目参与构建。每一个多项目的构建都必须在项目结构的根目录中加入一个设置文件。

<!-- more -->

#### 基础

在Ubuntu 16.04 LTS中安装Gradle:

```Bash
sudo apt install gradle -y
```

如下列出了Gradle常用的命令：

```Bash
# 查看所有任务
gradle task
gradle task --all

# 查看所有项目
gradle projects

# 清楚app目录下的build文件夹
gradle clean

# 检查依赖并编译打包 （正式和测试）
gradle build

#编译并打Debug包
gradle assembleDebug

#编译并打Release包
gradle assembleRelease
```

定义一个依赖通常需要三个元素：

* group:创建该library的组织名，通常也会是包名，
* name :是该library的唯一标识
* version:该library的版本号

#### Wrapper

Wrapper主要是考虑在没有安装Gradle的电脑上使用Gradle命令。当执行gradlew(Gradle Wrapper)命令时，首先会检查电脑是否安装了Gradle，如果没有安装，会自动从gradle repository下载安装。需要查看Gradle Wrapper帮助，在命令行中输入如下命令：

```Bash
gradle Wrapper --help
```

会打印出所有Gradle Wrapper
