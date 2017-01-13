---
title: ID设计
date: 2017-01-10 10:35:32
tags:
- ID
categories: Programming
---


#### UUID(GUID)

* 全球唯一
* 存储大
* 索引慢
* 不美观

<!-- more -->

#### ObjectId

ObjectId是MongoDB的一种ID生成机制。

* 存储大
* 索引慢
* 不美观
* 特定集群内唯一
* 可以逆向推算出数据对应的(插入时间，插入的机器)
