---
title: Google Chrome总结与分享
tags:
  - Chrome
categories: Programming
date: 2017-01-19 13:28:26
---


#### 禁用Google Chrome的Javascript

禁用Javascipt可以提升浏览网页的安全性。如下图所示。

{% asset_img google-chrome-startup-icon.png Google-Chrome快速启动图标%}

<!-- more -->

#### 打开Google Chrome任务管理器


可以使用快捷键<code>Shift + Esc</code>打开Google Chrome的任务管理器控制台。如下图所示:


{% asset_img google-chrome-task-manage-console.jpg Google Chrome任务管理控制台%}

#### 快捷键(Shortcuts)

| 快捷键(Short Keys)                  |          作用           |
| -------------------------------- | :-------------------: |
| 打开“菜单”                           | Alt + f、Alt + e 或 F10 |
| Ctrl + Shift + T                 |  恢复已关闭的标签页（最多恢复10项）   |
| chrome://version/（about:version） |  查看Google Chrome版本信息  |
| chrome://plugins/（about:plugin）  |  查看Google Chrome版本信息  |
| Ctrl + Shift + B                 |        显示隐藏书签         |
| G                                |        滑倒页面的底部        |
| gg                               |        滑倒页面的顶部        |
| Ctrl + 9                         |      切换到最后一个标签页       |

在管理Google书签时，虽然没有发现快捷键，但是在安装了Vimium插件之后，可以按下键O或者B(Bookmark),输入关键字搜索书签内的内容，类似于快捷键效果。

#### 一些小技巧

##### copy as cURL

在调试网页时,有时需要重复发送请求查看,如果每次都填写表单会比较麻烦,此时可以使用copy as cURL.如下图所示:

{% asset_img chrome-copy-as-curl.png copy as cURL %}

将复制出来的命令放到终端中执行,会更加方便 .

```shell
curl 'http://test/pubapi/advice/create' -H 'HL-APP-KEY: SharePortal' -H 'Origin: http://test' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: zh-CN,zh;q=0.8,en;q=0.6,zh-TW;q=0.4' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36' -H 'Content-Type: application/json;charset=UTF-8' -H 'Accept: application/json, text/plain, */*' -H 'Referer: http://test/jointConference/suggestion' -H 'Cookie: JSESSIONID=7FA6BD4DB8921445D986C2F42EE90A1C; validate-code=WHNZenQvMHNZaUdPSysxpuSFp3emlRS3QxVExxVUzlYN2x5Rmc0QmpaL05kWjVxWVBicGFIQktkN2c9PQ; cc-o-t=azRuzdEWDMzMXZodGFNc9QR1NLbTVtK0NRQldLbG5UWlIvQ1NuTmtCWnhrR0tmYjVoMkFpV1lqbnRBY2toZjVjVHhlZ2h1c0szREhsemw5NnZuUE1rZDl6a0tvWHErZzlya1FNeHI2WjZXRlQ' -H 'Connection: keep-alive' -H 'DNT: 1' --data-binary '{"theme":"trthrt","advice":"gdgd","name":"gdgg","phone":"41414","address":"gsggsg","groupId":"500001000001","userId":1}' --compressed
```



#### Plugin


##### Vimium(装逼神器，必备)

Vimium is an open source Google Chrome Extension which provides keyboard short-cuts for navigation and control in the spirit of the Vim editor. Unlike other add-ons for web browsers such as Vimperator or Pentadactyl, it doesn’t modify the browser’s interface but instead focuses on allowing the user to navigate web pages, tabs and links using vim-like keyboard commands rather than the mouse. It also allows the user to map or customise its key bindings.

| 快捷键(Short Keys) |      作用       |
| --------------- | :-----------: |
| Shift + ?       | 调取出Vimium帮助页面 |

###### 键盘选择网页文字

* 搜索起始点：/搜索内容
* 按 Enter。
* 启用视觉模式：v，按行的视觉模式：Shift + V
* 使用 vim 导航键选择文本：h、j、k、l、b、e、w、$（Shift + w，这个组合键可以按单词选择）
* 使用 y 将选择的文本复制到剪贴板。
* 切换程序，使用 Ctrl+V，将文本粘贴到其他程序中。

 步骤还是有点繁琐，这里还是鼠标要来的方便一些。

##### Auto Refresh

最近在研究项目的前端部分，有时候修改了一下前端网页需要刷新一下浏览器，每次手动刷新，甚是麻烦。可以安装一个自动刷新Google Chrome页面的插件[Super Auto Refresh](https://chrome.google.com/webstore/detail/kkhjakkgopekjlempoplnjclgedabddk/reviews)，省去了重复手动刷新页面的烦恼。当然最理想的状态是能够像Browsersync那样即时刷新即时生效，但是可能和Webpack冲突，有时间后再行研究。

* [Chrome 键盘快捷键](https://support.google.com/chrome/answer/157179?hl=zh-Hans)
