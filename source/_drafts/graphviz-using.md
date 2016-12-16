---
title: graphviz-using
tags:
- graphviz
---

#### 安装

```Bash
dnf install -y graphviz
```

生成文件：

```Bash
dot -Tjpg -Gdpi=1024 maven-lifecycle.dot -o maven-lifecycle.jpg
```
