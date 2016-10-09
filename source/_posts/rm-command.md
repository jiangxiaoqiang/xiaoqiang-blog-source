---
title: rm命令安全
tags:
  - Linux
  - rm
categories: Linux
date: 2016-10-08 11:25:38
---


rm命令是一个非常危险的命令，由于这个命令引发的事故不少，最近也是深深的体会到了。在此记录下如何将rm命令变为安全的命令。对于需要在Linux下开发的朋友来说，这一步(屏蔽rm危险操作)觉得是必须的，非常、非常、非常重要。怎么强调都不为过。一定要花时间做rm命令的安全工作。

<!-- more -->

#### 建立回收站机制

##### 回收站机制-建立新命令

在/usr/bin目录下建立文件erase：

```Bash
cd /usr/bin
touch erase
```

拷贝如下Shell脚本到文件中：

```Bash
#! /bin/bash
RecycleBin=~/.temp

(($#==0)) && { echo "No paraments!";exit 1; }

if [ ! -d $RecycleBin ]; then
    mkdir $RecycleBin
fi

for i in $*
do
    if test -e $i
        then
            cd $(dirname $i)
            mv -f $(basename $i) $RecycleBin/$(find $(pwd) -maxdepth 1 -name $(basename $i) | tr "/" "=")
            cd -
    else
        echo "$i:No such file or directory!"
    fi
done
```

添加执行权限：

```Bash
chmod 777 erase
```

此脚本会在用户目录下新建一个隐藏的temp文件夹，将删除的文件移动到此文件夹下。命名为：<code>=用户名=删除的文件名=</code>。
