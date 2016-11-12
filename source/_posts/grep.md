---
title: grep使用
tags:
  - linux
  - grep
categories: Programming
date: 2016-11-12 12:25:45
---


grep (global search regular expression(RE) and print out the line,全面搜索正则表达式并把行打印出来)是一种强大的文本搜索工具，它能使用正则表达式搜索文本，并把匹配的行打印出来。

Unix的grep家族包括grep、egrep和fgrep。egrep和fgrep的命令只跟grep有很小不同。egrep是grep的扩展，支持更多的re元字符， fgrep就是fixed grep或fast grep，它们把所有的字母都看作单词，也就是说，正则表达式中的元字符表示回其自身的字面意义，不再特殊。linux使用GNU版本的grep。它功能更强，可以通过-G、-E、-F命令行选项来使用egrep和fgrep的功能。

<!-- more -->

#### 多个匹配模式

```Bash
 tail -f catalina.out | grep -e "苏E22222" -e "服务器"
```

使用此命令可以过滤catalina.out文件中包含`苏E22222`**且**包含`服务器`的内容。使用grep匹配“与”或者“或”模式grep命令加-e参数，这一扩展允许使用扩展模式匹配。例如，要抽取城市代码为2 1 9或2 1 6，方法如下：

```Bash
grep –E '219|216'
```

还可以为匹配的内容增加高亮的颜色。

```Bash
tail -f catalina.out |grep --color=auto -E 'topic|0194592|0720724|512|0146636|S000099'
```

选出不包含512且不包含topic的行。

```Bash
tail -f catalina.out |grep -v -E '512|topic'
```


