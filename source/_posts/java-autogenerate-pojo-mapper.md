---
title: Java自动生成POJO和Mapper
date: 2017-04-03 16:05:33
tags:
- Java
- POJO
categories: Tool
---

平时写接口代码不外乎CRUD，大部分工作都是重复无意义的。所以可以使用一些方式将重复的工作自动化，所以对于一般的编写POJO和一些通用的CRUD的Mapper就可以考虑使用工具来完成了。

<!-- more -->

#### MyBatis Generator自动生成

Mybatis Generator用于生成Mybatis的Model、Mapper、Dao持久层代码。虽然现在Mybatis Generator未提供Gradle的插件，不过Gradle可以调用Ant任务，所以Gradle也能使用Mybatis Generator。首先添加依赖：

```groovy
dependencies {
    mybatisGenerator 'org.mybatis.generator:mybatis-generator-core:1.3.2'    
    mybatisGenerator 'tk.mybatis:mapper:3.3.2'
}
```







#### Intellij Idea自动生成

