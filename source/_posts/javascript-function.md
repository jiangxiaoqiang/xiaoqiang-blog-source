---
title: Javascript使用总结
date: 2017-03-01 13:34:36
tags:
- Javascript
- Front-end
categories: Front-end
---

#### split

有时需要根据特定的字符分割字符串，比如根据换行符号分割查询条件。如果条件严格以单个换行符相隔，可以使用如下语句进行分割。

<!-- more -->

```javascript
let paramList = values.param.toString().split("\n");
```

不过大多数情况，条件之间并不能严格保证以单个换行符相隔，往往是一个或者一个以上换行符。那么可以使用正则表达式：

```javascript
// 一个或者一个以上换行符
let paramList = values.param.toString().split(/\n+/);
//一个或者一个以上空格
let paramList = values.param.toString().split(/\s+/);
```

在Javascript中换行符只有`\n`,没有`\n`与`\n\r`的区分。

* In Javascript, new lines are represented by a single "\n" character.
* Textarea values might have the character combos "\n\r" in the text box, but once they are pulled into Javascript, "\n\r" becomes JUST "\n".
* When replacing out new line characters, treat them as you would any other character. They are not special, they just have special notation.

#### 三点运算符



