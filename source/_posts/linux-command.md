---
title: Linux常用命令总结
tags:
  - Linux
categories: Programming
date: 2017-01-25 10:22:45
---


查看文件占用情况：

```Bash
du -alh
```

<!-- more -->

#### jobs命令

-l      显示进程组ID和作业在运行的目录。
-n     只显示上次显示过的已经停止的或已经退出的作业。
-p     只显示选定作业的进程组的进程ID.



#### find命令

find命令主要用于文件的查找。再当前目录下查找.txt和.pdf文件：

```shell
# 在本机中查找与Intellij有关，但是不包含JavaScript、svg、markdown文件
sudo find / \( -name intellij* -not -name "*.js" -not -name "*.svg" -not -name "*.md" \) -print
# 查找所有非txt的文件
find . ! -name "*.txt" -print
# 指定查找的深度，查询当前目录下的文件，如果是目录将f(file)换成d(directory)即可
find . -maxdepth 1 -type f
```
-o参数表示或者(or)的含义。其他的还包括-a，表示而且(and)的含义。-not,相反的含义。正则方式查找：

```shell
find . -regex  ".*\(\.txt|\.pdf\)$"
```

#### sudo命令

udo扮演的角色注定了它要在安全方面格外谨慎，否则就会导致非法用户攫取root权限。同时，它还要兼顾易用性，让系统管理员能够更有效，更方便地使用它。sudo设计者的宗旨是：给用户尽可能少的权限但仍允许完成他们的工作。所以，sudo有以下特点：

1. sudo能够限制指定用户在指定主机上运行某些命令。
2. sudo可以提供日志，忠实地记录每个用户使用sudo做了些什么，并且能将日志传到中心主机或者日志服务器。
3. sudo为系统管理员提供配置文件，允许系统管理员集中地管理用户的使用权限和使用的主机。它默认的存放位置是/etc/sudoers。
4.sudo使用时间戳文件来完成类似“检票”的系统。当用户执行sudo并且输入密码后，用户获得了一张默认存活期为5分钟的“入场券”（默认值可以在编译的时候改变）。超时以后，用户必须重新输入密码。


#### history命令

history命令可以查看shell的历史命令记录，shell默认保存的历史命令为1000条，验证此说法只需要打开`.bash_history`文件查看即可，如果计算机使用的时间足够长，那么最多有1000行命令记录。注销系统时，terminal会将所有的历史命令写入`.bash_history`文件。要修改历史命令保存的数量，如果需要排查用户执行的命令，也可以记录下命令执行时间等。

```shell
# 在.bash_history中保存命令的记录总数
HISTFILESIZE=10000
# history命令输出的记录总数
HISTSIZE=10000
HISTTIMEFORMAT='%F %T'
export HISTTIMEFORMAT
```

history命令可以查看shell的历史命令记录，shell默认保存的历史命令为1000条，验证此说法只需要打开`.bash_history`文件查看即可，如果计算机使用的时间足够长，那么最多有1000行命令记录。注销系统时，terminal会将所有的历史命令写入

history命令可以查看shell的历史命令记录，shell默认保存的历史命令为1000条，验证此说法只需要打开`.bash_history`文件查看即可，如果计算机使用的时间足够长，那么最多有1000行命令记录。注销系统时，terminal会将所有的历史命令写入


#### ls命令

```shell
# 列出当前目录下的目录，不列出文件
ls -d */
# 列出当前目录下的目录
ls -l|grep ^d
```

#### scp

scp是Secure Copy的簡稱m,scp的优点是使用简单，缺点是无法列出远端目录和改变目录。在做了免密登錄後，通過tab按鍵可以列出遠程目錄。

```Bash
#将本地文件夹上传到服务器
scp -r /tmp/local_dir username@servername:remote_dir
# 将服务器文件拷贝到本地
scp -r pi@192.168.1.113:/var/lib/daemon/GK ./
# 將遠程服務器文件拷貝到本地，並指定端口是22222
scp -P 22222 -r pi@192.168.1.113:/var/lib/daemon/GK ./
```

