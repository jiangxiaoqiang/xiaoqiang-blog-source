---
title: Kafka常用操作
tags:
- Kafka
categories: Programming
---

创建主题：

```Bash
./kafka-topics.sh --zookeeper localhost:2181 --create --topic test1 --partitions 1 --replication-factor 1 --config max.message.bytes=64000 --config flush.messages=1
```

查看所有主题：

```Bash
./kafka-topics.sh --list --zookeeper 192.168.24.11:2181
```

删除主题：

```Bash

```
