---
title: Apache-Ambari 2.2.2.0 Agent手动安装
tags: ambari
categories: Programming
date: 2016-10-02 11:59:53
---

* Apache-Ambari 2.2.2.0

* CentOS 7.0

Ambari是一款用于部署、管理、监控Hadoop集群的开源工具，通过Ambari用户可以更方便地管理大规模Hadoop集群。Ambari架构采用的是Server/Client的模式，主要由两部分组成：ambari-agent和ambari-server。ambari依赖其它已经成熟的工具，例如其ambari-server就依赖python，而ambari-agent还同时依赖ruby, puppet，facter等工具，还有它也依赖一些监控工具nagios和ganglia用于监控集群状况。目前能找到2种，一种是Apache Ambari，一种是Hortonworks Ambari，两者区别不大，这里安装的是Apache Ambari。

<!-- more -->

下载Ambari repository。

```Bash
cd /etc/yum.repos.d/
#(Redhat/CentOS/Oracle) 6:http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.2.2.0/ambari.repo
wget <ambari-repo-url>
```

安装ambari-agent。

```Bash
yum install ambari-agent
```

启动Agent：

```Bash
ambari-agent start
```

至此，Ambari Agent安装完毕。
