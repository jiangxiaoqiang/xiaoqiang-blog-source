---
Java Web开发------Hello World
---

环境准备：

* Apache Tomcat 8.0

* Eclipse Java EE IDE for Developers（Version: Neon Release (4.6.0) Build id: 20160613-1800）

* Apache Maven 3.3.9

* Java 1.8.0_101



## 新建一个Maven Web项目

### Create a new post

File-->New Project,选择Maven Project如下图所示。

![](images\java-web-helloworld\choose-maven-project.png)

注意项目类型选择webapp：

![](images\java-web-helloworld\choose-project-type.png)

![](images\java-web-helloworld\writen-artifactid.png)


新建完毕后在index.jsp页面中可能会有如下错误：

``` bash
The superclass "javax.servlet.http.HttpServlet" was not found on the Java Build Path
```

原因是没有引入javax.servlet-api.jar包。引用步骤参见: [Web开发环境搭建 Eclipse-Java EE 篇](http://www.cnblogs.com/yangyxd/articles/5615965.html#undefined)

启动Tomcat，浏览URL：http://192.168.1.102:8081/dolphin/index.jsp。

![](images\java-web-helloworld\visit-hello-world-page.png)
