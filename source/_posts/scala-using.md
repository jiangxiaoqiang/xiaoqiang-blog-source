---
title: Scala使用总结
date: 2017-03-09 17:05:11
tags:
- Scala
categories: Programming
---



#### 常见问题

#### skipping Scala files without a Scala SDK in module(s) main

在编译与Scala结合的项目时，出现如下提示。

<!-- more -->

```
Warning:scala: skipping Scala files without a Scala SDK in module(s) main
```

采取的解决方法为，下载Scala SDK进行安装，此处下载的是2.12.1，安装到路径`/opt/local/tools/`路径下。在Intellij Idea中File>Project Structure>Global Libraries>，添加Scala SDK，导入模块，如下图所示。

{% asset_img add-modules.png 添加Scala项目模块%}



