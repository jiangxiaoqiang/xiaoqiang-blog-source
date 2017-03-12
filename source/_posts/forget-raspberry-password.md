---
title: 忘记了树莓派的密码
date: 2017-03-10 22:22:24
tags:
- Raspberry
Categories: Security
---



晚上想登录树莓派，但是怎么输入密码后怎么也登录不上去，提示密码错误。看来年纪确实大了，感觉确实老了，好些东西都记不住了。

<!-- more -->

虽然可以取出SD卡修改内容达到重置密码的目的。但是同时觉得这是一个不错的机会，可以试试字典破解ssh啊。那就立即开始动手了，只依稀记得密码应该是：

```
$myraspberrypi123
```

但是提示无法登录，很是郁闷。接下来，手动生成了一个字典。

```
123456
raspberry
$myraspberrypi123
$myraspberrypi123456
$myraspberrypi
$raspberrypi123
myraspberrypi123
$myraspberry123
$raspberrypi123456
$raspberrypi
raspberrypi123
```

接着安装Hydra：

```shell
# Mac OS X
brew install hydra
# Ubuntu 14.04 LTS
sudo apt-get install -y hydra
```

使用如下命令破解：

```Shell
hydra -L user.txt -P password.txt -t 1 -vV -e ns 192.168.31.151 ssh
```









