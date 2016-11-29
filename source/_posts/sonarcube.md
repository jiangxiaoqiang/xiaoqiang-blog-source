---
title: Sonarcube代码优化
tags:
  - Sonarcube
categories: Programming
date: 2016-11-28 15:51:23
---



#### Generic exceptions should never be thrown


Using such generic exceptions as Error, RuntimeException, Throwable, and Exception prevents calling methods from handling true, system-generated exceptions differently than application-generated errors.

<!-- more -->

不应该写成如下方式：

```Java
public void foo(String bar) throws Throwable {  // Noncompliant
  throw new RuntimeException("My Message");     // Noncompliant
}
```

应该写成如下方式：

```Java
public void foo(String bar) {
  throw new MyOwnRuntimeException("My Message");
}
```

#### Instance methods should not write to "static" fields

实例化方法不写静态字段。

优化前：


```Java
@Override
public void setApplicationContext(ApplicationContext context) throws BeansException {
     SpringApplicationContextHolder.context = context;
}
```

优化后：

```Java
public static void setApplicationContextImpl(ApplicationContext context) {
    SpringApplicationContextHolder.context = context;
}

@Override
public void setApplicationContext(ApplicationContext context) throws BeansException {
    setApplicationContextImpl(context);
}
```

#### Neither "Math.abs" nor negation should be used on numbers that could be "MIN_VALUE"

Math.abs(Integer.MIN_VALUE)的值还是其本身。通过查阅Java的API文档，我们看到对abs(int a)运算，“如果参数等于 Integer.MIN_VALUE 的值（即能够表示的最小负 int 值），那么结果与该值相同且为负。

优化前：

```Java
int newlineId = Math.abs(randomPointId.replaceAll("-", "").hashCode());
```

优化后：

```Java
String hashedSourceId = sourceId.replaceAll("-", "");
if (hashedSourceId.hashCode() != Integer.MIN_VALUE) {
    Integer hashedId = Math.abs(hashedSourceId.hashCode());
    hashedIds.add(hashedId.toString());
} else {
    hashedIds.add(String.valueOf(Integer.MAX_VALUE));
}
```
