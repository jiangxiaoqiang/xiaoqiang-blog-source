---
title: npm使用
date: 2017-01-10 14:26:23
tags:
- npm
categories: Programming
---



npm是Node Package Manager的简称。

<!-- more -->

#### npm install&npm update

`npm update/install`命令获取每个模块的版本信息时，是从registry的查询服务中获取的 ，每次运行`npm install`命令时，都会看到链接[`https://registry.npmjs.org/`](https://registry.npmjs.org/) 。这个网址后面跟上模块名，就会得到一个 JSON 对象，里面是该模块所有版本的信息。比如，访问 [`https://registry.npmjs.org/react`](https://registry.npmjs.org/react)，就会看到 react 模块所有版本的信息。比如输入如下命令：

```shell
curl https://registry.npmjs.org/react
```

返回的Json内容太多，阅读不方便。可以使用Python自带的命令格式化输出Json，没有Json语法高亮。

```Shell
curl https://registry.npmjs.org/react | python -m json.tool
```

如果Google Chrome浏览器安装了Json Viewer Formatter也可以在浏览器中直接输入网址查看。

```json
{
    "_id": "react", 
    "_rev": "716-fbb4ebd8f08862c8fca223dc40369419", 
    "name": "react", 
    "description": "React is a JavaScript library for building user interfaces.", 
    "dist-tags": {
        "latest": "15.4.2", 
        "0.10.0-rc1": "0.10.0-rc1", 
        "0.11.0-rc1": "0.11.0-rc1", 
        "next": "16.0.0-alpha.3"
    }, 
    "versions": {
        "0.0.1": {
            "name": "react", 
            "description": "React is a javascript module to make it easier to work with asynchronous code, by reducing boilerplate code and improving error and exception handling while allowing variable and task dependencies when defining flow.", 
            "version": "0.0.1", 
            "author": {
                "name": "Jeff Barczewski", 
                "email": "jeff.barczewski@gmail.com"
            }, 
            "repository": {
                "type": "git", 
                "url": "git://github.com/jeffbski/react.git"
            }, 
            "bugs": {
                "url": "http://github.com/jeffbski/react/issues"
            }, 
            "licenses": [
                {
                    "type": "MIT", 
                    "url": "http://github.com/jeffbski/react/raw/master/LICENSE"
                }
            ], 
            "main": "react", 
            "engines": {
                "node": "~v0.4.12"
            }, 
            "dependencies": { }, 
            "devDependencies": { }, 
            "_npmUser": {
                "name": "jeffbski", 
                "email": "jeff.barczewski@gmail.com"
            }, 
            "_id": "react@0.0.1", 
            "_engineSupported": true, 
            "_npmVersion": "1.0.103", 
            "_nodeVersion": "v0.4.12", 
            "_defaultsLoaded": true, 
            "dist": {
                "shasum": "c84d3dbff0c65577a52f0bfe431f8bcc155fa365", 
                "tarball": "https://registry.npmjs.org/react/-/react-0.0.1.tgz"
            }, 
            "maintainers": [
                {
                    "name": "jeffbski", 
                    "email": "jeff.barczewski@gmail.com"
                }
            ], 
            "directories": { }
        }
    }
}
```

如果想用高亮语法在Terminal中显示，可以使用如下命令：

```shell
# 安装jq
brew install jq
# 格式化输出Json
curl https://registry.npmjs.org/react | jq '.'
```



#### npm run

npm 允许在package.json文件里面，使用scripts字段定义脚本命令，供npm直接调用。例如可以在Package.json里面定义如下脚本：

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

以上的npm run命令就是直接调用的scripts字段指定的脚本，其实npm run命令是npm run-script命令的缩写。gulp是一个基于流的构建系统(The streaming build system)，暂时还不理解到底是个什么鬼东西。Webpack是一款用户打包前端模块的工具。主要是用来打包在浏览器端使用的javascript的。同时也能转换、捆绑、打包其他的静态资源，包括css、image、font file、template等。

在执行`npm run <command> `指令时，npm模块首先是执行在根目录下的package.json文件中script节点定义的对应的指令，package.json中调用Webpack完成项目的打包等工作。

#### cnpm

[cnpm](https://github.com/cnpm/cnpm)是淘宝做的一个npm的类似于国内镜像的东西(npm client for China mirror of npm)，由于众所周知的原因，npm的使用在国内不是很稳定，经常会遇到无反应，一直等待的情况。cnpm要求NodeJS的版本至少是4.0.0。当有时遇到npm更新包卡死的情况时，试一试命令：

```
cnpm install
```

