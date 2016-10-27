---
title: hashmap和hashset
tags:
- hashmap
- hashset
categories: Programming
---

HashMap 查询时间的复杂度是怎样的？是O(n) = O(k * n)。如果 hashCode() 方法能向下面讨论的那样把数据分散到桶（bucket）中，那么平均是O(1)。HashMap 内部是如何存储数据的？HashMap 使用后台数组（backing array）作为桶，并使用链表（linked list）存储键／值对。使用键（key）和值（value）将一个对象放入 map 中时，会隐式调用 hashCode() 方法，返回哈希值（hash code value），比如 123。两个不同的键能够返回一样的哈希值。良好的哈希算法（hashing algorithm）能够将数值分散开。一旦 HashMap 达到容量的 75%，也就是哈希因子(hash factor)默认值 0.75，后台数组（backing array）的容量就会加倍，发生重散列（rehashing）为新的 20 的容量重新分配桶。不同的对象调用 hashCode() 方法应该返回不同的值。如果不同的对象返回相同的值，会导致更多的键／值对存储在同一个 bucket 中。这会降低 HashMap 和 HashSet 的性能。
