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

#### constructor

the constructor of a React component is executed once the first time the component is mounted, or instantiated. It is never called again in subsequent renders.Typically the constructor is used to set-up a component's internal state, for example:

```javascript
class BatchQuery extends Component {
    constructor(props) {
        super(props);
        this.state = {
            query: {blackTableNames: [], redTableNames: []}
        };
    }
}
```

#### React生命周期

组件的生命周期分成三个状态：

* 装载(Mounting)：组件被插入到DOM中

* 更新(Updating)：正在被重新渲染

* 卸载(Unmounting)：组件从DOM中移除

React 为每个状态都提供了两种处理函数，will 函数在进入状态之前调用，did 函数在进入状态之后调用，三种状态共计五种处理函数。

1. componentWillMount()---render之前最后一次修改状态的机会
2. componentDidMount()---成功render并渲染完成真实DOM之后触发，可以修改DOM
3. componentWillUpdate(object nextProps, object nextState)
4. componentDidUpdate(object prevProps, object prevState)
5. componentWillUnmount()—组件卸载的时候执行，一般可用于清除数据

此外，React 还提供两种特殊状态的处理函数。

componentWillReceiveProps(object nextProps)：已加载组件收到新的参数时调用

shouldComponentUpdate(object nextProps, object nextState)：组件判断是否重新渲染时调用

 注意：render只能访问this.props和this.state，只有一个顶层组件，不允许修改状态和DOM输出

#### props

许多组件创建的时候可以自定义许多参数，这些参数就叫做属性(props)。

> Most components can be customized when they are created, with different parameters. These creation parameters are called `props`.

`this.props` 表示那些一旦定义，就不再改变的特性，而 `this.state` 是会随着用户互动而产生变化的特性。`this.props` 对象的属性与组件的属性一一对应，但是有一个例外，就是 `this.props.children` 属性。它表示组件的所有子节点。

参考资料：

[React 入门实例教程](http://www.ruanyifeng.com/blog/2015/03/react.html)

[Props](https://facebook.github.io/react-native/docs/props.html)