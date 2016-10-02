---
title: Hadoop 2.7.1集群部署(不断更新...)
categories: Programming
tags:
  - Cluster
  - Hadoop.HBase
date: 2016-10-01 11:29:09
---


所用软件版本：

* Java 1.8.0\_60

* Hadoop 2.7.1.2.4.3.0-227


HBase集群建立在hadoop集群基础之上，所以在搭建HBase集群之前需要把Hadoop集群搭建起来，并且要考虑二者的兼容性。

下载JDK8u60安装包，输入如下命令进行安装：

```Bash
rpm -ivh jdk-8u60-linux-x64.rpm
```

<!-- more -->

#### 添加环境变量


说到可以将 Hadoop 安装目录加入 PATH 变量中，这样就可以在任意目录中直接使用 hadoo、hdfs 等命令了，如果还没有配置的，需要在 Master 节点上进行配置。首先执行 vim ~/.bashrc，加入一行：

```Bash
export PATH=$PATH:/usr/hdp/2.4.3.0-227/hadoop/bin
```

保存后执行<code>source ~/.bashrc</code>使配置生效。

#### 配置集群/分布式环境

##### core-site.xml

```XML

```

##### hdfs-site.xml

```XML

```

##### mapred-site.xml

```XML

```

##### yarn-site.xml

```XML

```

#### 启动Hadoop

##### 关闭防火墙

```Bash
#CentOS 6.x关闭防火墙服务
service iptables stop
#CentOS 7，需通过如下命令关闭
systemctl stop firewalld.service
```

#### 启动服务(严格按照顺序)

##### 启动Zookeeper服务

ZooKeeper是一个分布式开源框架，提供了协调分布式应用的基本服务，它向外部应用暴露一组通用服务——分布式同步（Distributed Synchronization）、命名服务（Naming Service）、集群维护（Group Maintenance）等，简化分布式应用协调及其管理的难度，提供高性能的分布式服务。ZooKeeper本身可以以Standalone模式安装运行，不过它的长处在于通过分布式ZooKeeper集群（一个Leader，多个Follower），基于一定的策略来保证ZooKeeper集群的稳定性和可用性，从而实现分布式应用的可靠性。如下命令启动Zookeeper服务：

```Bash
./zkServer.sh start
```

查看服务状态：

```Bash
./zkServer.sh status
```

也可以用如下命令查看：

```Bash
jps | grep Quorum
```

The jps command lists the instrumented Java HotSpot VMs on the target system. The command is limited to reporting information on JVMs for which it has the access permissions.如果服务启动失败或者遇到问题，可到相应目录查看启动日志,日志的配置在<code>zookeeper-env.sh</code>文件中。

```Bash
export ZOO_LOG_DIR=/var/log/zookeeper
```

##### 启动Hadoop守护进程

使用如下命令启动NameNode：

```Bash
./hadoop-daemon.sh start namenode
```




##### 启动Hadoop

启动Hadoop集群需要启动HDFS集群和Map/Reduce集群。第一次启动先初始化namenode:

```Bash
#格式化一个新的分布式文件系统
hadoop namenode -format
```

##### 启动HDFS

命令shell脚本在hadoop的sbin目录下。

```Bash
#启动主NameNode、DataNode
./start-dfs.sh
```

##### 启动YARN

为从根本上解决旧MapReduce框架的性能瓶颈，促进Hadoop框架的更长远发展，从0.23.0版本开始，Hadoop的MapReduce框架完全重构，发生了根本的变化。新的Hadoop MapReduce框架命名为MapReduceV2或者叫Yarn(Yet Another Resource Negotiator，另一种资源协调者)。

```Bash
./start-yarn.sh
```

yarn会启动ResourceManager，此处需要注意的是：Namenode和ResourceManger如果不是同一台机器，不能在NameNode上启动 yarn，应该在ResouceManager所在的机器上启动yarn。

#### 查看集群运行状态

查看集群状态验证集群是否已经成功部署。输入<code>jps</code>命令,输出如下所示即代表相应的服务部署OK：

```
3884 Jps
1776 ResourceManager
1613 SecondaryNameNode
1872 NodeManager
1467 DataNode
1377 NameNode
```



参考：

[Hadoop集群安装配置教程]
[Hadoop集群安装配置教程]:http://www.powerxing.com/install-hadoop-cluster/

[Hadoop 2.7.2安装]
[Hadoop 2.7.2安装]:http://www.jianshu.com/p/42cd4590a5cb

[Hadoop新MapReduce框架Yarn详解]
[Hadoop新MapReduce框架Yarn详解]:https://www.ibm.com/developerworks/cn/opensource/os-cn-hadoop-yarn/
