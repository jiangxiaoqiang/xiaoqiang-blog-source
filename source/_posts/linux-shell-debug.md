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

可以看到脚本运行过程中输出的变量.如果脚本太长，可以在`.bash_profile`中设置如下的环境变量，打印出脚本的行号：

```shell
export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '
# 使环境变量生效
. .bash_profile
```

在设置环境变量之后不要忘记执行`. .bash_profile`命令。

#### 调试部分脚本



#### 日志输出

定义日志输出的函数：

```shell
# 
_log() {
    if [ "$_DEBUG" == "true" ]; then
        echo 1>&2 "$@"
    fi
}
```




参考资料:

* [Gradle finds wrong JAVA_HOME even though it's correctly set](http://stackoverflow.com/questions/22307516/gradle-finds-wrong-java-home-even-though-its-correctly-set)

* [如何调试BASH脚本](http://coolshell.cn/articles/1379.html)
