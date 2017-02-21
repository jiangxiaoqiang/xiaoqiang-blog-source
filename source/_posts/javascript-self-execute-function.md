---
title: JavaScript立即执行函数表达式
date: 2017-02-21 10:38:01
tags:
- JavaScript
categories: Programming
---

经常会看见如下的函数表达式:

```javascript
(function(){
	console.log("hello");
})();
```

或者

<!-- more -->

```shell
(function(){
	console.log("hello");
}());
```

对此种用法的称呼不尽相同，其中包括「自执行匿名函数」（self-executing anonymous function），「立即执行函数表达式」（Immediately-Invoked Function Expression，以下简称IIFE）.函数表达式：



> /* 函数表达式中的函数可以为匿名函数，也可以有函数名，但是该函数实际上不能直接使用，只能通过表达式左边的变量 a 来调用。*/

> var a = function(){

> ​	alert('Function expression');

> }

> var b = new a();

函数声明：

> // 函数声明时必须有函数名

> function a(){

>    alert('Function declaration');

> }

> a();



#### 为什么要使用立即执行函数表达式

* **模拟块作用域** 在同时引用多个库的情况下,容易造成变量污染.
* **解决闭包冲突**（closure）是JavaScript的一个语言特性，简单来说就是在函数内部所定义的函数可以持有外层函数的执行环境.使用立即执行函数表达式可以解决闭包冲突.
* **模拟单例**

