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
