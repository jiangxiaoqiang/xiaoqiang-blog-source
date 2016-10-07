---
title: rm命令安全
tags:
- Linux
- rm
categories: Linux
---

rm命令是一个非常危险的命令，由于这个命令引发的事故不少，最近也是深深的体会到了。在此记录下如何将rm命令变为安全的命令。对于需要在Linux下开发的朋友来说，这一步(屏蔽rm危险操作)觉得是必须的，非常、非常、非常重要。怎么强调都不为过。

#### 建立回收站机制


1. 在/home/username/ 目录下新建一个目录，命名为：.trash
2.. 在/home/username/tools/目录下，新建一个shell文件，命名为： remove.sh


```Bash
PARA_CNT=$#
TRASH_DIR="/home/username/.trash"

for i in $*; do
    STAMP=`date +%s`
    fileName=`basename $i`
    mv $i $TRASH_DIR/$fileName.$STAMP
done
```

3. 修改~/.bashrc， 增加一行
alias rm="sh /home/username/tools/remove.sh"
用我们自建的remove.sh替代rm命令

4. 设置crontab，定期清空垃圾箱，如：
0 0 * * * rm -rf /home/username/.trash/*
每天0点清空垃圾箱