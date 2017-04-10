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
    ({dashboard, article}) => ({
        dashboard,
        article
    }),
    dispatch => ({
        TYPES,
        dashboardService: bindActionCreators(dashboardService, dispatch),
        articleService: bindActionCreators(articleService, dispatch),
        dispatch
    })
)
```
connect将React组件与Redux的store连接起来。如上代码所示，dashboard与article为store，dashboardService为React的组件。Redux 本身提供了 bindActionCreators 函数，来将 action 包装成直接可被调用的函数。每个 action.type 的 case (A/B/C)，都有一个专门对应的数据处理函数 (handleA/handleB/handleC)，处理完之后返回新的 state 即可。原本的 reducer(state, action) 模式，我们用 createStore(reducer, initialState) 转换成 store.dispatch(action)，现在发现还不够，怎么做？再封装一层呗，这就是函数式思想的体现，通过反复组合，将多参数模式，转化为单参数模式。

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

`this.props` 表示那些一旦定义，就不再改变的特性，而 `this.state` 是会随着用户互动而产生变化的特性。`this.props` 对象的属性与组件的属性一一对应，但是有一个例外，就是 `this.props.children` 属性。它表示组件的所有子节点。利用props将数据从父组件传递给子组件。故我们可以利用props，让父组件给子组件通信。故父组件向子组件通信还是很容易实现的。父组件怎么向孙子组件通信呢？可以利用props进行层层传递，使用ES6的...运算符可以用很简洁的方式把props传递给孙子组件。那么子组件怎么向父组件通信呢？其实仍然可以利用props。父组件利用props传递方法给子组件，子组件回调这个方法的同时，将数据传递进去，使得父组件的相关方法得到回调，这个时候就可以把数据从子组件传递给父组件了。父组件将方法传递给子组件：

```javascript
class UnitedListQuery extends Component {
    /*父组件中定义returnTotal函数，并接受子组建传递的total参数值*/
    returnTotal = (total) => {
        this.count += total;
        return this.count;
    };

    renderTablePanels = (signUser, paramsList, creditFormFieldList, creditFormTableList) => {
        const tableNames = stateQuery.blackTableNames.concat(stateQuery.redTableNames);
        return tableNames.map(tableName => {                        

            return <UnitedTablePanel signUser={signUser}                                     
                                     returnTotal={this.returnTotal}//将函数传递给子组件
                                     key={tableName}/>;
        });
    };

    handleDownload = () => {
        let param = this.state.query.param;
        let redTableNames = this.state.query.redTableNames;
        let blackTableNames = this.state.query.blackTableNames;
        let tableName = redTableNames.concat(blackTableNames).join(',');
        /*父组件根据不同的数量作不同的业务逻辑处理*/
        if (this.state.query.param && this.count < 5000) {
            window.open(`/pubapi/downloadUser?param=${param}&tableName=${tableName}&isPl=0`);
        } else if (this.count >= 5000) {
            notification.warn({message: '下载数量不能超过5000条'});
        }
    };
}
```

如下是子组建通过调用父组件传递的函数，将参数值传递给父组件，从而实现了子组件向父组件通信：

```javascript
class UnitedTablePanel extends Component {
    tableDataSource = () => {
        const creditDocumentPage = this.state.creditDocumentPage;        
        /*
        * 子组件调用父组件的方法，并将参数值传递给父组件
        */
        this.props.returnTotal(creditDocumentPage.totalElements);
        return creditDocumentPage.content.map((doc, idx) => {
            return {
                ...doc,
                _xdrNo: doc.xdrShxym || doc.xdrSfz,
                key: idx
            }
        })
    };
}
```

参考资料：

[React 入门实例教程](http://www.ruanyifeng.com/blog/2015/03/react.html)

[Props](https://facebook.github.io/react-native/docs/props.html)

