---
title: Windows下用Nexus搭建Maven私服
tags:
- Maven
- Nexus
categories: Programming
---

#### Nexus简介

使用Maven的中央仓库存在如下问题：

* Maven自己的中央库访问速度非常慢，外加GFW，基本没法用。
* 有些jar包由于版权原因，maven中央仓库没有，比如oracle JDBC驱动。另外也会有一些项目中用到的比较老的开源jar包， 中央仓库也没有。这种情况我们需要把jar包手动上传到私服。
* 公司自己开发的jar包并不开源，不能上传到maven中央仓库，只能部署到私服上面。

<!-- more -->

Nexus 是Maven仓库管理器，如果你使用Maven，你可以从Maven中央仓库下载所需要的构件（artifact），但这通常不是一个好的做法，你应该在本地架设一个Maven仓库服务器，在代理远程仓库的同时维护本地仓库，以节省带宽和时间，Nexus就可以满足这样的需要。此外，他还提供了强大的仓库管理功能，构件搜索功能，它基于REST，友好的UI是一个extjs的REST客户端，它占用较少的内存，基于简单文件系统而非数据库。这些优点使其日趋成为最流行的Maven仓库管理器。下载Nexus（nexus-3.0.1-01-win64.exe），安装完毕后访问[本地Maven私服主页](http://192.168.1.102:8081/)。

#### 配置单个项目

安装完毕后需要登录，默认的用户名密码是：<code>admin/admin123</code>。登录之后才会显示设置图标，才能添加repositories。将[本地Maven私服路径](http://192.168.1.102:8081/repository/maven-public/)配置到项目的pom.xml中即可。如下代码片段所示。

``` xml
<repositories>
    <repository>
        <id>nexus</id>
        <name>my-nexus-repository</name>
        <url>http://192.168.1.102:8081/repository/maven-public/</url>
        <releases>
            <enabled>true</enabled>
        </releases>
        <snapshots>
            <enabled>false</enabled>
        </snapshots>
    </repository>
</repositories>
<pluginRepositories>
    <pluginRepository>
        <id>nexus</id>
        <name>my-nexus-repository</name>
        <url>http://192.168.1.102:8081/repository/maven-public/</url>
        <releases>
            <enabled>true</enabled>
        </releases>
        <snapshots>
            <enabled>false</enabled>
        </snapshots>
    </pluginRepository>
</pluginRepositories>
```

如果在本地私服没有的jar包，会自动从中心服务器下载。至此，最简单的Maven私服搭建完毕。

#### 配置全局应用

在Maven的settings.xml中配置profile元素，这样就能让本机所有的Maven项目都使用自己的Maven私服。

```XML
<mirrors>
    <mirror>
      <id>central</id>
      <mirrorOf>*</mirrorOf>
      <name>Human Readable Name for this Mirror.</name>
      <url>http://localhost:8081/nexus/content/groups/public/</url>
    </mirror>
  </mirrors>
  <profiles>
    <profile>
      <id>nexus</id>
      <repositories>
        <repository>
          <id>nexus</id>
          <name>Nexus</name>
          <url>http://localhost:8081/nexus/content/groups/public/</url>
          <releases>
			<enabled>true</enabled>
		  </releases>
          <snapshots>
			<enabled>true</enabled>
		  </snapshots>
        </repository>
      </repositories>
    </profile>
</profiles>
```
