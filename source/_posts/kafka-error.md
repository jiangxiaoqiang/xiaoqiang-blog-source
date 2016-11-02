---
title: Kafka常见错误
tags:
  - Kafka
categories: Programming
date: 2016-10-28 17:06:23
---


#### Invalid partition given with record

在Kafka生产者里写入消息时，提示写入失败，详细的错误信息如下所示：

```
[ERROR]-[2016年-10月-28日16:17:35.083]-[Thread-25]-[com.zw.socket.service.kafka.producer.ClientKafkaProducer]-{生产者发送消息出错}java.lang.IllegalArgumentException: Invalid partition given with record: 1 is not in the range [0...1].
	at org.apache.kafka.clients.producer.KafkaProducer.partition(KafkaProducer.java:671) ~[kafka-clients-0.9.0.1.jar:?]
	at org.apache.kafka.clients.producer.KafkaProducer.send(KafkaProducer.java:430) ~[kafka-clients-0.9.0.1.jar:?]
	at org.apache.kafka.clients.producer.KafkaProducer.send(KafkaProducer.java:339) ~[kafka-clients-0.9.0.1.jar:?]
	at com.zw.socket.service.kafka.producer.ClientKafkaProducer.sendMessage(ClientKafkaProducer.java:102) [classes/:?]
	at com.zw.socket.service.handler.common.CommonCommandHandler.commonMessageWriteIntoKafka(CommonCommandHandler.java:95) [classes/:?]
	at com.zw.socket.service.handler.device.DeviceMessageHandler.sendRegisterResult(DeviceMessageHandler.java:175) [classes/:?]
	at com.zw.socket.service.handler.device.DeviceMessageHandler.isAllowRegisted(DeviceMessageHandler.java:161) [classes/:?]
	at com.zw.socket.service.handler.device.DeviceMessageHandler.saveDeviceInfo(DeviceMessageHandler.java:216) [classes/:?]
```

<!-- more -->

在Kafka的配置文件中，修改Kafka每个topic的默认分区数的配置：

```Bash
#每个topic的分区个数，更多的partition会产生更多的segment file
num.partitions=2
```

#### The group coordinator is not available

```
2016-10-29 14:52:56.387 INFO [nioEventLoopGroup-3-1][org.apache.kafka.common.utils.AppInfoParser$AppInfo:82] - Kafka version : 0.9.0.1
2016-10-29 14:52:56.387 INFO [nioEventLoopGroup-3-1][org.apache.kafka.common.utils.AppInfoParser$AppInfo:83] - Kafka commitId : 23c69d62a0cabf06
2016-10-29 14:52:56.409 ERROR [nioEventLoopGroup-3-1][org.apache.kafka.clients.consumer.internals.ConsumerCoordinator$DefaultOffsetCommitCallback:489] - Offset commit failed.
org.apache.kafka.common.errors.GroupCoordinatorNotAvailableException: The group coordinator is not available.
2016-10-29 14:52:56.519 WARN [kafka-producer-network-thread | producer-1][org.apache.kafka.clients.NetworkClient$DefaultMetadataUpdater:582] - Error while fetching metadata with correlation id 0 : {0085000=LEADER_NOT_AVAILABLE}
2016-10-29 14:52:56.612 WARN [pool-6-thread-1][org.apache.kafka.clients.NetworkClient$DefaultMetadataUpdater:582] - Error while fetching metadata with correlation id 1 : {0085000=LEADER_NOT_AVAILABLE}
```

产生问题具体原因不详，可能是修改了默认分区导致的，解决方法：停止Kafka Broker，登录ZooKeeper客户端，删除所有主题即可。

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

#### 无法往集群中写入数据

检查部署服务器节点，也就是写入节点的`/etc/hosts`配置文件中是否有IP和主机名的映射。

```
vim /etc/hosts
```

配置如下：

```
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.24.136 节点1主机名
192.168.24.137 节点2主机名
192.168.24.244 localhost
```
