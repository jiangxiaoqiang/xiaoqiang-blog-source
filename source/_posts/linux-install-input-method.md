---
title: Linux输入法管理
date: 2016-12-19 23:40:49
tags:
- Linux
categories: OS
---

#### Ubuntu安装Google输入法

<!-- more -->

在Ubuntu下安装Google输入法，输入如下命令：

```Bash
sudo apt-get install -y fcitx-googlepinyin
im-config
```

安装配置完成后，重启电脑即可。


#### Ubuntu卸载输入法


输入如下命令卸载搜狗拼音输入法：

```Bash
sudo apt-get purge sougoupinyin
```