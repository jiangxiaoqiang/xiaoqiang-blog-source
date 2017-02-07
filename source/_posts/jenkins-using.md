---
title: Jenkins使用
tags:
  - Jenkins
categories: Programming
date: 2017-02-06 15:36:35
---

项目的开发情况是源码管理采用Git，构建工具采用的是Gradle。

#### 安装Git相关插件

项目的源码管理采用的是Git，所以签出源码首先需要Git相关的插件：

* Git Clinet Plugin
* Git Plugin
* GitLab Plugin
* AnsiColor

#### 安装Gradle相关插件

* Gradle Plugin

在插件安装中心没有搜索到Gradle Plugin，直接在Google里搜索插件，上传到Jenkins进行安装即可。



#### Publish Over SSH

配置如下如所示。

{% asset_img publish-over-ssh-config.jpg Publish Over SSH配置%}

`**/*.war`:匹配当前路径(target/)下所有war包.Remove prefix移除target前缀，Remote directory表示远程目录。