#### ss命令

ss(Socket Statistics)命令用于显示本机Sock统计信息。相比于其他工具，它可以显示更多的信息(It can display more TCP and state informations than other tools)。l查看监听端口。
```Bash
# 显示所有TCP Sockets
ss -t -a
# 查看ssh端口是否已经打开
ss -t -n -a|grep 22
```

t参数表示只显示TCP端口，n(number)表示以数字的方式显示，可以使用`ss --help`查看帮助。

#### lsof命令

```Bash

```

#### top命令

在top命令界面中，按x可以打开或者关闭排序列的加亮效果，默认是以CPU的使用率进行排序。按键盘b可以高亮当前正在运行的进程。按住`Shift + <`或者`Shift + >`可以在高亮不同列，并在对应列上进行升序排序。命令`top -c(command)`可以列出command列的完整参数。

交互参数：

* M：根据驻留内存大小进行排序
* k:终止一个进程
* P：根据CPU使用率的百分比大小进行排序

#### pushd命令

有时需要在不同的目录之间进行切换，当然可以使用cd命令，但是有一些问题，一是需要输入很多重复的命令，其次是记忆这些长的路径也比较费力。pushd命令可以部分解决这个痛点：

```shell
pushd /home/hldev/summarize/blogs/xiaoqiang-blogs
```

此命令会把当前目录压栈，并跳转到目标目录`/home/hldev/summarize/blogs/xiaoqiang-blogs`。使用`dirs -v`命令可以查看当前已经压入栈中的目录。

```shell
hldev@hldev-100:~/hldata/backend/credit-system$ dirs -v
 0  ~/hldata/backend/credit-system
 1  /home
 2  ~/summerize/xiaoqiang-blog-source/themes/next
 3  ~/summerize/xiaoqiang-blog-source/themes/next
 4  ~/summerize/jiangxiaoqiang.github.io
 5  ~
```

切换到压入栈中指定的目录只需要输入`pushd +N(pushd +2)`即可，N代表栈的编号。删除栈中的数据使用popd命令即可。

#### 判斷是否存在

```shell
myFile="/opt/app/backend/app.id"
# 这里的-f参数判断$myFile是否存在 
if [ ! -f "$myFile" ]; then 
	# 文件不存在
	touch "$myFile" 
fi

# 判斷進程是否存在
process=`ps aux | grep mysqld | grep -v grep`;
if [ "$process" == "" ]; then
    sleep 1;
    echo "no process";
else
	echo "process exsits";
	break;
fi
```

#### autojump

使用Terminal的过程中，有许多时间是在不同的目录之间切换，但是我们很难记住所有的目录并准确无误的输入相应的路径。切换的过程中不得不反复按下tab选择目标路径。其实在使用Linux的过程中，高频使用的目录是有限的。而autojump工具就是將目錄使用的頻率按照權重排序，並根據目錄權重幫助我們快速找到相應的工作目錄。

```shell
# Fedora 22及以后版本安装
sudo dnf install -y autojump
# Ubuntu上安装
sudo apt install -y autojump
```

获取数据autojump命令略显冗长，所以可以为autojump添加一个别名(alias)。在`~/.bashrc`文件中，添加如下一行：

```shell
alias j='autojump'
```

接着再运行`. ~/.bashrc`使之生效，或者重新开启一个终端(每次开启终端都会加载`.bashrc`文件)。

#### 命令参数传递

有时需要将一个命令的输出作为另一个命令的输入，可以采用如下的方式。

##### 反引号``

反引号括起来的字符串被shell解释为命令行，在执行时，shell首先执行该命令行，并以它的标准输出结果取代整个反引号（包括两个反引号）部分。例如将pwd命令的输出作为autojump命令的参数输入：

```shell
j -a `pwd`
# 采用$()的方式，与``的方式相同
j -a $(pwd)
# 可以采用xargs的方式，不过这里需要写命令autojump的全名
pwd | xargs autojump -a
```


