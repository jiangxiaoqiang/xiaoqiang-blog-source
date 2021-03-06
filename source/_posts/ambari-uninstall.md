---
title: 卸载HDP和Ambari
tags:
  - Ambari
  - HDP
categories: Programming
date: 2016-10-07 12:35:59
---


#### 移除Ambari服务

依次运行如下命令：

```Bash
rpm -qa | grep ambari
```
<!-- more -->

```Bash
ambari-server stop
ambari-server reset
ambari-agent stop
rpm -qa | grep ambari
#移除Ambari Server安装包
yum erase ambari-server -y
rm -rf /var/lib/ambari-server
rm -rf /var/run/ambari-server
rm -rf /usr/lib/amrbari-server
rm -rf /etc/ambari-server
rm -rf /var/log/ambari-server
rm -rf /usr/lib/python2.6/site-packages/ambari*
```

#### Ambari Agent Cleanup Script

```Bash
python /usr/lib/python2.6/site-packages/ambari_agent/HostCleanup.py -s -k users
```

#### Remove Packages

```Bash
yum erase -y `yum list | grep @HDP-2 | awk '{ print $1 }'`
yum erase -y `yum list | grep 2_3_ | awk '{ print $1}'`
```

#### 移除文件夹(Clean Folders)

移除文件夹(Clean Folders)脚本：

```Bash
rm -rf
# Log dirs
/var/log/ambari-metrics-monitor
/var/log/hadoop
/var/log/hbase
/var/log/hadoop-yarn
/var/log/hadoop-mapreduce
/var/log/hive
/var/log/oozie
/var/log/zookeeper
/var/log/flume
/var/log/hive-hcatalog
/var/log/falcon
/var/log/knox
/var/lib/hive
/var/lib/oozie

# DataNode HDFS dirs
/grid*/hadoop

# Hadoop dirs
/usr/hdp
/usr/bin/hadoop
/tmp/hadoop
/var/hadoop
/hadoop/*
/local/opt/hadoop

# Config dirs
/etc/hadoop
/etc/hbase
/etc/oozie
/etc/phoenix
/etc/hive
/etc/zookeeper
/etc/flume
/etc/hive-hcatalog
/etc/tez
/etc/falcon
/etc/knox
/etc/hive-webhcat
/etc/mahout
/etc/pig
/etc/hadoop-httpfs

# PIDs
/var/run/hadoop
/var/run/hbase
/var/run/hadoop-yarn
/var/run/hadoop-mapreduce
/var/run/hive
/var/run/oozie
/var/run/zookeeper
/var/run/flume
/var/run/hive-hcatalog
/var/run/falcon
/var/run/webhcat
/var/run/knox

# ZK db files
/local/home/zookeeper/*

# libs
/usr/lib/flume
/usr/lib/storm
/var/lib/hadoop-hdfs
/var/lib/hadoop-yarn
/var/lib/hadoop-mapreduce
/var/lib/flume
/var/lib/knox

#Ambari Metrics
/usr/lib/ambari-metrics-grafana
/usr/lib/ambari-metrics-hadoop-sink
/usr/lib/ambari-metrics-kafka-sink
/var/lib/ambari-metrics-collector
/var/lib/ambari-metrics-grafana
/var/run/ambari-metrics-collector
/var/run/ambari-metrics-monitor
/var/run/ambari-metrics-grafana
/var/log/ambari-metrics-collector
/var/log/ambari-metrics-monitor
/var/log/ambari-metrics-grafana
/etc/ambari-metrics-collector
/etc/ambari-metrics-monitor
/etc/ambari-metrics-grafana

# other
/var/tmp/oozie
```

#### Clean Repository

```Bash
yum clean all
```

在重装之前一定要移除干净。

各个服务的目录位置如下:

```
/etc/<service_name>
/usr/lib/<service_name>
/var/lib/<service_name>
/var/log/<service_name>
/var/run/<service_name>
/var/tmp/<service_name>
/tmp/<service_name>
```


参考资料来自：

[Uninstalling and Cleaning a HDP Node]
[Uninstalling and Cleaning a HDP Node]:http://henning.kropponline.de/2016/04/24/uninstalling-and-cleaning-a-hdp-node/
