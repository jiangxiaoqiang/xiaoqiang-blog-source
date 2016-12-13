---
title: 数据库索引原理
date: 2016-12-13 20:02:51
tags:
- Database
- Index
categories: Programming
---

#### BTree索引

B-Tree有许多变种，其中最常见的是B+Tree，例如MySQL就普遍使用B+Tree实现其索引结构。

与B-Tree相比，B+Tree有以下不同点：

每个节点的指针上限为2d而不是2d+1。

内节点不存储data，只存储key；叶子节点不存储指针。

<!-- more -->

#### 哈希索引



#### 全文索引


参考资料：

[MySQL索引背后的数据结构及算法原理](http://blog.codinglabs.org/articles/theory-of-mysql-index.html)

[MySQL索引原理及慢查询优化](http://tech.meituan.com/mysql-index.html)

[你知道数据库索引的工作原理吗？](http://www.ituring.com.cn/article/986)
