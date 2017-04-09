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