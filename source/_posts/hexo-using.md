---
title: hexo使用总结
date: 2016-12-18 11:37:59
tags:
- Hexo
categories: Programming
---


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

访问http://localhost:4000页面空白，提示can not get /，此时需要在源码目录下运行一下npm install命令即可。
