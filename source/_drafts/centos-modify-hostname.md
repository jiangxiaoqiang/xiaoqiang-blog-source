---
title: CentOS修改主机名
tags: [CentOS,hostname]
categories: Programming
---

#### 获取方式

如果/etc/sysconfig/network存在，执行此文件，如果里面有HOSTNAME的内容，则会设置HOSTNAME，如果hostname为空，则将HOSTNAME赋值localhost

分析脚本中第二段代码：

如果hostname为localhost，则通过ip addr获取ip地址，通过ipcalc获得主机名并赋值HOSTNAME


要永久修改主机名，你可以修改静态主机名：

```Bash
hostnamectl --static set-hostname dolphin
```

输入命令<code>hostnamectl</code>查看静态主机名已经修改。

#### 修改FQDN

FQDN是Fully Qualified Domain Name的缩写, 含义是完整的域名. 例如, 一台机器主机名(hostname)是www, 域后缀(domain)是jiangxiaoqiang.com, 那么该主机的FQDN应该是www.jiangxiaoqiang.com.


