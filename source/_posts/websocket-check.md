---
title: Websocket数据查看
tags:
  - WebSocket
categories: Programming
date: 2016-11-12 13:09:00
---


#### FireFox中查看WebSocket

使用FireFox查看WebSocket内容需要安装一个[WebSocket-Monitor](https://addons.mozilla.org/en-US/firefox/addon/websocket-monitor/)插件。安装完毕后在FireFox的Web控制台(Ctrl + Shift + K)中。


{% asset_img firefox-websocket.jpg FireFox查看WebSocket%}

<!-- more -->

#### Google Chrome中查看WebSocket

Google Chrome自带查看模块，如下图所示。F12进入开发者页面，选择NetWork选项卡，选择WS(WebSocket)选项卡。

{% asset_img chrome-websocket.jpg Google Chrome查看WebSocket%}


#### Fiddler中查看WebSocket

在请求时选择任意WebSocket Session，即可出现WebSocket流量数据画面，不过是乱码，未找到合适的解决乱码的方案。

{% asset_img fiddler-websocket.jpg Fiddler查看WebSocket%}


