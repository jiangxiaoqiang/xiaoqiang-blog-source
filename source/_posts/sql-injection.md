---
title: SQL注入(SQL Injection)
date: 2017-01-06 12:41:23
tags:
- SQL Injection
categories: Security
---

#### MyBatis预防SQL注入

在MyBatis中，”${xxx}”这样格式的参数会直接参与sql编译，从而不能避免注入攻击。但涉及到动态表名和列名时，只能使用“${xxx}”这样的参数格式，所以，这样的参数需要我们在代码中手工进行处理来防止注入。所以尽量用#{}这种方式传参数，如果用到了${}方式要手动过滤sql注入。

<!-- more -->

```Java
str.replaceAll(".*([';]+|(--)+).*","")
```
