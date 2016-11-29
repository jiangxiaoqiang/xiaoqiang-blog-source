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
全局配置自动显示颜色：

```Bash
vim ~/.bashrc
alias grep='grep --color'
source ~/.bashrc
```

选出不包含512且不包含topic的行。

```Bash
tail -f catalina.out |grep -v -E '512|topic'
```

#### Grep正则表达式

^  锚定行的开始 如：’^grep’匹配所有以grep开头的行。如下语句匹配Tomcat日志输出所有开始为2016的行。

```Bash
tail -f catalina.out |grep -E "^2016"
```

过滤所有结尾为"}}"的行。

```Bash
tail -f catalina.out |grep -E "}}$"
```

.   匹配一个非换行符的字符 如：’gr.p’匹配gr后接一个任意字符，然后是p。

\*  匹配零个或多个先前字符 如：’ *grep’匹配所有一个或多个空格后紧跟grep的行。 .*一起用代表任意字符。

[] 匹配一个指定范围内的字符，如'[Gg]rep’匹配Grep和grep。

[^]  匹配一个不在指定范围内的字符，如：'[^A-FH-Z]rep’匹配不包含A-F和H-Z的一个字母开头，紧跟rep的行。

(..)  标记匹配字符，如：'(love)’，love被标记为1。

\>  锚定单词的结束，如’grep>’匹配包含以grep结尾的单词的行。

x{m} 连续重复字符x，m次，如：’o{5}’匹配包含连续5个o的行。

x{m,} 连续重复字符x,至少m次，如：’o{5,}’匹配至少连续有5个o的行。

x{m,n} 连续重复字符x，至少m次，不多于n次，如：’o{5,10}’匹配连续5–10个o的行。

w  匹配一个文字和数字字符，也就是[A-Za-z0-9]，如：’Gw*p’匹配以G后跟零个或多个文字或数字字符，然后是p。

W  w的反置形式，匹配一个非单词字符，如点号句号等。W*则可匹配多个。

b  单词锁定符，如: ‘bgrepb’只匹配grep，即只能是grep这个单词，两边均为空格。

#### 匹配条件附近相关内容

有时日志较大时，需要查看日志中央的内容，那么可以使用-C参数。参数后附加一个数，代表日志前后的行数。

```Bash
cat catalina.out | grep -C 500 '16 11 28 11 00 00' | grep '0720738'
```

以上命令查看满足日志中包含`16 11 28 11 00 00`且包含`0720738`的，前后500行的内容。如果是两个条件满足其中任意一个的话，使用如下命令：

```Bash
cat catalina.out | grep -C 500 -E '16 11 28 11 00 00|0720738'
```
