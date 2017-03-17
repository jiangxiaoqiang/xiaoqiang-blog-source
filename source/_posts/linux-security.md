---
title: Linux安全
date: 2017-03-15 22:21:31
tags:
- Linux
categories: Security
---

Linux安全写基本书都写不完，这里是平时学习和研究Linux安全相关的总结。记录在此。

<!-- more -->

#### SSH

#### 不使用密码登录

使用密码登录都会遭受攻击，攻击者可以做密码猜测，密码穷举，人的记忆有一个缺点就是很难记住随机字符，一般都是有规律可循，而这恰恰是一个安全的弱点，所以首先需要避免。禁用SSH密码登录，强制使用RSA/DSA验证。

```
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile %h/.ssh/authorized_keys
PasswordAuthentication no
```

#### fail2ban

防止暴力攻击，会自动激活iptables规则以阻止SSH到机器重复尝试。 









