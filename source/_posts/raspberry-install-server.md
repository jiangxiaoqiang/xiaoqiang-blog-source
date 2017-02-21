---
title: Raspberry搭建下载服务器
date: 2017-02-19 09:11:52
tags:
- Raspberry

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
```

常用命令:

```shell
# 查看transmission的运行状态
service transmission-daemon status
# 启动daemon
service transmission-daemon start 
# 重新启动daemon
service transmission-daemon reload 
# 停止daemon
service transmission-daemon stop
# 添加下载任务
transmission-cli torrentfilename.torrent
```

#### 使用Transmission下载

安装完毕后，需要修改配置文件`/etc/transmission-daemon/settings.json`，此处transmission的版本是Transmission 2.84 (14307)。将rpc-whitelist修改为：192.168.1.*，表示在192.168.1.网段的计算机都可以访问，注意如果要在局域网内其他计算机登陆，一定要修改此字段。修改的时候要停止transmission。

```json
"rpc-whitelist": "192.168.1.*"
```

修改完毕后登陆：`http://192.168.1.113:9091`，192.168.1.113为树莓派的IP。进入界面之前会提示输入用户名和密码，首次登陆如果没有修改用户名密码的话，默认的用户名和密码都是transmission。下载界面如下图所示。

{% asset_img web-download-page.png 下载界面 %}

### aMule

aMule是一款开源跨平台的文件分享(下载)工具.

#### 安装aMule

```shell
sudo apt-get install amule-daemon amule-utils -y
```

### Deluge

#### 安装

```shell
sudo apt-get install deluged -y
sudo apt-get install deluge-console -y
```





