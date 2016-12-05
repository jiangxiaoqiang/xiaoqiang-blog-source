---
title: 迁移解析服务
tags:
- migration
categories: Programming
date: 2016-11-16 14:58:30
---


迁移解析服务是将服务在不同主机上部署。

#### 启动服务

在解析服务器上，使用如下命令启动Tomcat:

```Bash
cd /opt/tomcat/bin
./catalina.sh start
```
<!-- more -->

查看输出日志，检查服务是否正常启动：

```Bash
cd /opt/tomcat/logs
tail -f catalina.out
```

#### 配置映射主机

使用如下命令打开hosts文件：

```Bash
vim /etc/hosts
```

添加主机映射。

```
192.168.24.195 hostname1
192.168.24.226 hostname2
```

添加主机映射之后，从新启动解析服务即可，不必重新启动计算机。

#### 验证迁移

部署完毕后一定要验证，因为在解析服务器上日志打印OK并不代表数据成功写入Kafka集群中，所以验证最后验证迁移是否成功，在Kafka服务器中，切换到Kafka的目录：

```Bash
cd /usr/hdp/2.4.3.0-227/kafka/bin
```

使用如下命令查看迁移是否成功：

```Bash
./kafka-console-consumer.sh --zookeeper localhost:2181 --topic 0720688
```

其中，0720688是需要消费的主题。启动解析服务后，将解析服务Tomcat日志中写入的主题拷贝进命令行中启动消费者，**如果能够成功消费到数据**，代表迁移成功。否则，迁移失败。
