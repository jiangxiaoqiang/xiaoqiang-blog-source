---
title: npm使用
date: 2017-01-10 14:26:23
tags:
- npm
categories: Programming
---

#### 基础

npm 允许在package.json文件里面，使用scripts字段定义脚本命令。例如可以在Package.js里面定义如下脚本：

<!-- more -->

```Json
{
  "name": "xiaoqiang",
  "version": "0.0.1",
  "private": true,
  "devDependencies": {
    "babel-core": "6.18.2"
  },
  "dependencies": {
    "antd": "2.6.0"  
  },
  "scripts": {
    "site-dev": "./node_modules/gulp/bin/gulp.js",
    "site-watch": "./node_modules/gulp/bin/gulp.js watch",
    "dev": "webpack --watch --progress --colors --display-error-details --config webpack/dev.config.js",
    "build": "webpack --verbose --display-error-details --config webpack/dev.config.js && ./node_modules/gulp/bin/gulp.js",
    "prod": "webpack --progress --display-error-details --config webpack/prod.config.js && ./node_modules/gulp/bin/gulp.js"
  }
}
```

运行脚本：

```Bash
# 安装依赖，如果我们的项目依赖了很多package，一个一个地安装那将是个体力活。
# 可以将项目依赖的包都在package.json这个文件里声明，然后一行命令搞定
npm install
# 运行脚本里的site-dev,相当于执行npm gulp.js
npm run site-dev
npm run dev
```

gulp是一个基于流的构建系统(The streaming build system)，暂时还不理解到底是个什么鬼东西。Webpack是一款用户打包前端模块的工具。主要是用来打包在浏览器端使用的javascript的。同时也能转换、捆绑、打包其他的静态资源，包括css、image、font file、template等。
