---
title: Redux调试
date: 2017-02-09 18:56:39
tags:
- Redux
- DevTools
categories: Tool
---

#### 安装

Redux DevTools可以实时监视Redux状态树Store。

<!-- more -->

```
npm install --save-dev redux-devtools
npm install --save-dev redux-devtools-log-monitor
npm install --save-dev redux-devtools-dock-monitor
```

最简单的调试，可以在代码中加入debugger语句，执行到语句时会自动命中断点。此种方法不够灵活，每次都要在代码中增加和移除debugger语句，比较低效。也可以在DevTool中直接按Ctrl + P快捷键，直接搜索相应的js文件打断点。