---
title: Fedora上MySQL安装
tags:
  - Fedora
  - MySQL
categories: Programming
date: 2016-12-02 17:31:29
---


```Bash
## Fedora 24 ##
dnf install https://dev.mysql.com/get/mysql57-community-release-fc24-8.noarch.rpm
```

<!-- more -->

安装MySQL。

```Bash
dnf install -y mysql-community-server
```

启动MySQL。

```Bash
systemctl start mysqld.service ## use restart after update

systemctl enable mysqld.service
```

登陆时会提示如下错误：ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)获取随机密码。

```Bash
grep 'A temporary password is generated for root@localhost' /var/log/mysqld.log |tail -1
```

重新设置MySQL密码,密码要求包含大小写和数字以及特殊字符，不符合安全策略的(Your password does not satisfy the current policy requirements)密码无法设置成功。

```Bash
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$jxqMySQL123456');
```

#### 數據庫操作

創建數據庫。

```Bash
#列出數據庫
show databases;
#創建數據庫
create database dolphin;
```
