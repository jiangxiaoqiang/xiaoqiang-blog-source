---
title: Linux Shell脚本
date: 2017-01-08 16:29:26
tags:
- Shell
- Linux
categories: Programming
---

在Linux中，shell脚本能够帮助我们快速的完成指定的任务。

<!-- more -->

#### 错误处理

使用`set -u`，当使用未初始化的变量时，让bash自动退出。你写的每一个脚本的开始都应该包含set -e。这告诉bash一但有任何一个语句返回非真的值，则退出bash。使用-e的好处是避免错误滚雪球般的变成严重错误，能尽早的捕获错误。

#### 脚本调试

在Ubuntu 14.04下安装Gradle之后,提示如下错误:

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

#### bash专用调试器

```shell
sudo apt install bashdb -y
```

在执行Linux脚本时，有时需要改变脚本的执行路径，将执行路径切换到执行脚本所在的路径，此时可以使用如下命令运行脚本：

```shell
source example.sh
. example.sh
```

在脚本里面写上`cd /your/path`即可。如果不使用source命令，则执行脚本的路径不会是预期路径，执行脚本时候，只是在当前的shell下开了一个子进程，切换目录的操作只对该进程中相关后续指令有效，但改变不了父进程的目录。


参考资料:

* [Gradle finds wrong JAVA_HOME even though it's correctly set](http://stackoverflow.com/questions/22307516/gradle-finds-wrong-java-home-even-though-its-correctly-set)

* [如何调试BASH脚本](http://coolshell.cn/articles/1379.html)
