---
title: elasticsearch-using
tags:
---

#### 什么是索引(Index)

索引只是一个用来指向一个或多个分片(shards)的“逻辑命名空间(logical namespace)”.一个分片(shard)是一个最小级别“工作单元(worker unit)”,它只是保存了索引中所有数据的一部分。分片就是一个Lucene实例，并且它本身就是一个完整的搜索引擎。我们的文档存储在分片中，并且在分片中被索引，但是我们的应用程序不会直接与它们通信，取而代之的是，直接与索引通信。当索引创建完成的时候，主分片的数量就固定了，但是复制分片的数量可以随时调整。Cluster包含多个node，Indices不应该理解成动词索引，Indices可理解成关系数据库中的databases，Indices可包含多个Index，Index对应关系数据库中的database，它是用来存储相关文档的。Elasticsearch与关系数据的类比对应关系可以做如下理解：

```
Relational DB ⇒ Databases ⇒ Tables ⇒ Rows ⇒ Columns

Elasticsearch ⇒ Indices ⇒ Types ⇒ Documents ⇒ Fields
```

#### 什么是分片(Shard)

分片(Shard)是Elasticsearch在集群中分发数据的关键。文档存储在分片中，然后分片分配到集群中的节点上。当集群扩容或缩小，lasticsearch将会自动在你的节点间迁移分片，以使集群保持平衡。分片可以是主分片(primary shard)或者是复制分片(replica shard)。索引中的每个文档属于一个单独的主分片，所以主分片的数量决定了索引最多能存储多少数据。理论上主分片能存储的数据大小是没有限制的，限制取决于你实际的使用情况。分片的最大容量完全取决于你的使用状况：硬件存储的大小、文档的大小和复杂度、如何索引和查询你的文档，以及你期望的响应时间。复制分片只是主分片的一个副本，它可以防止硬件故障导致的数据丢失，同时可以提供读请求，比如搜索或者从别的shard取回文档。

#### 创建索引(Index)


参考资料：

* [在ElasticSearch中，集群(Cluster),节点(Node),分片(Shard),Indices(索引),replicas(备份)之间是什么关系？](https://www.zhihu.com/question/26446020)