---
title: HTTP请求的URL编码问题
date: 2017-03-03 15:24:59
tags:
- HTTP
- UrlEncoding
categories: Network
---

今天反映用中文查询数据时，接口没有返回数据。

<!-- more -->

使用curl请求，URL参数为英文字符时可以成功返回数据。URL为中文时，无法查询。提示的错误如下：

> Invalid character found in the request target. The valid characters are defined in RFC 7230 and RFC 3986

但是将中文编码作为参数，可以查询。

```shell
curl --data-urlencode "param1=value1&param2=value" http://hostname.com
```

断定是服务端在接受到汉字参数时无法解析导致的此问题。

根据此次情况得到的经验：

* 客户端请求时对URL进行编码

