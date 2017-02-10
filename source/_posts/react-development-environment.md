---
title: React开发环境搭建(Webpack+Babel+React)
date: 2017-02-08 15:07:25
tags:
- React
- Webpack
- Bebel
categories: Front End
---

#### 必备组件

##### 安装Babel

Babel 是一个 JavaScript 编译器。使用它可以将ES6的语法转换为ES5的语法，以便在现在有的环境执行。在工程中安装Babel:

```shell
sudo npm install --save-dev babel-cli babel-core babel-polyfill babel-preset-es2015 babel-preset-react
```

babel-preset-es2015和babel-preset-react分别是ES6和React的插件集。babel通过polyfill来支持某些方法在低级别上浏览器不支持的问题。

##### 安装React

终端输入以下代码对react和react-dom进行安装：

```
sudo npm install react react-dom --save
```

Babel针对React的所有的预设插件：

```
sudo npm install babel-preset-react --save-dev
```

##### 安装Webpack Server

添加webpack-dev-server作为项目的依赖：

```shell
sudo npm install -D webpack-dev-server
```

-D参数代表Dependency的含义。执行命令后，会在package.json文件的devDependencies中添加相应的依赖。


#### 初始化项目

使用npm初始化项目：

```shell
npm init
```

初始化后，会在项目的根目录下生成package.json文件。

#### 新建JSX文件

接着新建`src/views`目录，新建JSX语法文件Home.js：

```javascript
import React, {Component} from 'react';

class Home extends Component {
    render() {
        return (
            <h1>Hellow World！</h1>
        );
    }
}

export default Home;
```

HTML 语言直接写在 JavaScript 语言之中，不加任何引号，这就是 [JSX 的语法](http://facebook.github.io/react/docs/displaying-data.html#jsx-syntax)，它允许 HTML 与 JavaScript 的混写。JSX 的基本语法规则：遇到 HTML 标签（以 `<` 开头），就用 HTML 规则解析；遇到代码块（以 `{` 开头），就用 JavaScript 规则解析。

#### 新建入口文件

在src目录下，新建程序的入口文件app.js:

```javascript
import React from "react";
import ReactDOM from "react-dom";
import Home from './views/Home'

ReactDOM.render(
    <Home />,
    document.getElementById('root')
);
```

ReactDOM.render 是 React 的最基本方法，用于将模板转为 HTML 语言，并插入指定的 DOM 节点。上面的方法，将Home插入root节点下，Home即是上一步新建JSX语法文件Home.js中定义的文字“Hello World”。

#### 新建页面

在根目录下，新建页面文件index.html:

```html
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>redux blog</title>
</head>
<body>
    <div id="root"></div>
    <script type="text/javascript" src="./dist/bundle.js"></script>
</body>
</html>
```

#### Webpack

##### 安装

Webpack是一个模块打包工具，能够把各种文件（例如：ReactJS、Babel、Coffeescript、Less/Sass等）作为模块进行编译后进行打包。输入如下命令安装Webpack：

<!-- more -->

```shell
sudo npm install webpack -g
```

##### Webpack配置文件

每个项目下都应该包含一个webpack.config.js，用来告诉Webpack需要做些什么。Webpack在执行的时候，默认会搜索当前目录下的webpack.config.js文件。如下所示：

```javascript
module.exports = {
  entry: "./app.js",
  output: {
    path: __dirname+"/dist",
    filename: "bundle.js"
  }
}
```

添加配置文件后，再终端中直接执行`webpack`命令，生成的结果一样。配置文件的名称和位置也可以通过参数进行指定：

```shell
webpack --config common.js
```

注意如果在key entry中填写`app.js`时，直接添加文件夹下应该有node_modules文件夹，因为默认到此目录下寻找app.js，所以此处写成`./app.js`比较合适，同时app.js应该放在项目的根文件夹下。entry为项目开始打包时执行的入口( Here the application starts executing and webpack starts bundling)。

这个配置文件让Webpack以`./app.js`文件为入口，将文件需要的所有依赖打包成一个独立可执行的JavaScript文件，并保存到`dist/bundle.js`。

##### 将项目与Webpack结合

通过npm启动webpack，需要在package.json中的scripts配置处定义：

```json
"scripts": {
    "watch": "./node_modules/.bin/webpack-dev-server --hot --inline --content-base --port 8083 .",
    "dev": "webpack --watch --progress --colors --display-error-details --config webpack/webpack.config.js"
  }
```

接着运行：

```shell
npm run watch
```

登录浏览器：

```html
http://localhost:8083
```

效果如下图：

{% asset_img react-hello-world.png React示例%}



#### 常见问题

##### Error: Cannot find module 'optimist' webpack

在运行webpack命令时，提示`Error: Cannot find module 'optimist' webpack`，此时可以删除Webpack模块，重新安装：

```shell
sudo rm -rf /opt/local/node/lib/node_modules/webpack
sudo npm install webpack -g
```

重新安装后，webpack命令可以正常使用。

##### ERROR in Entry module not found: Error: Can't resolve 'app.js'

在添加了webpack.config.js文件后，提示如下错误：

```
ERROR in Entry module not found: Error: Can't resolve 'app.js' in '/home/hldev/summerize/dolphin-framework-frontend'
```

使用命令`webpack --display-error-details`输出详细错误，是缺少了文件夹node_modules。



参考资料：

[Webpack Configuration Docuemnt](https://webpack.js.org/configuration/)

[React 入门实例教程](http://www.ruanyifeng.com/blog/2015/03/react.html)

[详解Webpack+Babel+React开发环境的搭建](https://segmentfault.com/a/1190000006053772)