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

#### 非空默认值

有时在值为null时，会给一个默认值，有如下方式。

```Java
String alarmType = vehicleMessageHandler.parseAlarm(kafkaRecievedLocationMessageBody.getAlarm());
//使用三元运算符
positional.setAlarm(StringUtils.isBlank(alarmType) ? "0" : alarmType);
//com.google.common.base
Objects.firstNonNull(alarmType, "0");
//java.util
Optional.ofNullable(alarmType).orElse("0");
```


源自：
* [Java, check whether a string is not null and not empty?]

[Java, check whether a string is not null and not empty?]:http://stackoverflow.com/questions/3598770/java-check-whether-a-string-is-not-null-and-not-empty

* [How to convert a possible null-value to a default value using Guava?](http://stackoverflow.com/questions/8039504/how-to-convert-a-possible-null-value-to-a-default-value-using-guava)







