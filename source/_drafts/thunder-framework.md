---
title: Nepxion-Thunder从Netty向Kafka消息写入消息
tags: 框架
---

Nepxion-Thunder框架[GitHub主页](https://github.com/Nepxion/Thunder).

在启动项目时都有类似如下的输出：

```
╔════╦╗─────────╔╗
║╔╗╔╗║║─────────║║
╚╝║║╚╣╚═╦╗╔╦═╗╔═╝╠══╦═╗
──║║─║╔╗║║║║╔╗╣╔╗║║═╣╔╝
──║║─║║║║╚╝║║║║╚╝║║═╣║
──╚╝─╚╝╚╩══╩╝╚╩══╩══╩╝
Nepxion Thunder  v1.0.0.RELEASE
```
可根据任意一行进行搜索找到程序的入口点，即在ThunderNamespaceHandlerSupport类中。

#### 名词解释


**Reference节点**：配置文件thunder:reference开始的节点
