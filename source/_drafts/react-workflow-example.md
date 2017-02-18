---
title: Redux处理流程
tags:
- React
categories: Programming
---

所有实体数据存放在store中，注意全局只有一个store。关于store tree的开销担忧：state tree就是一个object，里面的reference了其他object。JS里的object是传址pass/store，也就是一个整数形态的pointer而已。redux的流程:store保存整体状态，通过调用store.dispatch一个action，来调用对应action的reducer，最终redux会根据action来更新state(应用的状态，而非react组件的state)。

<!-- more -->

#### 流程

项目的入口文件是index.js，在此文件中定义了整个项目的结构：

```javascript
ReactDOM.render(<Provider store={store}>{routes}</Provider>, dest);
```

`ReactDOM.render` 裡面第一個參數是放你要呈現的 JSX 表達式，而第二個則是你要插入的地方。`react-dom`包提供了DOM操作的具体方法，如：组件渲染、节点找查等。你可以在程序的最顶层使用它，除了必要的DOM操作，大多数组件不需要使用这个模块。整个项目只有一个ReactDOM.render方法。如果在服务端渲染，可以使用ReactDOMServer类库。routes中定义了整个项目所有的模块，模块或平级，或嵌套组成了项目前端的页面。所以使用react非常重要的应该是考虑如何安排组件。

**View --> ActionCreator --> Store(middleware,reducer,state)Loop --> View(Provider,connect)**
|                                                                                                                                                             |
|                                                                                                                                                             |
<--------------------------------------------------------------------------------------------------------------------------------

通过connect,React-redux应用中，store中维护的state就是我们的应用state，一个React组件作为View层，做两件事：render和响应用户操作。于是connect就是将store中的必要数据作为props传递给React组件来render，并包装action creator用于在响应用户操作时dispatch一个action。

Redux的store可以视为一个可以保存状态的内存盘，而connect则赋予react组件随处修改store的能力。如果UI层非常简单，没有很多互动，Redux 就不是必须要用的，因为它会增加复杂性。Redux 的适用场景是多交互、多数据源。

#### store

在store中定义实体对象，可以把它看成一个容器，整个应用只能有一个store。

#### route

在路由配置中通过connect将定义的实体对象store与组件相连接。

```javascript
//定义路由
const jointConferenceRoute = (
    <Route path="jointConference" component={JointConferenceRoute}>        
        <Route path="suggestion" component={Suggestion}/>
    </Route>
);

//定义connect
@connect(
    ({maintype, infotype, creditDocument, creditCount, creditForm, sign, org, dfbm, global, dashboard, article, suggestion}) => ({       
        suggestion,       
        article
    }),
    dispatch => ({
        TYPES,   
        articleService: bindActionCreators(articleService, dispatch),
        suggestionService: bindActionCreators(suggestionService, dispatch),
        dispatch
    })
)
```



#### 传递给子组件

将store存储的数据实体由父组件传递给子组件SuggestionForm。

```javascript
export default class Suggestion extends Component {

    constructor(props) {
        super(props);
    }

    render() {
        const breadcrumbItems = [{
            name: '意见建议'
        }];
        return (
            <div>
                <CustomBreadcrumb global={this.props.global}
                                  globalService={this.props.globalService}
                                  location={this.props.location}
                                  items={breadcrumbItems}/>
                <div className="suggestion-content">
                    <div className="suggestion-title"><span>意见建议</span></div>
                    <div className="suggestion-form">
                        <SuggestionForm {...this.props}/>
                    </div>
                </div>
            </div>
        )
    }
}
```

#### compenents

在compenets层接收到界面表单的提交，调用models层的service类。

```javascript
handleSubmit(e) {
        e.preventDefault();
        this.props.form.validateFieldsAndScroll((err, values) => {
            if (!!err) {
                console.log('Errors in form!!!');
                return;
            }           
            this.props.suggestionService.suggestionSave(values);
            console.log('Submit!!!');
            console.log('xxxxxxx', values);
        });
    }
```

从表单中获取的值已经存档在values中。state 和 props 主要的区别在于 **props** 是不可变的，而 state 可以根据与用户交互来改变。这就是为什么有些容器组件需要定义 state 来更新和修改数据。 子组件只能通过 props 来传递数据。

#### models

将界面的数据提交到后台处理：

```javascript
export function suggestionSave(data) {
    return dispatch =>
        requestJSON(
            dispatch,
            {method: 'POST', url: '/pubapi/advice/create', data},
            {type: suggestionTYPE.SUGGESTION_SAVE_SUCCESS, message: '保存成功'},
            {type: suggestionTYPE.SUGGESTION_SAVE_ERROR, message: '保存失败'});
}
```

后台处理完毕后，执行view中的render方法。



