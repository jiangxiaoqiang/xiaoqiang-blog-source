---
title: elasticsearch入门
date: 2016-12-27 22:38:40
tags:
- ElasticSearch
---


#### 简介

ElasticSearch是一个基于Lucene开发的搜索服务器，具有分布式多用户的能力，ElasticSearch是用Java开发的开源项目，基于Restful Web接口，能够达到实时搜索、稳定、可靠、快速、高性能、安装使用方便，同时它的横向扩展能力非常强，不需要重启服务。ElasticSearch是一个非常好用的实时分布式搜索和分析引擎，可以帮助我们快速的处理大规模数据，也可以用于全文检索，结构化搜索以及分析等。目前很多网站都在使用ElasticSearch进行全文检索，例如：GitHub、StackOverflow、Wiki等。ElasticSearch式建立在全文检索引擎Lucene基础上的，而Lucene是最先进、高效的开元搜索引擎框架，但是Lucene只是一个框架，要充分利用它的功能，需要很高的学习成本，而ElasticSearch使用Lucene作为内部引擎，在其基础上封装了功能强大的Restful API，让开发人员可以在不需要了解背后复杂的逻辑，即可实现比较高效的搜索。

<!-- more -->

##### 倒排索引(Inverted Index)

搜索引擎的基础数据结构倒排索引。在平时，会经常使用各种各样的索引，如根据链接，可以找到链接里的具体文本，这就是索引。反过来，如果，如果我们能根据具体文本，找到文本存在的具体链接，这就是倒排索引，可简单理解为从文本到链接的映射。平时在使用Google、百度时，就是根据具体文本去找链接，这就是以倒排索引为基础的。

##### 基本概念

**Gateway**：代表ElasticSearch索引快照的存储方式，ElasticSearch默认是先把索引存放到内存中，当内存满了时再持久化(Persist)到本地硬盘。gateway对索引快照进行存储，当这个ElasticSearch集群关闭再重新启动时就会从gateway中读取索引备份数据。ElasticSearch支持多种类型的gateway，有本地文件系统（默认），分布式文件系统，Hadoop的HDFS和Amazon的s3云存储服务。

#### 安装




* [Elasticsearch 简介](http://lxwei.github.io/posts/Elasticsearch-%E7%AE%80%E4%BB%8B.html)
