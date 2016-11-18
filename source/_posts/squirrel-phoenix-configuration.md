---
title: SQuirreL GUI客户端集成Phoenix、MySQL配置
tags:
  - SQuirreL
  - Phoenix
categories: Programming
date: 2016-10-25 09:24:13
---

#### SQuirreL GUI客户端简介

SQuirreL GUI客户端来连接Phoenix，就像MySQL使用Navicat for MySQL，Oracle使用PL/SQL Developer一样，在进行一些数据库操作的时候能够更加的直观和方便。同时它还可以连接MySQL。

<!-- more -->

#### 下载并安装SQuirreL GUI

下载好的文件是一个压缩包(`squirrel-sql-3.7.1-standard.zip`)。不用解压缩，直接修改文件的后缀名为jar(`squirrel-sql-3.7.1-standard.jar`)，双击即可打开安装界面。如果无法双击打开，则可以通过命令行的方式打开：

```Bash
java -jar squirrel-sql-3.7-standard.jar
```

#### 下载驱动

到Phoenix[镜像站点](http://www.apache.org/dyn/closer.lua/phoenix/)下载包，这里选择的是<code>apache-phoenix-4.8.0-HBase-1.2-bin.tar.gzip</code>，到解压的<code>apache-phoenix-4.8.0-HBase-1.2-bin.tar.gzip</code>包的主目录下，将如下几个jar包拷贝到SQuirreL安装目录的lib目录下，例如本机路径是<code>D:\Program Files\squirrel-sql-3.7.1\lib</code>。

```
phoenix-4.8.0-HBase-1.2-client.jar
```

注意顺序，先拷贝jar包，在启动SQuirreL添加驱动，如果是拷贝jar包时已经启动了SQuirreL，那么SQuirreL需要重启一下，拷贝的jar包才生效，这个是需要注意的地方，可以参见[SQuirreL Configure: could not initial class org.apache.phoenix.jdbc.PhoenixDriver](http://stackoverflow.com/questions/40215921/squirrel-configure-could-not-initial-class-org-apache-phoenix-jdbc-phoenixdrive/40225765#40225765)。在连接不同的HBase数据库时，需要注意驱动的版本，不同版本的驱动是无法正确连接的。高版本的驱动无法连接低版本的HBase。

#### 添加Driver

添加Driver如下图所示。

{% asset_img sphonix-driver-configuration.jpg Sphonix增加驱动%}

Name填写用户自定义名称。Example URL填写ZooKepper地址。Class Name填写：`org.apache.phoenix.jdbc.PhoenixDriver`。

#### 添加Alias连接Hbase

如下图所示。

{% asset_img addAlias.jpg 增加Alias%}

Name是Alias的名字，可以填写自定义名称。Driver选择上一步配置好的Driver名称，这里是Phoenix。url填写Phoenix连接串：`jdbc:phoenix:192.168.24.226,192.168.24.195:2181:/hbase-unsecure`。UserName和Password填写操作系统的登录用户和登录密码。

#### 查询

SQL查询如下图所示。

{% asset_img configurationResult.jpg SQL查询%}

#### 连接MySQL

将MySQL的驱动`mysql-connector-java-5.1.39.jar`拷贝到lib目录下。

{% asset_img squirrel-connect-mysql.jpg SQuirreL连接MySQL%}

驱动链接填写：`jdbc:mysql://192.168.24.234:3306/clbs?useUnicode=true&characterEncoding=utf-8`。用户名和密码填写登录Linux主机的用户名和密码。

