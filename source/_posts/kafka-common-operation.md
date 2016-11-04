---
title: Kafka常用操作
tags:
  - Kafka
categories: Programming
date: 2016-10-29 17:11:35
---


启动kafka：

```Bash
./kafka-server-start.sh ../config/server.properties &
```

创建主题：

```Bash
./kafka-topics.sh --zookeeper localhost:2181 --create --topic test1 --partitions 1 --replication-factor 1 --config max.message.bytes=64000 --config flush.messages=1
```

查看所有主题：

```Bash
./kafka-topics.sh --list --zookeeper 192.168.24.11:2181
```

<!-- more -->

删除主题：

```Bash
./kafka-topics.sh --zookeeper 192.168.24.244:2181 --delete --topic 0085000
```

消费主题：

```Bash
./kafka-console-consumer.sh --zookeeper localhost:2181 --from-beginning --topic 0085000
```

改变主题L000000的默认分区数：

```Bash
/kafka-topics.sh  --zookeeper 192.168.24.238:2181,192.168.24.11:2181,192.168.24.71:2181 --alter --topic L000000 --partitions 2
```
