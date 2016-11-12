---
title: Java问答
tags:
- Java
categories: Programming
---

#### for-each与常规for循环的效率对比


使用for-each循环与常规的for循环相比，并不存在性能损失，即使对数组进行迭代也是如此。实际上，在有些场合下它还能带来微小的性能提升，因为它只计算一次数组索引的上限。

```Bash
for (Element e : elements) {
    doSomething(e);
}
```

for-each能够让代码更加清晰，并且减少了出错的机会。

