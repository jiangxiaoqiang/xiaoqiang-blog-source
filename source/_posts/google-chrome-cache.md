---
title: Google Chrome缓存
date: 2017-03-28 20:30:44
tags:
- Cache
categories: Tool
---

对Google Chrome缓存的一些总结。

#### 文件缓存

<!-- more -->

服务器上更新了Excel文件，用Google Chrome浏览器下载却还是旧的Excel。印象里浏览器大多缓存js、css等文件，其实下载的Excel也同样被Google浏览器缓存了。所以每次都不是真正的请求服务器，而是直接返回的本地的文件。由于此处的文件名称是`模板.xlsx`，在Chrome地址栏里直接输入：

```shell
chrome://cache/
```

里面列出了缓存的内容，此处的缓存内容如下：

```shell
http://creditsystem.test/assets/templatefile/%E8%A1%8C%E6%94%BF%E5%A4%84%E7%BD%9A%E6%A8%A1%E6%9D%BF.xlsx
```

这就是浏览器缓存的文件。在Linux下，缓存的内容一般保存在如下目录：

```shell
/home/{user}/.cache/google-chrome/Default/Cache
```

清空此目录即可清除缓存。


