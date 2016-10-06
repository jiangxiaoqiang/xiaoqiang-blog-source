---
title: Ambari与HDP离线安装
tags:
  - Ambari
  - HDP
categories: Programming
date: 2016-10-05 16:52:34
---

Ambari安装包大概有400MB，HDP所包含的所有的服务(HDFS/ZooKeeper/Kafka/Flume)大概在7GB+，采用yum安装时速度在10KB以内，简直是让人绝望的速度。所以采用离线安装，为了速度，掏出无耻的迅雷(wget下载是假的，不过可以试一试，速度不理想换迅雷)，搭建本地YUM服务。

#### 下载包

如果不知道应该下载哪个版本，可以到Repository的配置文件中查看当前版本。路径为：<code>/etc/yum.repo.d/</code>，查看文件ambari.repo、HDP.rep和HDP-UTILS.repo即可。

<!-- more -->

```Bash
#下载HDP-UTILS包
wget http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos7/HDP-UTILS-1.1.0.20-centos7.tar.gz

#下载HDP包
wget http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.4.3.0/HDP-2.4.3.0-centos7-rpm.tar.gz
```

HDP-UTILS-1.1.0.20-centos6.tar.gz包有600多MB，HDP-2.4.3.0-centos6-rpm.tar.gz包有9GB之巨。包含很多服务，瞬间理解安装的时候超时是怎么回事了。下载完毕之后将包Copy到服务器上：

```Bash
scp HDP-UTILS-1.1.0.20-centos6.tar.gzip root@192.168.24.226:/data/source
scp ambari-2.2.2.0-centos7.tar.gz root@192.168.24.226:/data/source
```

#### 解压

```Bash
tar -xvf HDP-UTILS-1.1.0.20-centos6.tar.gzip -C /data/source/
```

切换到目录(/data/source)下,使用Python搭建一个简单的服务器：

```Bash
python -mSimpleHTTPServer &
```

解压之后，会有HDP，HDP-UTILS-1.1.0.20的目录生成。HDP目录：包含Hadoop的生态圈的组件，比如hdfs，hive，hbase，mahout等。HDP-UTILS-1.1.0.17目录：包含HDP平台所包含的工具组件等，比如nagios，ganglia，puppet等。

#### 修改Repo

切换到Repository配置目录下，编辑文件ambari.repo，将源地址修改为本地地址，yum将从本地地址下载安装包进行安装。

```
#VERSION_NUMBER=2.2.2.0-460

[Updates-ambari-2.2.2.0]
name=ambari-2.2.2.0 - Updates
baseurl=http://192.168.24.226:8000/AMBARI-2.2.2.0/centos7/2.2.2.0-460/
gpgcheck=1
gpgkey=http://192.168.24.226:8000/AMBARI-2.2.2.0/centos7/2.2.2.0-460/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins
enabled=1
priority=1
```

#### 安装Ambari Server

```Bash
#安装Ambari Server
yum install ambari-server -y
#启动Ambari Server
ambari-server start
```

下载速度40MB/s，与6.7KB/s的速度对比，幸福感油然而生。

#### 配置Ambari Server

输入如下命令配置Ambari Server：

```Bash
ambari-server setup
```

数据库这里使用默认的内嵌数据库PostgreSQL。

#### 启动Ambari


```Bash
#启动Ambari Server
ambari-server start
```

注：

**etc目录解释**：Host-specific system-wide configuration files There has been controversy over the meaning of the name itself. In early versions of the UNIX Implementation Document from Bell labs, /etc is referred to as the etcetera(n. 等等；附加物；附加的人；以及其它) directory, as this directory historically held everything that did not belong elsewhere (however, the FHS restricts /etc to static configuration files and may not contain binaries). Since the publication of early documentation, the directory name has been re-designated in various ways. Recent interpretations include backronyms such as "Editable Text Configuration" or "Extended Tool Chest".
