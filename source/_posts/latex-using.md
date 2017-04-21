---
title: Latex使用总结
date: 2017-04-05 11:41:14
tags:
- latex
categories: Tool
---

平时使用的编辑器是Textudio。

<!-- more -->


### 表格

```tex
\begin{tabular}{|c|c|c|c|c|c|}
	\hline
	\multirow{2}*{} &  system & \multicolumn{2}{c|}{4.0} &  \multicolumn{2}{c|}{6.0} \\ 
	\cline{2-6}
	&   Device  & D1 & D2 & D3 & D4 \\
	\hline 
	\multirow{2}*{Runtime} & 600 byte & 12/23/34 & 23/2/1 & 12/1/2 & 1/2/3 \\
	\cline{2-6}
	& 1000 byte  & 12 & 21 & 12 & 12  \\
	\hline
	\multirow{2}*{请求参数列表} & 名称 & 类型 & 是否必填 & 备注 & 其他 \\
	\cline{2-6}
	& xdrShxym  & String & 是 & 需要传入完整参数精确匹配 & 无 \\
	\hline	
\end{tabular}
```

### 预览

#### PDF预览

有时电脑屏幕比较小，需要单独打开一个新的窗口外部预览(External Preview)而不是使用嵌入式窗口(Embedded Preview)预览。在Configure TeXStudio->Build->Meta Commands中，修改Default Viewer为`txs:///view-pdf-external`，如下图所示。

{% asset_img default-external-pdf-viewer.jpg 修改默认PDF预览%}


### 常见问题

#### File `TikZ.sty' not found. \usepackage

PGF/TikZ 是Latex中强大的画图工具（TikZ基于pgf）。pgf stands for Portable Graphics Format. TikZ is a recursive acronym for "TikZ ist kein Zeichenprogramm" (German for "TikZ is not a drawing program")。而TikZ则是在Tex环境下的一个宏包，实现了对PGF的封装。


