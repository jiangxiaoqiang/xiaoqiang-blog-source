---
title: Ansible使用总结
date: 2017-03-23 16:05:49
tags:
- Ansible
categories: Tool
---

Ansible是一款自动化运维工具，基于Python开发，由Paramiko(python的一个可并发连接ssh主机功能库), PyYAML和Jinja2(模板化)三个关键模块实现。

<!-- more -->

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

#### 模块

* command模块，该模块通过-a跟上要执行的命令可以直接执行，不过命令里如果有带有如下字符部分则执行不成功 “ so variables like $HOME and operations like "<", ">", "|", and "&" will not work (use the shell module if you need these features).”；
* shell 模块，用法其本和command一样，不过的是其是通过/bin/sh进行执行，所以shell 模块可以执行任何命令，就像在本机执行一样，“ It is almost exactly like the command module but runs the command through a shell (/bin/sh) on the remote node.”；
* raw模块，用法和shell 模块一样 ，其也可以执行任意命令，就像在本机执行一样，“Executes a low-down and dirty SSH command, not going through the module subsystem. There is no change handler support for this module. This module does not require python on the remote system”
* script模块，其是将管理端的shell 在被管理主机上执行，其原理是先将shell 复制到远程主机，再在远程主机上执行，原理类似于raw模块，“This module does not require python on the remote system, much like the raw module.” 。

#### Playbook

playbook就是把在命令行的操作，以yml格式写在文件中来执行而已。复杂的playbook只是更多的命令行操作的集合。

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

Ansible下的Host文件添加主机配置，包括主机的IP、使用的端口配置、登录的用户名等。

##### is not file or directory

在Ansibel中不能直接使用command模块执行cd命令，command模块中改变目录需要使用chdir命令：


