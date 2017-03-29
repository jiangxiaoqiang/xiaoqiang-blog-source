---
title: Linux文件恢復
date: 2017-03-27 20:43:47
tags:
- Recovery
categories: Tool
---

最近一不小心`Shift +　Delete`把珍藏的部分音樂刪除了。等到反應過來，爲時已玩。Linux下刪除文件不是真的刪除，是將文件的指針free，所以嘗試能否將文件恢復。

<!-- more -->

安裝工具：

```shell
sudo apt-get install extundelete -y
```

使用如下命令恢復：

```shell
sudo extundelete /dev/sda1 --restore-all
```

雖然恢復了一些文件，但是沒有恢復到想要的文件。所以還是不要手賤直接`Shift + Delete`。
