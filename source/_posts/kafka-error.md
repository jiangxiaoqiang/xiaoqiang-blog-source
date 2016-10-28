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

