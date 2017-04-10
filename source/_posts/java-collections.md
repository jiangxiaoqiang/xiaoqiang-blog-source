---
title: java-collections
date: 2017-04-01 15:58:14
tags:
categories: Programming
---

#### collection转List

```java
Collection platformCollections = platformStatisticsService.findList();
PlatformStatistics[] platformStatisticses = (PlatformStatistics[]) platformCollections.toArray(new PlatformStatistics[platformCollections.size()]);
```
