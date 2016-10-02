---
title: Phoenix常用操作
tags: Phoenix
date: 2016-09-23 16:57:30
---

#### 简介

Phoenix本意是凤凰的意思，[Apache Phoenix](http://phoenix.apache.org/)是构建在HBase之上的关系型数据库层，作为内嵌的客户端JDBC驱动用以对HBase中的数据进行低延迟访问。Apache Phoenix会将用户编写的sql查询编译为一系列的scan操作，最终产生通用的JDBC结果集返回给客户端。数据表的元数据存储在HBase的表中被会标记版本号，所以进行查询的时候会自动选择正确的schema。直接使用HBase的API，结合协处理器（coprocessor）和自定义的过滤器的话，小范围的查询在毫秒级响应，千万数据的话响应速度为秒级。

<!-- more -->

{% asset_img phoenix-position.jpg Phoenix的定位%}

#### 特性

Phoenix可以用SQL语句来查询Hbase，且只能查Hbase，别的类型比如查询文本文件等都不支持！如果要查文本文件等，可以使用Hive和Impala，Phoenix在Hbase上查询的性能较Hive和Impala具有优势。


#### 常用操作

登录。

```Bash
./sqlline.py localhost
```

查看HBase所有表。

```Bash
!tables
```
table schema为system的是系统表。

查看HBase中表名为test的所有列。

```Bash
!columns test
```

表名不用加引号。

查询表数据。

```SQL
select * from test;
select name from test;//查询指定列
select * from test where name = 'jiangxiaoqiang';//条件查询
```

删除表数据。

```SQL
delete from test where condition;//语法
delete from test where name is null;//例子
```
condition是过滤条件，注意结尾需要有分号，表示SQL语句已经结束，可以提交给引擎执行。

#### 函数(Function)

substr函数用于截取字符串。

```SQL
select substr(time,0,11) from test group by substr(time,0,11);
```

time为需要截取的字符串，从第0位开始截取11位长度。




