---
title: hexo使用总结
date: 2016-12-18 11:37:59
tags:
- Hexo
categories: Programming
---

Hexo是一个简洁、高效的博客框架。使用Markdown编写文章，快速渲染成博客静态网页。

<!--more-->

#### 安装

安装Hexo：

```Bash
npm install hexo --save
```

安装hexo-cli:

```Bash
npm install hexo-cli -g
```

仅仅安装了Hexo还不可以在浏览器中查看效果，还需要安装Hexo Server模块：

```Bash
npm install hexo-server --save
```

安装之后就可以使用hexo server命令了。在Ubuntu下安装会出现获取文件失败的错误，可能需要多次尝试。提示：WARN  No layout: index.html时，一般是由于主题文件不存在导致，安装相应的主题即可。切换到源码目录下：

```Bash
git clone https://github.com/iissnan/hexo-theme-next themes/next
```

访问`http://localhost:4000`页面空白，提示`can not get /`，此时需要在源码目录下运行一下npm install命令即可。

#### 安装搜索模块

安装搜索模块可自定义站内搜索，在源码目录下执行如下命令。

```Bash
npm install hexo-generator-searchdb --save
```

#### 安装Next主题

next主题是Hexo下一款非常简洁美观的主题，切换到themes目录下，执行如下命令：

```Bash
git clone https://github.com/iissnan/hexo-theme-next themes/next
```

#### 设置菜单

可以自己添加相应菜单，可以在一级菜单上添加一个书(Book)或者其他模块。
