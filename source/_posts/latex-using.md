---
title: Latex使用总结
date: 2017-04-05 11:41:14
tags:
- latex
categories: Tool
---

平时使用的编辑器是Textudio。

<!-- more -->


#### 表格

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
