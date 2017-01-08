---
title: Linux Shell脚本调试
date: 2017-01-08 16:29:26
tags:
- Shell
- Linux
categories: Programming
---

在Ubuntu 14.04下安装Gradle之后,提示如下错误:

<!-- more -->

```
# gradle

ERROR: JAVA_HOME is set to an invalid directory: /usr/lib/jvm/default-java

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation.
```

打开Gradle脚本:

```Bash
vim /usr/bin/gradle
```

修改第70行为:

```Bash
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_101
```

再次运行Gradle命令,问题已经修复.在解决的过程中,可以是用命令调试Gradle脚本:

```Bash
bash -x /usr/bin/gradle
```

可以看到脚本运行过程中输出的变量.

参考资料:

* [Gradle finds wrong JAVA_HOME even though it's correctly set](http://stackoverflow.com/questions/22307516/gradle-finds-wrong-java-home-even-though-its-correctly-set)

* [如何调试BASH脚本](http://coolshell.cn/articles/1379.html)
