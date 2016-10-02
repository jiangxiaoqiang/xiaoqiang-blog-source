---
title: 在Eclipse中启动和调试Tomcat（一）
tags: Tomcat
date: 2016-09-20 12:15:42
---


在Eclipse中调试Tomcat可以分析HTTP请求从Tomcat捕获到Servlet的过程。这个是调试Tomcat的目的。调试的环境是：

* IDE：Eclipse Java EE IDE for Web Developers.Version: Neon Release (4.6.0) Build id: 20160613-1800


* Tomcat 8.0（8.0.37）


* JDK 1.8

* OS：Windows 7 Ultimate x64

<!--more-->

#### 创建项目Tomcat8

创建一个新的Java类型项目，项目名称为“Tomcat8”，如下如所示。

{% asset_img create-new-java-project.jpg 新建项目Tomcat8%}

#### 下载Tomcat 8.0.37二进制包

下载[Tomcat 8.0.37](https://tomcat.apache.org/download-80.cgi)对应的二进制文件。将之拷贝到项目Tomcat8项目的根目录。拷贝之后Tomcat项目的目录结构如下图所示。

{% asset_img tomcat8-tree-structure.jpg Tomcat8项目目录树结构%}


#### 创建另一个项目test

创建一个Maven的webapp项目,名字为“test”。

#### 新建自定义Servlet

在test项目下新建一个自定义Servlet,名字为“TestServlet”，如图所示：

{% asset_img add-custom-servlet.jpg 添加自定义Servlet%}

由于TestServlet实现HttpServlet接口，HttpServlet接口的定义在servlet-api.jar包中，所以在test项目的Library中需要引用Tomcat8项目目录下的servlet-api.jar包。新建自定义Servlet完成后在Tomcat8项目中配置servlet映射(/webapps/examples/WEB-INF)：

```XML
<servlet-mapping>
    <servlet-name>test</servlet-name>
    <url-pattern>/demo/test</url-pattern>
</servlet-mapping>
```

以上映射说明从/demo/test发送的请求由名为test的Servlet来处理。在Tomcat8项目中配置servlet(/webapps/examples/WEB-INF)：

```XML
<servlet>
    <servlet-name>test</servlet-name>
    <servlet-class>demo.TestServlet</servlet-class>
</servlet>
```
以上配置指明名为test的Servlet处理的类的完整路径为：demo.TestServlet。

#### 配置调试参数

配置test项目，创建调试配置，配置Main Class为Tomcat的启动类：

```Java
org.apache.catalina.startup.Bootstrap
```

配置test项目的工作空间为Tomcat8的工作空间，如图所示：

{% asset_img config-workspace.jpg 配置test项目工作空间%}



#### 调试

在自定义的Servlet的doGet方法上打断点，打开浏览器访问[链接](http://localhost:9090/examples/demo/test)即可命中自定义Servlet。从这里可以加深理解HTTP请求到自定义Servlet处理的过程，可以理解Spring MVC和Tomcat是如何联系起来的。

源自：

* [Launching and Debugging Tomcat from Eclipse without complex plugins]

[Launching and Debugging Tomcat from Eclipse without complex plugins]:http://andreas.haufler.info/2012/01/launching-and-debugging-tomcat-from.html



