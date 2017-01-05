---
title: Java rest总结
date: 2017-01-04 11:57:02
tags:
---


以下是开发Rest接口时遇到的一些问题。

<!-- more -->

#### HTTP信息转换

@ResponseBody 注解能够对客户端发过来的对象进行自动转换。

```Java
@RequestMapping(value = "savejson",method = RequestMethod.POST,headers = "content-Type=application/json")
@ApiOperation(value = "必须且只能传一个参数")
public void saveXzss(@RequestBody String summaryXzssJson) throws IOException {
    ObjectMapper mapper = new ObjectMapper();
    SummaryXzss summaryXzss = mapper.readValue(summaryXzssJson, new TypeReference<SummaryXzss>() {
    });
    xzssService.saveXzss(summaryXzss);
}
```

实现自动转换，必须满足以下两个条件：

1. 请求的 Content-Type 头信息必须是 application/json；
2. Jackson Json 库必须包含在应用程序的类路径下。

在接收客户端HTTP请求的消息时，如果客户端将请求的Json放到消息体中，那么服务端可以直接取实体，或者取相应的Json进行反序列化。2种方式都能够达到要求，一般是直接取实体，省去了反序列化的步骤，由框架进行反序列化。

#### 发送Post请求

发送Post请求时，需要指定Content-Type和Accept请求头。

```Bash
curl -H "APPID:hlb11529c136998cb6"
     -H "TIMESTAMP:2016-12-19 16:58:02"
     -H "ECHOSTR:sdsaasf"
     -H "TOKEN:14d45648c62a746ae9dd9b90c03c50893061222d"
     -H "Accept:application/json"
     -H "Accept:application/json"
     -H "Content-Type:application/json"
     -X POST -d '{"id":1}' http://localhost:28080/api/xzss/savejson
```

否则会提示415错误：

```
{
    "timestamp": "2017-01-04T03:28:26.404+0000",
    "status": 415,
    "error": "Unsupported Media Type",
    "exception": "org.springframework.web.HttpMediaTypeNotSupportedException",
    "message": "Content type 'application/x-www-form-urlencoded' not supported",
    "path": "/api/xzss/savejson"
}
```

The Content-Type header is used by @RequestBody to determine what format the data being sent from the client in the request is. The accept header is used by @ResponseBody to determine what format to sent the data back to the client in the response. That's why you need both headers.
