---
title: ArrayList线程安全
date: 2016-12-17 22:15:04
tags:
- ArrayList
- thread-safe
categories: Programming
---

1. Using Collections.synchronizedList() method
2. Using thread-safe variant of ArrayList: CopyOnWriteArrayList

<!-- more -->

#### CopyOnWriteArrayList

CopyOnWriteArrayList是java.util.concurrent包中的一个List的实现类。CopyOnWrite的意思是在写时拷贝，也就是如果需要对CopyOnWriteArrayList的内容进行改变，首先会拷贝一份新的List并且在新的List上进行修改，最后将原List的引用指向新的List。使用CopyOnWriteArrayList可以线程安全地遍历，因为如果另外一个线程在遍历的时候修改List的话，实际上会拷贝出一个新的List上修改，而不影响当前正在被遍历的List。


[How do I make my ArrayList Thread-Safe? Another approach to problem in Java?](http://stackoverflow.com/questions/2444005/how-do-i-make-my-arraylist-thread-safe-another-approach-to-problem-in-java)
