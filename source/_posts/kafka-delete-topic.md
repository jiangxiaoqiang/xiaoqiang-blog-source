---
title: Kafka彻底删除主题
tags:
  - Kafka
categories: Programming
date: 2016-10-29 14:24:15
---


这里的Kafka的版本是0.9.0.1，查看所有Topics和分区：

```Bash
./kafka-topics.sh --describe --zookeeper 192.168.244.11:2181
```

删除主题：

```Bash
./kafka-topics.sh --zookeeper 192.168.24.244:2181 --delete --topic 0085000
```

<!-- more -->

删除主题并不是真正的删除，仅仅是标记为删除(marked for deletion)，如果想彻底删除主题，可以修改kafka的配置：

```Bash
delete.topic.enable=true
```

删除Kafka存储目录(server.properties文件log.dirs配置，默认为"/tmp/kafka-logs")相关topic目录。配置了<code>delete.topic.enable=true</code>直接通过命令删除，如果命令删除不掉，直接通过zookeeper-client删除掉broker下的topic即可。登录ZooKeeper客户端：

```Bash
#切换到ZooKeeper目录
cd /usr/hdp/2.4.3.0-227/zookeeper/bin

#登录ZooKeeper客户端
./zookeeper-client

#找到topic所在的目录
ls /brokers/topics

#彻底删除topic
rmr /brokers/topics/0085000
```

如果不知道ZooKeeper客户端的目录，可以通过如下命令找到。

```Bash
find / -name zookeeper-client
```
