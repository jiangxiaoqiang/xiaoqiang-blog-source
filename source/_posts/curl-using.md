---
title: curl使用
date: 2016-11-19 02:02:32
tags:
- curl
categories: Programming
---

#### 简介

curl is a tool to transfer data from or to a server, using one of the supported protocols (DICT, FILE, FTP, FTPS, GOPHER, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP, SCP, SFTP, SMB, SMBS, SMTP, SMTPS, TELNET and TFTP). The command is designed to work without user interaction.

curl offers a busload of useful tricks like proxy support, user authentication, FTP upload, HTTP post, SSL connections, cookies, file transfer resume, Metalink, and more. As you will see below, the number of features will make your head spin!

<!-- more -->

#### 查看网页源码

直接在curl命令后加上网址，就可以看到网页源码。我们以网址www.jiangxiaoqiang.com为例，输入如下命令行：

```Bash
curl www.jiangxiaoqiang.com
```

返回的结果为：

```HTML
<html>
<head><title>301 Moved Permanently</title></head>
<body bgcolor="white">
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx</center>
</body>
</html>
```

#### Ｃookie

使用`--cookie`参数，可以让curl发送cookie，如下命令行所示。

```Bash
curl --cookie "name=xxx" www.example.com
```

`-c cookie-file`可以保存服务器返回的cookie到文件，`-b cookie-file`可以使用这个文件作为cookie信息，进行后续的请求。

```Bash
curl -c cookies http://example.com
curl -b cookies http://example.com
```

如果服务端采用Cookie验证登录请求。那么可以首先用浏览器登录网页，找到相应的Cookie，如下图所示：

{% asset_img curl-setcookie.jpg 找到Cookie %}

当Curl请求时，附加上Cookie就可以模拟浏览器的登录请求动作了，如下命令所示：

```Bash
curl --cookie "cc-o-t=Q2ZWTGp3bFQrTmtOcG9pcTJ4SFV2VnpmNzNhaEhMbktoQWlXeWVyaGhVS3JWeVJEcEprTXBsbldDS3VCN01CeVRFNGxYVTZmQ2hIbHhTSy8zKzF3cDQvYjEwRncxUXgrQ3pMWC9XeTYzcXFrQ1NqQWkrdXRhMUJEc3RZV3ExK0k" http://localhost:28080/api/xzss/detail/1
```

#### 请求API数据

比如需要在请求头中添加Key、Value键值对，可以添加-H(Header)参数，如下命令行所示：

```Bash
curl -H "APPID:123" http://localhost:28080/api/xysj?xdrShxym=addd
```

如果是需要发送多个请求头，那么多次指定-H参数即可,如下命令所示。

```Bash
curl -H "APPID:123" -H "TIMESTAMP:2016-12-19 16:58:02" -H "ECHOSTR:sdsaasf" -H "TOKEN:sdsss" http://localhost:28080/api/xysj?xdrShxym=addd
```

#### 参数

在Restful多参数请求时，需要使用转义符号。url为`http://mywebsite.com/index.PHP?a=1&b=2&c=3`时，web形式下访问url地址，使用$\_GET是可以获取到所有的参数。然而在Linux下

```
curl http://mywebsite.com/index.php?a=1&b=2&c=3
```

$\_GET只能获取到参数a,由于url中有&，其他参数获取不到，在linux系统中&会使进程系统后台运行,必须对&进行一下转义才能获取到所有参数。

```
curl http://mywebsite.com/index.php?a=1\&b=2\&c=3
```

这一个细节需要注意。在提交POST请求时，如果参数里包含有汉字和特殊字符等，最好进行一下编码：

```shell
curl -X POST --data-urlencode "param1=汉字&param2=汉字" "www.xxxx.com"
```

如果不进行编码，服务端有可能无法处理带有特殊字符的请求。

#### 下载文件

如下命令是使用curl下载XX-net工具。

```Bash
curl -o xxnet.zip https://codeload.github.com/XX-net/XX-Net/zip/3.2.8
```

-o, --output <file>，文件的保存名称。

#### 提交POST请求

使用Curl提交Post请求如下：

```Bash
curl -H "APPID:hlb11529c136998cb6" -H "TIMESTAMP:2016-12-19 16:58:02" -H "ECHOSTR:sdsaasf" -H "TOKEN:14d45648c62a746ae9dd9b90c03c50893061222d" -H "Accept:application/json" -H "Accept:application/json" -H "Content-Type:application/json" -X POST -d '{"id":1}' http://localhost:28080/api/xzss/savejson

curl -H "APPID:hlb11529c136998cb6" -H "TIMESTAMP:2016-12-19 16:58:02" -H "ECHOSTR:sdsaasf" -H "TOKEN:14d45648c62a746ae9dd9b90c03c50893061222d" http://192.168.32.105:28080/api/blacklist?xdr=4567890123
```

使用Curl请求时，默认是Get请求，如果需要显示指定请求类型，那么需要加上-X(--request)参数。

参考资料：

* [curl网站开发指南](http://www.ruanyifeng.com/blog/2011/09/curl.html)
