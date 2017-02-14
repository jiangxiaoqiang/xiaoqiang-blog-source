---
title: Java 8 Optional
date: 2017-02-04 11:52:33
tags:
- Java8
categories: Programming
---


#### 非空判断

Java8新增了Optional类。在做空检查时，传统的方式如下：

<!-- more -->

```Java
SummaryXzxk summaryXzxk = summaryXzxkService.findById(id);
if(summaryXzxk != null){
    apiResult = ApiResult.success(summaryXzxk.get());
}
```

使用Optional后，可以改进成如下方式：

```Java
Optional<SummaryXzxk> summaryXzxk = summaryXzxkService.findById(id);
if(summaryXzxk.isPresent()){
    apiResult = ApiResult.success(summaryXzxk.get());
}
```

可以更进一步改进成如下方式：

```Java
Optional<SummaryXzxk> summaryXzxk = summaryXzxkService.findById(id);
apiResult = ApiResult.success(summaryXzxk.orElse(null));
```


