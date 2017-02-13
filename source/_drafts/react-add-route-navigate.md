---
title: Redux添加路由和导航
tags:
- Redux
categories: Programming
---

添加导航文件存放位置相关文件夹/src/layouts，加入导航文件Nav.js：

<!-- more -->

```javascript
import React, {Component} from 'react';
import {Link} from 'react-router';

class Nav extends Component {
    render() {
        return (
            <nav>
                <Link to="/">Home</Link>
            </nav>
        );
    }
}

export default Nav;
```

加入Frame.js文件：

```javascript
import React, {Component} from 'react';
import Nav from './Nav';

class Frame extends Component {
    render() {
        return (
            <div>
                <section>
                    <Nav />
                </section>
                <section>
                    {this.props.children}
                </section>
            </div>
        );
    }
}

export default Frame;
```

在src目录下新建目录routes，添加index.js文件：

```javascript
import React from 'react';
import {Router, Route, IndexRoute, hashHistory} from 'react-router';

import Frame from '../layouts/Frame';
import Home from '../views/Home';

const routes = (
    <Router history={hashHistory}>
        <route path="/" component={Frame}>
            <IndexRoute component={Home}></IndexRoute>
        </route>
    </Router>
);

export default routes;
```

在导航配置里，引入了layouts目录下的Frame组件，添加了嵌套式路由声明。/路由对应的为Frame，当访问/路由时，将渲染Frame组件。但是渲染Frame渲染时，没有渲染Home组件，所以嵌套一个IndexRoute组件。添加后，当访问/时，实际渲染的组件是Frame和Home。在这里，Home组件就将作为Frame组件的子组件，当在Frame的render方法中渲染this.props.children时，渲染的的其实是Home组件。文件添加后的目录结构为：

{%  asset_img add-route-content-structure.png  添加路由后的目录结构%}



#### reducer

Reducer，这个名字来源于数组的一个函数 — [reduce](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global)，它们俩比较相似的地方在于：接收一个旧的prevState，返回一个新的nextState**。**Reducer是一个纯函数，用来修改Store数据的。Redux通过一个个reducer完成了对整个数据源（object tree）的拆解访问和修改。

