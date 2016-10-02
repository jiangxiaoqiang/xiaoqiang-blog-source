---
title: Java中String非空判断
tags: java
date: 2016-09-19 18:18:13
---


如果使用的Java运行时版本在Java SE 1.6之前，可以这样判断字符串非空：

```Java
if(str != null && str.length() != 0)
```

如果使用的Java运行时版本是Java SE 1.6及之后版本，可以这样判断字符串非空：

```Java
if(str != null && !str.isEmpty())
```

使用org.apache.commons.lang.StringUtils[Apache commons-lang](http://commons.apache.org/proper/commons-lang/)来完成：

```Java
import org.apache.commons.lang.StringUtils;

if (StringUtils.isNotBlank(str)) {

}
```

如下方式也可：

```Java
import com.google.common.base.Strings;

if (!Strings.isNullOrEmpty(myString)) {
       return myString;
}
```

源自：
* [Java, check whether a string is not null and not empty?]

[Java, check whether a string is not null and not empty?]:http://stackoverflow.com/questions/3598770/java-check-whether-a-string-is-not-null-and-not-empty








