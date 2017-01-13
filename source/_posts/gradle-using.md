---
title: Gradle使用
date: 2016-12-27 16:23:37
tags:
- Gradle
categories: Tool
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
# 安装指定版本的Gradle
sudo apt install -y gradle=2.12
```

如下列出了Gradle常用的命令：

```Bash
# 查看所有任务
gradle task
# 查看所有的任务(会列出task之间的依赖关系)
gradle task --all

# 查看所有项目(查看所有项目要切换到项目的根目录执行命令)
gradle projects

# 清楚app目录下的build文件夹
gradle clean

# 检查依赖并编译打包 （正式和测试）
gradle build

# 编译并打Debug包
gradle assembleDebug

# 编译并打Release包
gradle assembleRelease
```

定义一个依赖通常需要三个元素：

* group:创建该library的组织名，通常也会是包名，
* name :是该library的唯一标识
* version:该library的版本号

一个简单的打包命令：

```Bash
gradle -p cc-web-boot bootRun
```

-p参数指定项目(project directory)的目录，如果不指定就是当前目录(-p, --project-dir,Specifies the start directory for Gradle. Defaults to current directory)。bootRun指代的是当前项目下的任务名称。打包完成后，生成的包文件在对应项目文件的build/libs目录下。使用命令查看当前property：

```Bash
# 查看当前所有的Property
gradle properties
```

其中allprojects表示所有的Project，在多项目构建中，它将包含多个Project；buildDir表示构建结果的输出目录。

#### 插件(Plugin)

插件就是Gradle的扩展，简而言之就是为你添加一些非常有用的默认配置。Gradle 自带了很多插件，并且你也可以很容易的编写和分享自己的插件。Java plugin 作为其中之一，为你提供了诸如编译，测试，打包等一些功能。插件配置示例：

```
apply plugin: 'java'
apply plugin: 'propdeps'
apply plugin: 'org.springframework.boot'
```

#### Wrapper

Wrapper主要是考虑在没有安装Gradle的电脑上使用Gradle命令。当执行gradlew(Gradle Wrapper)命令时，首先会检查电脑是否安装了Gradle，如果没有安装，会自动从gradle repository下载安装。注意安装不会真的在计算机中安装Gradle的发行版本，它会下载Gradle，存放在目录`$USER_HOME/.gradle/wrapper/dists`下，构建时使用命令调用而不是直接添加到当前计算机(试想如果不同的Gradle版本，如果添加到系统的环境变量了，构建时到底是以调用哪一个版本的Gradle呢)。需要查看Gradle Wrapper帮助，在命令行中输入如下命令：

```Bash
gradle Wrapper --help
```

会打印出所有Gradle Wrapper.

#### Gradle界面(GUI)

在终端中输入如下命令可以查看Gradle的GUI：

```Bash
gradle --gui
```

#### 软件包管理

安装指定版本的软件可以使用如下命令：

```Bash
sudo apt install gradle=2.12
```

其中gradle是软件包的名称，2.12是软件包的版本。

#### 运行特定项目的任务

此处运行项目cc-web-boot下的bootRepackage任务：

```Bash
./gradlew build -p cc-web-boot/ bootRepackage -x test
```

如上命令在项目文件夹cc-web-boot下执行构建，并排除test任务，生成对应的jar包。bootRepackage任务依赖于Gradle assemble任务，assemble任务会编译程序中的源代码，并打包生成Jar文件，这个任务不执行单元测试。不使用spring-boot插件，主程序jar包，与依赖的jar包是分开的，需要分别打包，这在云环境中，上传部署比较麻烦，得传多个文件（或者上传前，先压缩成一个包，再传到服务器上解压），服务器节点多时，操作起来太累又重复。而使用spring-boot插件，会自动将依赖的包集成到主包里，非常方便。
