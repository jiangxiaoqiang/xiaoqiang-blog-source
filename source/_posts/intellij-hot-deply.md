---
title: Intellij Idea热部署
tags:
  - Intellij Idea
  - Hot Deploy
categories: Programming
date: 2016-10-10 18:55:23
---


下午遇到一个问题，在开发时，HTML修改后浏览器刷新始终不显示修改后的效果。经过朋友的指导，原来是要选择Exploded包进行部署。如图所示。

<!-- more -->

{% asset_img war-exploded-deploy.jpg 选择Exploded部署包%}

在Intellij的官方文档上如此描述：To have the application deployed as a directory, choose Web Application: Exploded.To have the application deployed in the packed form, choose Web Application: Archive.大意是如果想以目录形式部署，选择Exploded(adj. 爆炸了的；分解的；被破除的)模式,如果想以打包模式部署，则选择Archive模式。Exploded模式带来的好处是支持热部署，这样不用在开发过程中每次修改了内容后(HTML\JSP)都重新部署，重启一次大概要1-3分钟，有此可见大大提高了开发效率。缺点是多次部署后，Tomcat可能内存溢出，此时就必须重启Tomcat。

参考资料：

[What does Exploded Development mean? (In Java)]
[What does Exploded Development mean? (In Java)]:http://stackoverflow.com/questions/1289358/what-does-exploded-development-mean-in-java

[Configuring Web Application Deployment]
[Configuring Web Application Deployment]:https://www.jetbrains.com/help/idea/2016.2/configuring-web-application-deployment.html