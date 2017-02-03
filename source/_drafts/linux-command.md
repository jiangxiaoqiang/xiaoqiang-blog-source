---
title: Linux命令
tags:
- Linux
categories: Programming
---

查看文件占用情况：

```Bash
du -alh
```

#### scp

```Bash
#将本地文件夹上传到服务器
scp -r /tmp/local_dir username@servername:remote_dir
```

#### lsof

```Bash

```

#### history

查看历史命令。有时想执行一条历史命令，但是通过向上的按钮返回需要按许多次，此时可以使用`Ctrl + R`快捷键。输入命令关键字即可出现对应的历史命令，按下Enter键执行即可。如果想执行历史命令，可以在前输入感叹号，后面输入命令编号即可。

#### 查看进程信息

有时在Linux知道进程，但是不知道进程的具体目录，例如知道进程的信息如下：

```Bash
[hl@dn6 30507]$ ps aux |grep system
hl       11101  0.0  0.0 103240   924 pts/0    S+   16:20   0:00 grep system
hl       30507  3.8  7.5 7404324 1231252 ?     Sl   15:22   2:12 java -jar -Xmx2g system-web-boot-1.0.0.jar --spring.config.location=application-jenkins.properties
hl       32042  2.7  6.8 6655324 1103276 ?     Sl   15:22   1:34 java -jar -Xmx2g system-web-boot-1.0.0.jar --spring.config.location=application-jenkins_test.properties
```

Linux在启动一个进程时，系统会在/proc下创建一个以PID命名的文件夹，在该文件夹下会有我们的进程的信息，其中包括一个名为exe的文件即记录了绝对路径，通过`ll`或`ls –l`命令即可查看。


