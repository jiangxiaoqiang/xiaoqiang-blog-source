---
title: Java中的时间
date: 2016-12-28 15:46:19
tags:
- Date
- Java
categories: Programming
---

如果单纯以Date类型定义时间字段，定义时间的格式：

```Java
@ApiModelProperty(value = "数据更新时间戳")
@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
private LocalDateTime sjc;
```

<!-- more -->

那么返回的时间值如下：

```
"jdrq":"2016-06-26T00:23:15.000+0000"
```

如果想返回类似`2016-06-26 00:00:00`格式的时间，那么需要定义日期类型为LocalDateTime。返回的时间里，日期和时间中始终有一个大写T，原来是LocalDateTime的toString方法在转化时添加了一个T字符：

```Java
//-----------------------------------------------------------------------
/**
 * Outputs this date-time as a {@code String}, such as {@code 2007-12-03T10:15:30}.
 * <p>
 * The output will be one of the following ISO-8601 formats:
 * <ul>
 * <li>{@code uuuu-MM-dd'T'HH:mm}</li>
 * <li>{@code uuuu-MM-dd'T'HH:mm:ss}</li>
 * <li>{@code uuuu-MM-dd'T'HH:mm:ss.SSS}</li>
 * <li>{@code uuuu-MM-dd'T'HH:mm:ss.SSSSSS}</li>
 * <li>{@code uuuu-MM-dd'T'HH:mm:ss.SSSSSSSSS}</li>
 * </ul>
 * The format used will be the shortest that outputs the full value of
 * the time where the omitted parts are implied to be zero.
 *
 * @return a string representation of this date-time, not null
 */
@Override
public String toString() {
    return date.toString() + 'T' + time.toString();
}
```
