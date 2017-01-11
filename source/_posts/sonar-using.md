---
title: Sonarcube安装与使用
date: 2017-01-10 15:51:54
tags:
- Sonarcube
categories: Tool
---

#### 配置数据库

登录MySQL数据库：

```Bash
mysql -u root -p
```

<!-- more -->

创建sonar数据库：

```SQL
create database sonar default charset=utf8;
```

配置 sonar 用户：

```SQL
create user 'sonar' identified by 'sonar123';  
grant all on sonar.* to 'sonar'@'%' identified by 'sonar123';
grant all on sonar.* to 'sonar'@'localhost' identified by 'sonar123';  
flush privileges;
```

#### 配置sonar

编辑 ${SONAR_HOME}/conf/sonar.properties：

```
# User credentials.
# Permissions to create tables, indices and triggers must be granted to JDBC user.
# The schema must be created first.
sonar.jdbc.username=sonar
sonar.jdbc.password=sonar123

#----- Embedded Database (default)
# H2 embedded database server listening port, defaults to 9092
#sonar.embeddedDatabase.port=9092
#----- MySQL 5.6 or greater
# Only InnoDB storage engine is supported (not myISAM).
# Only the bundled driver is supported. It can not be changed.
sonar.jdbc.url=jdbc:mysql://localhost:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance
```

配置完毕后，启动sonar：

```Bash
./sonar.sh start &
```

启动成功后，访问地址：`http://localhost:9000`，即可看到sonarqube的主界面。首次登录的用户名和密码都是admin。

#### Sonar插件

在多项目构建中的Sonar配置：

```

```
