---
title: Jenkins使用
tags:
  - Jenkins
categories: Programming
date: 2017-02-06 15:36:35
---

项目的开发情况是源码管理采用Git，构建工具采用的是Gradle。

<!-- more -->

#### 安装Git相关插件

项目的源码管理采用的是Git，所以签出源码首先需要Git相关的插件：

* Git Clinet Plugin
* Git Plugin
* GitLab Plugin
* AnsiColor

#### 常用命令

在浏览器中输入不同的命令可以操作Jenkins。

```
# 重启Jenkins
http://localhost:8080/restart 
```

#### 安装Gradle相关插件

* Gradle Plugin

在插件安装中心没有搜索到Gradle Plugin，直接在Google里搜索插件，上传到Jenkins进行安装即可。



#### 安装Scala相关插件

* sbt Plugin

项目开发中使用了Java与Scala，所以还需要安装Scala插件。

#### Publish Over SSH

配置如下如所示。

{% asset_img publish-over-ssh-config.jpg Publish Over SSH配置%}

`**/*.war`:匹配当前路径(target/)下所有war包.Remove prefix移除target前缀，Remote directory表示远程目录。



#### 常见问题

##### Gradle下载

在使用Wrapper编译项目时，Jenkins始终会去下载Gradle，但是本机已经有安装Gradle，而且用户目录下已经存在通过Wrapper下载的Gradle文件。原因是Jenkins安装时默认是jenkins用户，而当前用户是hldev，所以Jenkins会自动下载Gradle文件。解决的方法就是修改Jenkins的默认启动用户名和组的名称。修改`/etc/default/jenkins`配置文件，将组名称和用户名称修改如下：

```
# user and group to be invoked as (default to jenkins)
JENKINS_USER="hldev"
JENKINS_GROUP="hldev"
```

这里需要注意的是，仅仅修改用户的名称和组的名称就可以了。不要修改配置文件中默认的NAME变量，NAME变量还是原来的jenkins不变。接着使用如下命令更改Jenkins相关目录的权限：

```
chown -R hldev:hldev /var/lib/jenkins
chown -R hldev:hldev /var/cache/jenkins
chown -R hldev:hldev /var/log/jenkins
```

使用如下命令重新启动Jenkins即可：

```
sudo /etc/init.d/jenkins restart
sudo service jenkins stop/start
```

Jenkins就会使用hldev用户下`~/.gradle/`目录下已经下载完成的Gradle，而不是默认使用Jenkins下载Gradle，这里下载了十几个小时都没有成功下载，可见几乎没有速度的。



##### 找不到javac文件

在Jenkins中使用Gradle命令编译项目时：

````
/var/lib/jenkins/workspace/credit-system/gradlew -p /var/lib/jenkins/workspace/credit-system/cc-web-boot -x test build --stacktrace
````

提示如下错误：

```
Caused by: java.io.IOException: Cannot run program "/usr/lib/jvm/java-8-openjdk-amd64/bin/javac": error=2, No such file or directory
	at sbt.SimpleProcessBuilder.run(ProcessImpl.scala:349)
	at sbt.AbstractProcessBuilder.run(ProcessImpl.scala:128)
	at sbt.AbstractProcessBuilder$$anonfun$runBuffered$1.apply(ProcessImpl.scala:159)
	at sbt.AbstractProcessBuilder$$anonfun$runBuffered$1.apply(ProcessImpl.scala:159)
```

提示找不到文件`/usr/lib/jvm/java-8-openjdk-amd64/bin/javac`，由于本机Java的Home目录是`/opt/local/jdk8`(可以使用`env`命令进行查看),当然会找不到Java的编译器。但是不知道到底是哪里指定了此目录。修复此问题，在系统的全局配置文件`/etc/profile`中配置Java相关的环境变量：

```
export JAVA_HOME=/opt/local/jdk8
export PATH=$PATH:$SONAR_HOME/bin:$SONAR_SCANNER/bin:$GRADLE_HOME/bin:.$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
```

配置完成后，Jenkins即可成功编译。在没有设置全局环境变量时，使用terminal可以成功编译项目，初步推断在`~/.bash_profile`中设置的环境变量，在终端中生效了，但是作用域未到Jenkins中，将之放到全局环境变量中即修复了此问题。











