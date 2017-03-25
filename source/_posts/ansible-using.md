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

#### Playbook

 ```shell
 #
# 自动化部署Playback脚本
#
---
- hosts: webservers # hosts中指定
remote_user: root
tasks:
  - name: copy depoloy file
    copy: src=~/file dist=~/file # 从本机拷贝到远程
  - name: back up site
    shell: 'mv /opt/app/frontend/dist /opt/app/frontend/dist-bak'
  - name: back up tar
    shell: 'mv /opt/app/frontend/dist.tar.gz /opt/app/frontend/dist.tar.gz.bak'
 ```  

hosts后面根据local是从hosts中读取的，tasks是是关键词，指明了要执行哪些任务；下面的name是任务的名称，shell是前面提到的module(模块)，单引号中是命令。

#### 常见问题

##### Unreachable




