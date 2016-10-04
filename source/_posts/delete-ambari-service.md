---
title: 删除Apache Ambari服务
tags: Ambari
categories: Programming
date: 2016-10-04 21:04:27
---


删除删除Apache Ambari服务可调用Apache Ambari REST接口：

```Bash
#移除ZooKeeper服务
curl -u admin:admin -H "X-Requested-By: ambari" -X DELETE http://192.168.24.226:8080/api/v1/clusters/zwlbs/services/ZooKeeper

#移除MapReduce服务
curl -u admin:admin -H "X-Requested-By: ambari" -X DELETE http://192.168.24.226:8080/api/v1/clusters/zwlbs/services/ZooKeeper/MAPREDUCE2
```

<!-- more -->

注意服务的名称要大写。有时删除服务时会提示如下：

```
{
  "status" : 500,
  "message" : "org.apache.ambari.server.controller.spi.SystemException: An internal system exception occurred: Cannot remove ZOOKEEPER. Desired state STARTED is not removable.  Service must be stopped or disabled."
}
```

此时可以先改变服务状态再执行删除命令。改变服务状态命令为：

```Bash
curl -i -H "X-Requested-By: ambari" -u admin:admin -X PUT -d '{"RequestInfo":{"context":"Stop Service"},"Body":{"ServiceInfo":{"state":"INSTALLED"}}}' http://192.168.24.226:8080/api/v1/clusters/CLUSTER_NAME/services/SERVICE_NAME
```