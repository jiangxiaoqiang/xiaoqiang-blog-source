---
title: Kafka消费position
tags:
  - Kafka
  - consume
categories: Programming
date: 2016-11-02 18:17:19
---


kafka允许通过seek(TopicPartition，long)指定新的位置，或者seekToBeginning，seekToEnd定位到最早或最近的offset。注意seek重置offsets只对当前消费者起作用，它并不会触发consumer的rebalance，或者影响其他消费者的fetchOffsets。在大多数情况下，消费者消费记录只是简单地从一开始到结束，并且定时地提交它的位置(不管是自动的还是手动的)。不过新的API也允许消费者手动控制它的位置，消费者可以在一个partition钟随意地往前或者往后移动位置。这就意味着消费者可以重新消费旧的记录(多次读取相同的记录)，或者直接跳到最近的记录，忽略掉中间的记录。

<!-- more -->

```Java
/*
 * 得到分区
 *
 * @param topics
 * @return void
 * @throws @author Jiangxiaoqiang
 * @Title: initialTopicsPartitions
 */
public void initialTopicsPartitions(String[] topics) {
    if (topics != null && topics.length > 0) {
        for (String topic : topics) {
            if (!Converter.toBlank(topic).equals("")) {
                topicPartitions.add(new TopicPartition(topic, PublicVariable.KAFKA_COMSUME_PARTION));
            }
<<<<<<< HEAD
        }
        //从最新的位置开始消费
        consumer.seekToEnd();
        consumer.assign(topicPartitions);
=======
        }                
        consumer.assign(topicPartitions);
        /*
        从最新的位置开始消费,Special methods for seeking to the earliest and latest offset the server maintains are also available ( seekToBeginning(TopicPartition...) and seekToEnd(TopicPartition...) respectively)
        */
        consumer.seekToEnd();
>>>>>>> 2e811b88860dc244827b13d566fed966b8243aaa
    }
}
```

