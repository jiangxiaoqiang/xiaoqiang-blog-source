---
title: 大数据入门
tags:
  - GFS
  - BigTable
  - MapReduce
categories: Programming
date: 2017-01-30 18:32:47
---



#### 五篇论文(5 Paper)

要找到这5篇Paper，只需要在Google搜索引擎里键入`关键字+Paper filetype:pdf`即可。例如，下载Map Reduce的Paper，键入`Map Reduce paper pdf`，第一条结果即是。

* Map Reduce 
* Big Table
* GFS
* Spanner
* Paxos

<!-- more -->

Google 采用的操作系统是Linux，存储使用自己研发的GFS，非关系型数据使用BigTable(2006年数据TB级别，目前应该是PB级别)，关系型数据使用Spanner(是对原来的广告系统后台DB的重写)。数据并行处理使用Map Reduce，稍大集群节点数在2000+。

