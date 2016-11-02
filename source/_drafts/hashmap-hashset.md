---
title: HashMap和HashSet
tags:
- hashmap
- hashset
categories: Programming
---

#### HashMap

HashMap 查询时间的复杂度是怎样的？是O(n) = O(k * n)。如果 hashCode() 方法能向下面讨论的那样把数据分散到桶(bucket)中，那么平均是O(1)。HashMap 内部是如何存储数据的？HashMap 使用后台数组(backing array)作为桶，并使用链表(linked list)存储键／值对。使用键（key）和值(value)将一个对象放入 map 中时，会隐式调用 hashCode() 方法，返回哈希值(hash code value)，比如 123。两个不同的键能够返回一样的哈希值。良好的哈希算法(hashing algorithm)能够将数值分散开。一旦HashMap达到容量的 75%，也就是哈希因子(hash factor)默认值 0.75，后台数组(backing array)的容量就会加倍，发生重散列(rehashing)为新的 20 的容量重新分配桶。不同的对象调用 hashCode()方法应该返回不同的值。如果不同的对象返回相同的值，会导致更多的键／值对存储在同一个 bucket 中。这会降低 HashMap 和 HashSet 的性能。我们对一个键值对的查询，是分为四步的。

* 先根据key值计算出hash值以及h值（h值是java实现中处理得到的更优的index索引值）
* 查找table数组中的h位置，得到相应的键值对链表
* 根据key值，遍历键值对链表，找到相应的键值对
* 从键值对中取出value值

只有以上四步都能在O(1)时间内完成，HashMap才能拥有O(1)的时间复杂度。易知，步骤1（计算）、步骤2（数组的查找）和步骤4（从键值对中取value值）都可以在O(1)时间内完成。那么，步骤3中链表的长度决定了整个HashMap容器的查找效率，这也是HashMap容器设计的关键。必须采用优秀的hash算法以减少“冲突”，使得链表的长度尽可能短，理想状态下链表长度都为1。

#### HashSet

HashSet实现了Set接口，它不允许集合中有重复的值，当我们提到HashSet时，第一件事情就是在将对象存储在HashSet之前，要先确保对象重写equals()和hashCode()方法，这样才能比较对象的值是否相等，以确保set中没有储存相等的对象。如果我们没有重写这两个方法，将会使用这个方法的默认实现。

`public boolean add(Object o)`方法用来在Set中添加元素，当元素值重复时则会立即返回false，如果成功添加的话会返回true。
