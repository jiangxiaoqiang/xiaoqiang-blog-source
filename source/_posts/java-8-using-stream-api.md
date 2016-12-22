---
title: Java 8 使用Stream API
tags:
  - Java 8
  - Stream API
categories: Programming
date: 2016-10-14 15:25:32
---


#### 遍历集合中的列

Stream是Java8中，操作集合的一个重要特性。这里要遍历集合中对象的某一个属性，并取出来用“，”拼接成字符串，传统的写法是写循环遍历每个对象，从中取出某一个属性，进行拼接操作。在Java 8里可以使用Stream API只需要一行代码，非常简洁。

<!-- more -->

```Java
List<WorkDayDataInfo> workDayDataInfo = workDayInfos.get(currentWorkDay).getDatas();
String assignmentIdStream = assignments.stream()
                        .map(p -> p.getId())
                        .collect(Collectors.joining(","));
```

对于基本数据类型的拼接：

```Java
List<Integer> numbers = Arrays.asList( 4, 8, 15, 16, 23, 42 );
return numbers.stream().map( n -> n.toString() ).collect( Collectors.joining( "," ) );
```

#### 去List除重复数据

去除List中对象的重复数据。

```Java
List<ClientVehicleInfo> distinctVehicles = clientVehicleInfos.stream().distinct().collect(Collectors.toList());
```

对于Stream中包含的元素进行去重操作（去重逻辑依赖元素的equals方法），新生成的Stream中没有重复的元素。（根据.equals行为排除所有重复的元素。）

#### 去除String数组重复数据

其中deviceNumbers为String类型的数组。

```Java
deviceNumbers= new HashSet<>(Arrays.asList(deviceNumbers)).toArray(new String[0]);
```

#### 过滤器(Filter)

从List中过滤出指定条件的数据：

```Java
List<CreditDocument> xzxkList = creditDocuments.stream().filter(a -> a.getInfoType() == 1).collect(Collectors.toList());
```
