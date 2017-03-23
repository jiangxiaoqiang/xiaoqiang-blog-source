---
title: Ansible使用总结
date: 2017-03-23 16:05:49
tags:
- Ansible
categories: Tool
---

#### Ansible配置

Ansible的配置文件在目录`/etc/ansible/`目录下。配置key：

```shell
private_key_file=/home/hldev/.ssh/id_rsa.pub
```

Ansible的主机定义在hosts文件中。

```shell
[webservers]
192.168.1.112 ansible_ssh_port=22 ansible_ssh_user=root
```

使用如下命令测试：

```shell
ansible webservers -vvv -m command -a date
```


#### 常见问题

##### Unreachable




