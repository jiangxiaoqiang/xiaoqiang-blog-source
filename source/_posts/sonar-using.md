---
title: Sonarqube安装与使用
date: 2017-01-10 15:51:54
tags:
- Sonarqube
categories: Tool
---

Sonar是一个用于代码质量管理的开源平台，用于管理Java源代码的质量。

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

启动成功后，访问地址：`http://localhost:9000`，即可看到sonarqube的主界面。首次登录的用户名和密码都是admin。Sonar默认的端口是”9000”、默认的上下文路径是”/”、默认的网络接口是”0.0.0.0”，默认的管理员帐号和密码为:admin/admin.

#### Sonar插件

首先下载[sonar-scanner](http://docs.sonarqube.org/display/SONARQUBE52/Installing+and+Configuring+SonarQube+Scanner).下载完毕后，将解压完成后的软件拷贝到指定目录下，在此处，拷贝到目录`/opt/local/tools/`下。打开bash_profile脚本，配置sonarqube和sonar scanner环境变量:

```Bash
export SONAR_HOME=/opt/local/tools/sonarqube-6.2
export SONAR_SCANNER=/opt/local/tools/sonar-runner-2.4
export PATH=$PATH:$SONAR_HOME/bin:$SONAR_SCANNER/bin
```

使环境变量生效：

```Bash
source ~/.bash_profile

# 查看所有环境变量
env
```

在需要分析的项目的根目录下，新建文件sonar-project.properties。写入如下内容：

```Bash
# must be unique in a given SonarQube instance
sonar.projectKey=dolphin-1
# this is the name displayed in the SonarQube UI
sonar.projectName=dolphin
sonar.projectVersion=1.0

# Path is relative to the sonar-project.properties file. Replace "\" by "/" on Windows.
# Since SonarQube 4.2, this property is optional if sonar.modules is set. 
# If not set, SonarQube starts looking for source code from the directory containing 
# the sonar-project.properties file.
sonar.sources=/home/dolphin

# Encoding of the source code. Default is default system encoding
sonar.sourceEncoding=UTF-8
```

sonar.source是项目的源码目录，project name是项目名称。在项目的根目录下执行命令`sonar-runner`即可进行分析，分析完毕后登录sonar主页面`http://localhost:9000`即可查看分析结果。