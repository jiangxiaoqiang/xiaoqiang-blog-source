---
title: Raspberry Pi 3 Model B搭建下载服务器
date: 2017-02-19 09:11:52
tags:
- Raspberry
categories: Equipment
---

由于Raspberry功耗很低，Raspberry Pi 3 Model B的功耗只有4W，4W是什么概念呢？假如你的Raspberry 7*24小时一年到头无休止开着，一年也才使用30度多一点的电量(4WX24小时X365天=31.2度)，一度电打算1块钱，开一整年也才30多块钱。由此看来，树莓派是个人可以养的起的服务器，所以可以使用它作为一个下载器。24小时不间断下载，就不用再等待下载完毕了，或者长时间开着电脑。如果回家的时候想看一部电影，那么随时都可以将下载任务放到队列里，下班回家或者有空的时候就可以看电影了。下载可以使用Transmission、Deluge、aMule、Wget、Aria2等工具，它们都是开源跨平台的，不管你是用Windows、Linux、Mac OS X、FreeBSD等。

###  Transmission

#### 安装Transmission

<!-- more -->

输入如下命令安装Transmission后端：

```shell
sudo apt-get update
sudo apt-get install transmission-daemon -y
sudo apt-get install transmission-cli -y
sudo apt-get install transmission-common -y
# 一条命令安装
sudo apt-get install transmission-deamon transmission-cli transmission-common -y
```

常用命令:

```shell
# 查看transmission的运行状态
sudo service transmission-daemon status
# 启动daemon守护进程（推荐）
# 使用此命令启动后可以直接登录Web控制台
sudo service transmission-daemon start 
# 启动transmission守护进程(不推荐)
sudo transmission-daemon
# 重新启动daemon
sudo service transmission-daemon reload 
# 停止daemon
sudo service transmission-daemon stop
# 添加下载任务
sudo transmission-cli torrentfilename.torrent
```

#### 使用Transmission下载

安装完毕后，需要修改配置文件`/etc/transmission-daemon/settings.json`，此处transmission的版本是Transmission 2.84 (14307)。将rpc-whitelist修改为：192.168.1.*，表示在192.168.1.网段的计算机都可以访问，注意如果要在局域网内其他计算机登陆，一定要修改此字段。修改的时候要停止transmission。

```json
"rpc-whitelist": "192.168.1.*"
```

修改完毕后登陆：`http://192.168.1.113:9091`，192.168.1.113为树莓派的IP。进入界面之前会提示输入用户名和密码，首次登陆如果没有修改用户名密码的话，默认的用户名和密码都是transmission。下载界面如下图所示。

{% asset_img web-download-page.png 下载界面 %}

在使用的时候有时会无法进入web界面，此时可以重启transmission守护进程即可,运行如下命令：

```shell
sudo service transmission-daemon stop
sudo service transmission-daemon start
```

### aMule

aMule是一款开源跨平台的文件分享(下载)工具.

#### 安装aMule

```shell
sudo apt-get install amule-daemon amule-utils -y
```

添加用户：

```shell
sudo adduser amule
```

使用命令`amuled(amule deamon)`启动aMule守护进程。 初次启动时提示如下：

```
!2017-03-01 11:55:18: ERROR: aMule daemon cannot be used when external connections are disabled. To enable External Connections, use either a normal aMule, start amuled with the option --ec-config or set the key "AcceptExternalConnections" to 1 in the file ~/.aMule/amule.conf
```

按照提示修改相应值之后，使用如下命令生成remote.conf文件：

```shell
amuleweb --write-config --host=localhost --password=123456 --admin-pass=123456
```

使用如下命令生成密码:

```shell
echo -n yourpasswordhere | md5sum | cut -d ' ' -f 1
```

如果想从网页进入amule，运行命令`nohup amuleweb &`启动amule网页守护进程,如果没有启动amule，输入`nohup amuled &`启动amule守护进程，也可以使用如下命令：

```shell
sudo systemctl start amuled
```

在浏览器中输入地址`http://ip:4711`即可进入。如下图所示：

{% asset_img amuse.png aMule下载页 %}

### Deluge

Deluge是一款开源跨平台的下载工具，支持Windows、Mac OS X、Linux等平台。

#### 安装

```shell
sudo apt-get install deluged -y
sudo apt-get install deluge-console -y
sudo apt-get install deluge-web -y
# 也可以使用如下一条指令搞定
sudo apt-get install deluged deluge-console deluge-web -y
```

待Deluge安装完毕后，输入如下命令启动：

```Bash
# 启动守护进程
deluged
# 启动Web端
deluge-web
# 启动Console端
deluge-console
```

登录地址：`http://192.168.1.113:8112/`即可从Web访问Deluge。


