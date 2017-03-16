---
title: Json使用总结
date: 2017-03-10 11:41:39
tags:
- Json
categories: Programming
---

Json具有数据紧凑的特点，非常适合网络传输，特别是数据频繁交互时，可以节省网络带宽。

<!-- more -->

#### 格式化

由于编写接口时，经常会使用curl命令测试接口返回的Json数据。而普通返回的Json是没有格式化的，非常不便于阅读。而Python引入的json tool和jq可以很好的帮助格式化终端里的Json字符文本。

##### json tool

json.tool在Python 2.6中引入，用于格式化Json数据流。

```shell
curl -H "APPID:hlb1152" -H "TIMESTAMP:2016-12-19 16:58:02" -H "ECHOSTR:sdsaasf" -H "TOKEN:14d45648c62a761222d" http://localhost:28080/api/ycml?id=1 |python -m json.tool
```

##### jq

使用 Json tool有一个问题就是中文编码问题，Python标准会将中文自动转码为Unicode在计算机中的表示方式。但是人是很难阅读的，在涉及中文的Json格式化输出时，可以使用Json另一个格式化输出工具jq。jq is a tool for processing JSON inputs, applying the given filter to its JSON text inputs and producing the	filter's results as JSON on standard output.

```shell
curl -H "APPID:hlb11" -H "TIMESTAMP:2016-12-19 16:58:02" -H "ECHOSTR:sdsaasf" -H "TOKEN:14d45648c62a746ae9d" http://127.0.0.1:28080/api/ycml/detail?id=463368|jq '.'
```

此时可以输出中文，而且还带有高亮语法哟。jq也可以对Json以key进行查询，在字段比较多时，怎么知道某一个字段是否包含在返回中呢？用眼睛，未免也太累了，字段少可以应付，如果字段超过50个，就比较头疼了。使用如下命令：

```shell
# 查看Json中是否有orgname
json content | jq .orgname
# 查看json中是否有orgname(从文件读取)
jq .orgname example.json
# 链式调用
jq .orgname[0].school example.json
```

##### Jsonview
