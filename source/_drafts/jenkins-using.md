---
title: Jenkins使用
tags:
- Jenkins
categories: Programming
---


#### Publish Over SSH

配置如下如所示。

{% asset_img publish-over-ssh-config.jpg Publish Over SSH配置%}

`**/*.war`:匹配当前路径(target/)下所有war包.Remove prefix移除target前缀，Remote directory表示远程目录。

