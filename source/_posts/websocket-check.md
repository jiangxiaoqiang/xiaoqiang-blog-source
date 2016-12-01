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

Fiddler中的WebSocket显示乱码是因为数据已经被压缩(Compressed),要查看乱码的内容，在Response中添加头信息。按下F2按钮后，即可在Response中手动添加头信息(Add Headers)。

```
Content-Encoding: deflate
```

添加头信息之后，点击TextView会出现黄色的Decode提示框。

{% asset_img websocket-decode.jpg Fiddler查看WebSocket-Decode%}

点击之后即可看到原始的Json数据。