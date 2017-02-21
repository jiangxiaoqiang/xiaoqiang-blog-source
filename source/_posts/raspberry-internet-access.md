---
title: Raspberry外网访问
date: 2017-02-19 10:04:51
tags:
- Raspberry

---

####  外网IP

如果固定有外网IP，直接暴露22端口即可。

<!-- more -->

#### 端口转发

如果没有外网固定IP，有DHCP获取的IP，也好办。在路由器上配置端口转发即可。一般家庭接入运营商获取的就是这样的IP。缺点是重启路由或者网络断开之后IP会改变，此时链接Raspberry的IP也要作相应的调整。不过一般情况下变化的频率不是很大，问题不大。

####  Ngrok

如果没有外网IP，也没有DHCP获取的外网IP，Ngrok是非常流行的反向代理服务，可以进行内网穿透，支持80端口以及自定义tcp端口转发。这样即使你的树莓派没有[公网IP](http://zh.raspberrypi.wikia.com/wiki/%E5%85%AC%E7%BD%91IP?redlink=1&action=edit&flow=create-page-article-redlink)也可以使用SSH远程登陆，而且可以把你的网站展示给小伙伴们看。下载Ngrok客户端：

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

setsid命令即使关闭终端，程序也能够后台运行。当用户注销（logout）或者网络断开时，终端会收到 HUP（hangup）信号从而关闭其所有子进程。nohup 的使用是十分方便的，只需在要处理的命令前加上 nohup 即可，标准输出和标准错误缺省会被重定向到 nohup.out 文件中。一般我们可在结尾加上"&"来将命令同时放入后台运行，也可">*filename* 2>&1"来更改缺省的重定向文件名。如果进程不属于接受 HUP 信号的终端的子进程，那么自然也就不会受到 HUP 信号的影响了。setsid 就能帮助我们做到这一点。内核会给每个进程关联两个和进程ID无关的用户ID，一个是真实用户ID，还有一个是有效用户ID或者称为setuid（set user ID）。真实用户ID用于标识由谁为正在运行的进程负责。有效用户ID用于为新创建的文件分配所有权、检查文件访问许可，还用于通过kill系统调用向其 它进程发送信号时的许可检查。内核允许一个进程以调用exec一个setuid程序或者显式执行setuid系统调用的方式改变它的有效用户ID。 fork只是使得进程可以以后台方式运行，但不能使进程完全独立，因为fork出来的进程仍然继承了父进程已打开的终端、会话和进程组。

登录Ngrok，在Dashboard的Status的Tab上即可以看到链接信息。但是**使用Ngrok有一个致命的缺点是极不稳定,偶尔可以链接，非常容易连接不上，基本没有达到基础的可用级别。**不是一个可靠的解决方案。Ngrok可以付费使用，估计这也是免费不稳定的缘由之一，先让你尝试是可以的，稳定使用是需要费用的。毕竟服务器资源的开销也是一笔不菲的费用。

#### frpc

[frpc](http://getfrp.yzxx-soft.com/index.html)内网穿透工具，支持Windows、Mac OS X和Linux。启动frpc：

```shell
./frpc -c ./frpc.ini
```











