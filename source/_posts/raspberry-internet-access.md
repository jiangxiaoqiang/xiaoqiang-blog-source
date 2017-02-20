---
title: Raspberry外网访问
date: 2017-02-19 10:04:51
tags:
- Raspberry

---

####  

#### 外网IP





####  Ngrok

Ngrok是非常流行的反向代理服务，可以进行内网穿透，支持80端口以及自定义tcp端口转发。这样即使你的树莓派没有[公网IP](http://zh.raspberrypi.wikia.com/wiki/%E5%85%AC%E7%BD%91IP?redlink=1&action=edit&flow=create-page-article-redlink)也可以使用SSH远程登陆，而且可以把你的网站展示给小伙伴们看。下载Ngrok客户端：

```shell
wget -c https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
```

下载完毕后，解压到当前目录：

```shell
unzip ngrok-stable-linux-arm.zip
```

使用如下 命令登陆：

```shell
./ngrok authtoken 82GD9TQc4gsL9DJbNhNiy_2ojC5oi4BosEYbyFKeRVQ
```



新建tcp端口转发：

```shell
nohup ./ngrok tcp 22 &	
```

新建端口转换后界面会给出提示，使用提示信息登陆即可。为了不使退出shell后自动断开，使用如下命令后台启动：

```shell
setsid ./ngrok tcp 22
```



打开你的SSH客户端，主机名输入tunnel.org.cn，端口号输入54304(根据自己的修改)，是不是可以登陆了！









