---
title: grep
tags:
- linux
- grep
categories: Programming
---

#### 多个匹配模式

```Bash
 tail -f catalina.out | grep -e "苏E22222" -e "服务器"
```

使用此命令可以过滤catalina.out文件中包含`苏E22222`**且**包含`服务器`的内容。






