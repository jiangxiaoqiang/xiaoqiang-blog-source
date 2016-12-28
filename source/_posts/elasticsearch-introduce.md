---
title: ElasticSearch入门
date: 2016-12-27 22:38:40
tags:
- ElasticSearch
---


#### 简介

ElasticSearch是一个基于Lucene开发的搜索服务器，具有分布式多用户的能力，ElasticSearch是用Java开发的开源项目，基于Restful Web接口，能够达到实时搜索、稳定、可靠、快速、高性能、安装使用方便，同时它的横向扩展能力非常强，不需要重启服务。ElasticSearch是一个非常好用的实时分布式搜索和分析引擎，可以帮助我们快速的处理大规模数据，也可以用于全文检索，结构化搜索以及分析等。目前很多网站都在使用ElasticSearch进行全文检索，例如：GitHub、StackOverflow、Wiki等。ElasticSearch式建立在全文检索引擎Lucene基础上的，而Lucene是最先进、高效的开元搜索引擎框架，但是Lucene只是一个框架，要充分利用它的功能，需要很高的学习成本，而ElasticSearch使用Lucene作为内部引擎，在其基础上封装了功能强大的Restful API，让开发人员可以在不需要了解背后复杂的逻辑，即可实现比较高效的搜索。

<!-- more -->

##### 倒排索引(Inverted Index)

关系型数据库为了提高查询效率会添加索引，比如MySQL就是B-Tree索引(B+树)，还有文件系统也是采用B+树。搜索引擎的基础数据结构倒排索引(Inverted Index)。在平时，会经常使用各种各样的索引，如根据链接，可以找到链接里的具体文本，这就是索引。反过来，如果，如果我们能根据具体文本，找到文本存在的具体链接，这就是倒排索引，可简单理解为从文本到链接的映射。平时在使用Google、百度时，就是根据具体文本去找链接，这就是以倒排索引为基础的。ElasticSearch也是使用的是倒排索引(Inverted Index)，也是为了提高查询速度。

##### 基本概念

**Gateway**：代表ElasticSearch索引快照的存储方式，ElasticSearch默认是先把索引存放到内存中，当内存满了时再持久化(Persist)到本地硬盘。gateway对索引快照进行存储，当这个ElasticSearch集群关闭再重新启动时就会从gateway中读取索引备份数据。ElasticSearch支持多种类型的gateway，有本地文件系统（默认），分布式文件系统，Hadoop的HDFS和Amazon的s3云存储服务。

#### 安装

输入如下命令下载ElasticSearch：

```Bash
curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.1.1.tar.gz
```

-L参数表示--location，因为有些下载链接有重定向操作，L操作告诉curl如果返回的是重定向30X，那么就直接再次发起请求，请求重定向到的网址。O参数表示output，--remote-name，表示写入到本地磁盘的文件名称和远程文件名称(remote name)一样。下载完毕后，将文件拷贝到需要安装的目录下：

```Bash
mv elasticsearch-5.1.1.tar.gz /opt/local/tools/
```

将文件解压：

```Bash
tar -xzvf elasticsearch-5.1.1.tar.gz
```

启动ElasticSearch:

```Bash
./elasticsearch -d
```

输入如下命令判断是否安装成功：

```Bash
curl http://localhost:9200/?pretty
```

返回内容为：

```
{
  "name" : "eS0_ZDL",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "DU2WJNtbRmOHXF9HFFs5LQ",
  "version" : {
    "number" : "5.1.1",
    "build_hash" : "5395e21",
    "build_date" : "2016-12-06T12:36:15.409Z",
    "build_snapshot" : false,
    "lucene_version" : "6.3.0"
  },
  "tagline" : "You Know, for Search"
}
```

#### 安装插件

##### Head插件

ElasticSearch从版本5+即不支持site plugin(site plugins are not supported). Run elasticsearch-head as a standalone server。安装Grunt：

```Bash
sudo npm install -g grunt-cli
sudo npm install grunt --save-dev
```

Grunt安装完毕后，接着安装elasticsearch-head：

```
git clone git://github.com/mobz/elasticsearch-head.git
cd elasticsearch-head
npm install
grunt server
```

安装完毕后，访问地址：`http://localhost:9100/`。由于有同源策略，暂时还无法连接。

```
XMLHttpRequest cannot load http://localhost:9200/_cluster/state. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://localhost:9100' is therefore not allowed access.
```

在ElasticSearch配置文件中(`/opt/local/tools/elasticsearch-5.1.1/config/elasticsearch.yml`)添加如下配置：

```
http.cors.enabled: true
http.cors.allow-origin: "*"
```

最后成功连接集群，如下图所示：

{% asset_img head-connect-elasticsearch.jpg 连接ElasticSearch集群效果%}

* [Elasticsearch 简介](http://lxwei.github.io/posts/Elasticsearch-%E7%AE%80%E4%BB%8B.html)

* [elasticsearch-the-definitive-guide-clinton-gormley-zachary-tong](http://1.droppdf.com/files/FOeNs/elasticsearch-the-definitive-guide-clinton-gormley-zachary-tong.pdf)
