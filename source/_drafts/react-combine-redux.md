---
title: react-combine-redux
tags:
---



#### 简介

Redux优化和扩展了Flux，在2015年时，Facebook大量采用了Flux技术，用以解决软件的结构问题。Flux最大的特点就是数据的单向流动：

<!-- more -->

> 1. 用户访问 View
> 2. View 发出用户的 Action
> 3. Dispatcher 收到 Action，要求 Store 进行相应的更新
> 4. Store 更新后，发出一个"change"事件
> 5. View 收到"change"事件后，更新页面

单向流动可以保证流程清晰，在开发大型应用时非常重要。但是发现Flux有一些不足的地方:代码编写更加模板化，移植现有代码比较困难，单元测试难以进行。Redux只有唯一的state树，不管项目变的有多复杂，也仅仅只需要管理一个State树。可能你会有疑问，一个state树就够用了？这个state树该有多大？而Redux中的Reducer机制可以解决这个问题。

#### 安装

安装Redux必要的依赖：

```shell
sudo npm install --save react react-dom redux react-router react-redux react-router-redux whatwg-fetch
```

whatwg-fetch是Ajax请求兼容库。

#### Redux调试

安装Redux调试工具Redux Devtools：

```shell
sudo npm install --save-dev redux-devtools redux-devtools-log-monitor redux-devtools-dock-monitor
```

可以使用新的Google Chrome扩展插件，具体可以参考这里：[New React Developer Tools](https://facebook.github.io/react/blog/2015/09/02/new-react-developer-tools.html)。





