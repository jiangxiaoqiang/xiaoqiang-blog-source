---
title: java-rest-summarize
tags:
---

#### HTTP信息转换

@ResponseBody 注解能够对客户端发过来的对象进行自动转换。

```Java

```

实现自动转换，必须满足以下两个条件：

1. 请求的 Content-Type 头信息必须是 application/json；
2. Jackson Json 库必须包含在应用程序的类路径下。
