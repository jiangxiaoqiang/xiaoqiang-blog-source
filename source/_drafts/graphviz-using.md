---
title: Graphviz使用
tags:
- graphviz
---

#### 安装

```Bash
# Fedora下安装
dnf install -y graphviz
#Ubuntu下安装
sudo apt install -y graphviz
```

<!-- more -->

生成文件：

```Bash
dot -Tjpg -Gdpi=1024 maven-lifecycle.dot -o maven-lifecycle.jpg
```
