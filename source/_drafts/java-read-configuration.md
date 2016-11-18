---
title: Java读取配置文件
tags:
- Java
- Configuration
categories: Programming
---

#### ResourceBundle

这个类提供软件国际化的捷径。通过此类，可以使您所编写的程序可以：

* 轻松地本地化或翻译成不同的语言
* 一次处理多个语言环境
* 以后可以轻松地进行修改，支持更多的语言环境

这个类的作用就是读取资源属性文件（properties），然后根据.properties文件的名称信息（本地化信息），匹配当前系统的国别语言信息（也可以程序指定），然后获取相应的properties文件的内容。当在中文操作系统下，如果myres_zh_CN.properties、myres.properties两个文件都存在，则优先会使用myres_zh_CN.properties，当myres_zh_CN.properties不存在时候，会使用默认的myres.properties。

#### Spring读取配置


```Java
@Value("${bootstrap.servers}")
private String serverUrl;
```

在Property配置文件中：

```Java
bootstrap.servers=192.168.24.195:6667
```


