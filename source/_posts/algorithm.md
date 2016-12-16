---
title: 算法
date: 2016-12-14 20:05:29
tags:
- algorithm
categories: Programming
---


#### 汉诺塔算法

```Java
static void hannoi(int n, String from, String buffer, String to) {
    if (n == 1) {
        System.out.println("Move disk " + n + " from " + from + " to " + to);
    } else {
        hannoi(n - 1, from, to, buffer);
        System.out.println("Move disk " + n + " from " + from + " to " + to);
        hannoi(n - 1, buffer, from, to);
    }
}

public static void main(String[] args) {
    hannoi(3, "A", "B", "C");
}
```
