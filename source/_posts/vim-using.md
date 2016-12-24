---
title: vim使用
date: 2016-12-24 23:51:47
tags:
- vim
categories: Programming
---

#### 替換（substitute）

```
:[range]s/pattern/string/[c,e,g,i]
```

<!-- more -->

range	指的是範圍，1,7 指從第一行至第七行，1,$ 指從第一行至最後一行，也就是整篇文章，也可以 % 代表。還記得嗎？ % 是目前編輯的文章，# 是前一次編輯的文章。
pattern	就是要被替換掉的字串，可以用 regexp 來表示。
string	將 pattern 由 string 所取代。
c	confirm，每次替換前會詢問。
e	不顯示 error。
g	globe，不詢問，整行替換。
i	ignore 不分大小寫。
 

g 大概都是要加的，否則只會替換每一行的第一個符合字串。可以合起來用，如 cgi，表示不分大小寫，整行替換，替換前要詢問是否替換。

