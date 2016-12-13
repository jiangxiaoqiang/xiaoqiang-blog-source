---
title: Redis集群(Redis Cluster)
date: 2016-12-13 22:07:16
tags:
- Redis
- Cluster
categories: Programming
---

在非官方集群解决方案中，物理上把数据“分片”（sharding）存储在多个Redis实例，一般情况下，每一“片”是一个Redis实例。

<!-- more -->

#### 客户端分片

#### 代理分片

##### Twemproxy

Twemproxy是一种代理分片机制，由Twitter开源。Twemproxy作为代理，可接受来自多个程序的访问，按照路由规则，转发给后台的各个Redis服务器，再原路返回。

这个方案顺理成章地解决了单个Redis实例承载能力的问题。当然，Twemproxy本身也是单点，需要用Keepalived做高可用方案。

我想很多人都应该感谢Twemproxy，这么些年来，应用范围最广、稳定性最高、最久经考验的分布式中间件，应该就是它了。只是，他还有诸多不方便之处。

Twemproxy最大的痛点在于，无法平滑地扩容/缩容。

这样导致运维同学非常痛苦：业务量突增，需增加Redis服务器；业务量萎缩，需要减少Redis服务器。但对Twemproxy而言，基本上都很难操作（那是一种锥心的、纠结的痛……）。

或者说，Twemproxy更加像服务器端静态sharding。有时为了规避业务量突增导致的扩容需求，甚至被迫新开一个基于Twemproxy的Redis集群。

Twemproxy另一个痛点是，运维不友好，甚至没有控制面板。

#### Redis Cluster

#### Codis Cluster

参考资料：

[高效运维最佳实践（03）：Redis集群技术及Codis实践](http://www.infoq.com/cn/articles/effective-ops-part-03)
