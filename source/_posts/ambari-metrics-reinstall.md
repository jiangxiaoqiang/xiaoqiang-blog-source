---
title: Ambari Metrics重装
tags:
  - Ambari
categories: Programming
date: 2016-10-07 15:19:09
---


#### 移除服务

采用Ambari REST API移除相关服务。

```Bash
#停止服务
curl -i -H "X-Requested-By: ambari" -u admin:admin -X PUT -d '{"RequestInfo":{"context":"Stop Service"},"Body":{"ServiceInfo":{"state":"INSTALLED"}}}' http://192.168.24.226:8080/api/v1/clusters/zwlbs/services/AMBARI_METRICS
#查看服务状态
curl -u admin:admin -H "X-Requested-by:ambari" -i -k -X GET http://192.168.24.226:8080/api/v1/clusters/zwlbs/services/AMBARI_METRICS/
#移除服务
curl -u admin:admin -H "X-Requested-By: ambari" -X DELETE http://192.168.24.226:8080/api/v1/clusters/zwlbs/services/AMBARI_METRICS
```

<!-- more -->

cURL是一个命令行工具，通过不同的协议传输数据，1997年首次发布。cURL is a computer software project providing a library and command-line tool for transferring data using various protocols. The cURL project produces two products, libcurl and cURL. It was first released in 1997. The name originally stood for "see URL".curl支持的协议有FTP, FTPS, HTTP, HTTPS, SCP, SFTP, TFTP, TELNET, DICT, LDAP, LDAPS, FILE, POP3, IMAP, SMTP and RTSP at the time of this writing. Wget支持HTTP, HTTPS and FTP三种协议.

#### 移除包

移除各个节点啊上安装的包。

```Bash
#主节点
yum remove ambari-metrics-hadoop-sink-2.2.2.0-460.x86_64 -y
yum remove ambari-metrics-monitor-2.2.2.0-460.x86_64 -y
yum remove ambari-metrics-grafana-2.2.2.0-460.x86_64 -y
yum remove ambari-metrics-collector-2.2.2.0-460.x86_64 -y
#从节点
yum remove ambari-metrics-monitor-2.2.2.0-460.x86_64 -y
yum remove ambari-metrics-hadoop-sink-2.2.2.0-460.x86_64 -y
```

#### 删除文件

删除与Ambari Metrics相关的文件。

```Bash
rm -rf
#Ambari Metrics
/usr/lib/ambari-metrics-grafana
/usr/lib/ambari-metrics-hadoop-sink
/usr/lib/ambari-metrics-kafka-sink
/var/lib/ambari-metrics-collector
/var/lib/ambari-metrics-grafana
/var/run/ambari-metrics-collector
/var/run/ambari-metrics-monitor
/var/run/ambari-metrics-grafana
/var/log/ambari-metrics-collector
/var/log/ambari-metrics-monitor
/var/log/ambari-metrics-grafana
/etc/ambari-metrics-collector
/etc/ambari-metrics-monitor
/etc/ambari-metrics-grafana
```

可将以上代码写入Shell脚本，执行即可。

#### 添加服务

以上步骤完成后，重新到Ambari UI界面添加Ambari Metrics服务即可。如果哪个服务实在无法修复，最无奈的方法，重装此服务。

参考文章：

[Services and State with Ambari REST API]
[Services and State with Ambari REST API]:http://henning.kropponline.de/2015/06/07/services-and-state-with-ambari-rest-api/
