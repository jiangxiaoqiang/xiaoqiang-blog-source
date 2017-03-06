---
title: Java反编译
date: 2017-02-26 19:46:43
tags:
- Java
- Decompiler
categories: Tool
---



虽然Java是完全开源的(除开极少量Sun也无权处理的代码)，但是有时候也需要反编译源代码。比如部署上线的系统，有一些细微的修改，但是单从界面上无法判断修改是否已经成功应用于目标环境，比如增加了一个字段后，后台未返回相应的字段数据。此时就需要排查原因了，可以反编译服务器上的jar文件查看是否有新增的代码从而排除编译阶段的问题。如下是有帮助的一些工具的总结。

<!-- more -->

#### JD GUI(GPLv3)

JD是Java Decompiler的缩写。它的目标是一个反编译Java 5及其后版本编译后的class文件的项目(The “Java Decompiler project” aims to develop tools in order to decompile and analyze Java 5 “byte code” and the later versions)。

JD GUI是Java Decompiler Graphics User Interface的缩写。是JD的一个图形化的工具(**JD-GUI** is a standalone graphical utility that displays Java source codes of “.class” files. You can browse the reconstructed source code with the JD-GUI for instant access to methods and fields)。

##### 获取JD GUI源码

官方有提供各种平台的安装文件，但是是托管在Amazon的云上的。估计是服务器在国外加上国内艰苦的上网环境。真的是下载不下来，往往是下载到部分了就到了授权时间(估计是Amazon对每个授权的Key做了时间限制)。一旦过了授权时间，又必须重头再来。还好在Github上有源码。使用如下命令下载源码：

```shell
git clone -depth=1 https://github.com/java-decompiler/jd-gui.git
```

添加depth=1参数，表示只克隆最新的版本代码即可，不包含历史版本和历史改动记录等等。主要是为了应对艰苦的网络环境，如果不加此参数，克隆是相当慢的，自己没有成功过，每次到60%多就不动了。

##### 构建

输入如下命令编译：

```shell
./gradlew build
```

构建Mac上的安装文件：

```shell
./gradlew installOsxDist
```

构建完成后，生成的文件在目录(`jd-gui/build/install/jd-gui-osx`)下，切换到目录下运行相应脚本(`universalJavaApplicationStub.sh`)启动程序即可。如果在Ubuntu下，使用如下命令安装：

```shell
cd /jd-gui/build/distributions
# 查看Deb包信息,-i相当于--info
sudo dpkg -I example.deb
# 安装Deb包，i相当于Install
sudo dpkg -i example.deb 
```

#### JAD

[JAD](https://varaneckas.com/jad/)是一个可以使用命令行反编译.class文件的工具。使用jad，先解压出来jar文件。

```shell
jar -xvf test.jar -C classes
```

再使用jad工具反编译即可：

```shell
[jad_home]/jad.exe -r -ff -d src -s Java classes/**/*.class 
```