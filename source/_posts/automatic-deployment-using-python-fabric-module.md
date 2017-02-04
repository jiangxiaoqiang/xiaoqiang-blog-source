---
title: 使用Python fabric模块自动部署
date: 2017-02-04 12:01:27
tags:
- Python
- Fabric
categories: Programming
---

#### Fabric简介

Fabric是一个Python库，为应用程序的自动部署，无缝集成了SSH。Fabric is a Python (2.5-2.7) library and command-line tool for streamlining the use of SSH for application deployment or systems administration tasks.It provides a basic suite of operations for executing local or remote shell commands (normally or via sudo) and uploading/downloading files, as well as auxiliary functionality such as prompting the running user for input, or aborting execution.

<!-- more -->

#### 安装Fabric

使用如下命令安装fabric：

```Bash
sudo pip install fabric
```

#### 使用Fabric

##### Fabric常用接口

在使用Fabric之前，有必要了解Fabric常用接口：

```
run (fabric.operations.run)
sudo (fabric.operations.sudo)
local (fabric.operations.local)
get (fabric.operations.get)
put (fabric.operations.put)
prompt (fabric.operations.prompt)
reboot (fabric.operations.reboot)
```

如下是一段简单的Python部署示例脚本：

```Python
from fabric.api import *
from fabric.contrib.files import exists

BASE_PATH = '/home/app'
APP_PATH = BASE_PATH + '/backend/credit-system'
APP_NAME = 'example.jar(部署的jar、war包名称)'
JAR_PATH = 'cc-web-boot/build/libs/' + APP_NAME
PROPERTIES_FILE = '/home/hl/devops/jenkins-local/backend/credit-system/application-jenkins.properties'

HOSTS = ['username@hostname']
env.password='主机的SSH密码'

def scripts():
    local('pwd')
    if not exists(APP_PATH):
        run('mkdir -p ' + APP_PATH)
    if exists(APP_PATH + '/app.pid'):
        with settings(warn_only=True):
            run('kill -9 $(cat ' + APP_PATH + '/app.pid)')
    with settings(warn_only=True):
        run('rm -Rf ' + APP_PATH + '/*.*')
    put(JAR_PATH, APP_PATH)
    put(PROPERTIES_FILE, APP_PATH)
    with cd(APP_PATH):
        run('$(nohup java -jar -Xmx2g ' + APP_NAME + ' --spring.config.location=application-jenkins.properties >& /dev/null < /dev/null &) && sleep 1')

def deploy(hosts):
    execute(scripts, hosts=hosts)

if __name__=="__main__":
    deploy(HOSTS)
```

脚本编辑完成后，只需要在Jenkins中执行即可自动化部署：

```Bash
python /home/hl/devops/jenkins-local/backend/credit-system/deploy.py
```