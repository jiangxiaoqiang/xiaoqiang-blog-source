---
title: React开发环境搭建(Webpack+Babel+React)
date: 2017-02-08 15:07:25
tags:
- React
- Webpack
- Bebel
- Gulp
categories: Front End
---



#### Webpack

Webpack是一个模块打包工具，能够把各种文件（例如：ReactJS、Babel、Coffeescript、Less/Sass等）作为模块进行编译后进行打包。输入如下命令安装Webpack：

<!-- more -->

```shell
sudo npm install webpack -g
```

安装完毕后，进入项目文件夹，这里是dolphin-framework-frontend。创建文件app.js:

```javascript
document.querySelector('#app').innerHTML = 'Hello World!';
```

创建文件index.html:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>dolphin-framework-frontend</title>
</head>
<body>
  <div id="app"></div>
  <script src="dist/bundle.js"></script>
</body>
</html>
```

文件创建完毕后，在终端执行：

```shell
webpack ./app.js ./dist/bundle.js
```

启动本地的HTTP服务：

```shell
python -m SimpleHTTPServer
```

在浏览器中输入访问地址：

```html
http://localhost:8000
```

此时在浏览器中可以看到输出的Hello World表示成功。

#### 定义Webpack配置文件

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

#### 使用Babel

Babel 是一个 JavaScript 编译器。使用它可以将ES6的语法转换为ES5的语法，以便在现在有的环境执行。在工程中安装Babel:

```shell
sudo npm install --save-dev babel-cli babel-core babel-polyfill babel-preset-es2015 babel-preset-react
```

babel-preset-es2015和babel-preset-react分别是ES6和React的插件集。babel通过polyfill来支持某些方法在低级别上浏览器不支持的问题。

#### 使用React

终端输入以下代码对react和react-dom进行安装：

```
sudo npm install react react-dom --save
```

Babel针对React的所有的预设插件：

```
sudo npm install babel-preset-react --save-dev
```

 webpack的位置文件：

```javascript
module.exports = {
  entry: "./app.js",
  output: {
    path: __dirname+"/dist",
    filename: "bundle.js"
  },
 module: {
    loaders: [
      {
        test: /\.jsx?$/,
        loader: 'babel-loader',
        exclude: /node_modules/,
        query: {
          presets: ['es2015','react']
        }
      }
    ]
  },
  resolve: {
    extensions: ['*','.coffee','.js']
  }
}
```

当解析JavaScript文件时，使用babel-loader进行转义。hello.js文件如下：

```javascript
import React from "react";

class Hello extends React.Component{
  render() {
    return (
      <div>
          Hello, World!
      </div>
    )
  }
}

export default Hello;
```

app.js的内容如下：

```javascript
import React from "react";
import ReactDOM from "react-dom";
import Hello from "./hello";

ReactDOM.render(
        <Hello />,
        document.querySelector('#app')
);
```

#### 使用Gulp构建

Gulp基于文件流的构建系统，是一个流程控制工具，使用如下命令安装Gulp：

```shell
sudo npm install gulp -g
```

以上命令是全局安装，安装后就可以直接在终端中使用gulp命令了。输入如下命令在当前项目中安装：

```shell
sudo npm install --save-dev gulp gulp-uglify
```

在项目目录下创建gulp.js文件：

```javascript
var gulp = require('gulp'),
    uglify = require('gulp-uglify');

gulp.task('default', function(){
    gulp.src('src/app.js')
        .pipe(uglify())
        .pipe(gulp.dest('dist/'));
});
```

直接输入gulp命令即可运行。

#### 使用Webpack Server

添加webpack-dev-server作为项目的依赖：

```shell
sudo npm install -D webpack-dev-server
```

-D参数代表Dependency的含义。执行命令后，会在package.json文件的devDependencies中添加相应的依赖。



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

[详解Webpack+Babel+React开发环境的搭建](https://segmentfault.com/a/1190000006053772)