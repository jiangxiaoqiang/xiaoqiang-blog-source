---
title: VirtualBox配置本地yum镜像
tags:
  - VirtualBox
categories: Programming
date: 2017-01-12 11:26:10
---

由于安装的是中标麒麟操作系统，网上的镜像不知是否可用(不知道是否有坑)，所以在本地配置光驱中的软件源为yum镜像。

<!-- more -->

#### 添加ISO

在VirtualBox中添加ISO：

{% asset_img add-iso.png 添加ISO %}

添加完毕镜像后启动虚拟机。

#### 挂载镜像

使用如下命令查看光驱的位置：

```
lsblk
```

创建挂载点：

```Bash
mkdir /mnt/cdrom
```

挂载镜像，将Ubuntu DVD ISO文件挂载到/mnt/cdrom下，使用–o loop参数(这里已经挂载好，所以此步骤省略)：

```Bash
sudo mount -o loop /media/NeoKylin Linux Advanced Server 6.iso /mnt/cdrom
```

在`/etc/yum.repo.d/`目录下新建kylin.repo文件，加入如下内容：

```
[local]
baseurl=file:///media/NeoKylin\ Linux\ Advanced\ Server\ 6
gpgcheck=0
enable=1
```

注意在写有空格的文件夹时，需要添加转义符号\。使用如下命令查看所有源：

```Bash
yum repolist all
```

所有可用源列表如下图所示：

{% asset_img repolist.jpg 查看所有可用源%}

可以看到配置的local源已经enable。