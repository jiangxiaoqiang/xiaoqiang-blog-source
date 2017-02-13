---
title: babel使用
date: 2017-02-13 16:10:47
tags:
- babel
categories: Frontend
---

#### bebel简介

bebel是一个JavaScript转码器，由于每个浏览器对ES6标准支持的程度有区别，对之前的ES标准支持良好，bebel的作用就是将ES6标准编写的代码转换为浏览器支持良好的JavaScript，开发者可以使用ES的新特性，而又保证了浏览器的兼容性。

<!-- more -->

#### SyntaxError: Unexpected token分析

在使用命令：

```
webpack --watch --progress --colors --display-error-details --config webpack/webpack.config.js
```

编译项目时，提示错误：

```
ERROR in ./src/views/HomeRedux.js
Module build failed: SyntaxError: Unexpected token (12:9)

export * as listAction from '../components/Home/PreviewListRedux';
         ^
```

在使用export导出模块时提示语法错误，原来是此处是ES2017的写法。需要在配置文件中增加`stage-0`配置：

```javascript
var webpack = require('webpack');

module.exports = {
    entry: "./src/app.js",
    output: {
        path: "./dist",
        filename: "bundle.js"
    },
    module: {
        loaders: [
            {
                test: /\.jsx?$/,
                loader: 'babel-loader',
                exclude: /node_modules/,
                query: {
                	//增加stage-0配置，支持ES7
                    presets: ['es2015', 'react', 'stage-0']
                }
            }
        ]
    },
    resolve: {
        extensions: ['*', '.coffee', '.js']
    }
}
```

`presets`字段设定转码规则，官方提供以下的规则集，可以根据需要安装。

```Bash
# ES2015转码规则
$ npm install --save-dev babel-preset-es2015

# react转码规则
$ npm install --save-dev babel-preset-react

# ES7不同阶段语法提案的转码规则（共有4个阶段），选装一个
$ npm install --save-dev babel-preset-stage-0
$ npm install --save-dev babel-preset-stage-1
$ npm install --save-dev babel-preset-stage-2
$ npm install --save-dev babel-preset-stage-3
```

参考资料：

[Babel 入门教程](http://www.ruanyifeng.com/blog/2016/01/babel.html)

[babel-loader jsx SyntaxError: Unexpected token](http://stackoverflow.com/questions/33460420/babel-loader-jsx-syntaxerror-unexpected-token)