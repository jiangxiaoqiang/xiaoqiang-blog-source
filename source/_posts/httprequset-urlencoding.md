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

但是将中文编码作为参数，可以查询。RFC3986文档规定，Url中只允许包含英文字母（a-zA-Z）、数字（0-9）、-_.~4个特殊字符以及所有保留字符。

```shell
curl --data-urlencode "param1=value1&param2=value" http://hostname.com
```

断定是服务端在接受到汉字参数时无法解析导致的此问题。由于是将Tomcat嵌入进Jar包进行编译，替换嵌入的Tomcat版本，将嵌入的Tomcat版本由7.0.75替换成8.0.35后，URL中可以带中文字符查询，估计是由于新版本会对URL中的汉字自动进行转义，不用再考虑请求中是否转义URL的问题。

```
buildscript {
    ext {
        springBootVersion = '1.4.5.RELEASE'
        jacksonVersion = '2.8.7'
        springfoxVersion = '2.6.1'
        poiVersion = "3.14"
    }
    ext['tomcat.version'] = '8.0.35'//原来是7.0.75
    repositories {
        maven { url 'http://repox.gtan.com:8078' }
        mavenCentral()
        jcenter()
        maven { url 'http://repo.spring.io/plugins-release' }
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:${springBootVersion}")
        classpath 'org.springframework.build.gradle:propdeps-plugin:0.0.7'
    }
}
```

根据此次情况得到的经验：

* 客户端请求时尽量对URL进行编码
* 服务端替换Tomcat版本
