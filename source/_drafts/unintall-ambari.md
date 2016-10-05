---
title: 卸载Ambari Server
tags:
- Aabari
categories: Programming
---

停止服务：

```Bash
ambari-server stop
ambari-server reset
ambari-agent stop
yum erase ambari-server
rm -rf /var/lib/ambari-server
rm -rf /var/run/ambari-server
rm -rf /usr/lib/amrbari-server
```


















