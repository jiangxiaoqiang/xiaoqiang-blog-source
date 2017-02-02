---
title: Gradle搭建项目
date: 2017-02-01 19:28:41
tags:
---

#### 创建一个Spring-Boot项目

##### 初始化

```Bash
gradle init
```

##### 增加配置

#### 多项目构建




* 一个多项目构建必须在根项目的根目录下包含settings.gradle文件，因为它指明了那些包含在多项目构建中的项目。
* 如果需要在多项目构建的所有项目中加入公用的配置或行为，我们可以将这项配置加入到根项目的build.gradle文件中(使用allprojects)。
* 如果需要在根项目的子项目中加入公用的配置或行为，我们可以将这项配置加入到根项目的build.gradle文件中(使用subprojects)。