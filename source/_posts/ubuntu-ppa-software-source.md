---
title: Ubuntu PPA软件源
date: 2017-02-09 14:01:28
tags:
- Ubuntu
- PPA
categories: OS
---



#### PPA含义

虽然Ubuntu官方软件仓库包含了许多开源和非开源软件，但仍有很多软件包由于各种原因不能进入官方软件仓库。为了方便Ubuntu用户使用，launchpad提供了个人软件包集，即PPA(Personal Package Archives)，允许用户建立自己的软件仓库，通过Launchpad进行编译并发布为二进制软件包，作为apt源供其他用户下载和更新。PPA也被用来对一些打算进入Ubuntu官方仓库的软件，或者某些软件的新版本进行测试。

<!-- more -->

>[Launchpad](https://launchpad.net/)是Ubuntu母公司canonical有限公司所架设的网站，是一个提供维护、支援或联络Ubuntu开发者的平台。



#### PPA使用

使用如下命令，添加Redis Server源：

```shell
sudo add-apt-repository ppa:tsuru/redis-server
```

其中tsuru是用户名称，redis-server是PPA的名称。执行此命令后，会在Ubuntu的`/etc/apt/sources.list.d`目录下生成文件tsuru-ubuntu-redis-server-xenial.list。相当于在/etc/source.list中直接添加以下地址： 

```shell
deb http://ppa.launchpad.net/tsuru/redis-server/ubuntu trusty main 
deb-src http://ppa.launchpad.net/tsuru/redis-server/ubuntu trusty main
```

注：add-apt-repository 依赖 python-software-properties 这个工具包，如果出现“command not found”可以尝试使用以下命令安装它。 

```shell
apt-get install python-software-properties
```
移除PPA源使用如下命令：

```shell
sudo add-apt-repository -r ppa:tsuru/redis-server
```

