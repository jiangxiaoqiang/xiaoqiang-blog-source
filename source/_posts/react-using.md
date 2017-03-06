---
title: 初识React
date: 2016-12-23 20:49:10
tags:
- React
categories: Programming
---


React 起源于 Facebook 的内部项目，因为该公司对市场上所有 JavaScript MVC 框架，都不满意，就决定自己写一套，用来架设Instagram的网站。

<!-- more -->

React 的设计思想极其独特，属于革命性创新，性能出众，代码逻辑却非常简单。从最早的UI引擎变成了一整套前后端通吃的 Web App 解决方案。衍生的 React Native 项目，目标更是宏伟，希望用写 Web App 的方式去写 Native App。如果能够实现，整个互联网行业都会被颠覆，因为同一组人只需要写一次 UI ，就能同时运行在服务器、浏览器和手机。

#### Redux流程

Redux流程如下图所示：

{% asset_img react-redux-flow.jpg Redux流程%}

#### Immutable

> Shared mutable state is the root of all evil（共享的可变状态是万恶之源）-- Pete Hunt

目前流行的 Immutable 库有两个：immutable.js和seamless-immutable。Facebook 工程师 Lee Byron 花费 3 年时间打造，与 React 同期出现，但没有被默认放到 React 工具集里（React 提供了简化的 Helper）。它内部实现了一套完整的 Persistent Data Structure，还有很多易用的数据类型。像 `Collection`、`List`、`Map`、`Set`、`Record`、`Seq`。有非常全面的`map`、`filter`、`groupBy`、`reduce``find`函数式操作方法。同时 API 也尽量与 Object 或 Array 类似。Immutable的优点：

* Immutable 降低了 Mutable 带来的复杂度
* 节省内存 
* Undo/Redo，Copy/Paste，甚至时间旅行这些功能做起来小菜一碟
* 并发安全
* 函数式编程


#### Component与service关联

在connect中将组件与service关联：

```javascript
@connect(
    (state => state),
    dispatch => ({
        globalService: bindActionCreators(globalService, dispatch),
        xzcfService: bindActionCreators(xzcfService, dispatch), 
        redBlackService:bindActionCreators(redBlackService,dispatch),
        TYPES,
        dispatch
    })
)
```







http://repox.gtan.com:8078

