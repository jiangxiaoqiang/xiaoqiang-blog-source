---
title: raspberry-pi-net-proxy
date: 2017-04-03 01:52:45
tags:
- Raspberry
categories: Equipment
---



####  設置XX-Net

在XXnet/data/gae_proxy目录下修改config.ini  将127.0.0.1改为0.0.0.0（这样设置本地+局域网都有效）

```
[pac]
enable = 1
ip = 0.0.0.0
port = 8087
file = proxy.pac
gfwlist = https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt
;adblock = http://adblock-chinalist.googlecode.com/svn/trunk/adblock.txt
; this project have stopped.
expired = 86400
[listen]
ip = 0.0.0.0
port = 8087
visible = 1
debuginfo = 0
```

#### 設置防火牆規則





#### 設置代理

##### 手機端設置

方法一：将XX-Net-2.5.5\data\gae_proxy下的CA.crt复制到手机sd卡。打开设置-安全-存储凭证-从sd卡安装，安装ca.crt 。重启手机

方法二：若方法一无发安装，打开网址 [http://www.realmb.com/droidCert/](http://www.google.com/url?q=http%3A%2F%2Fwww.realmb.com%2FdroidCert%2F&sa=D&sntz=1&usg=AFQjCNEMpbR833byw8M0V0p2peZGuiPFSg)   将XX-Net\data\gae_proxy\CA.crt证书上传，得到一个链接，手机访问可以直接安装证书（安装选择类型WLAN），感谢RealmB！

3.打开设置-wifi-你连接的wifi，把代理改成手动，主机名填你的静态ip，端口填8087

4.这时你的手机应该也能够通过XX-Net翻墙了！

注意：电脑关机后需将手机的代理调回无，才能正常上网（无翻墙）

#### 安裝Lantern

```shell
wget https://github.com/vimagick/rpi-bin/raw/master/deb/lantern_2.2.4-1_armhf.deb
sudo dpkg -i lantern_2.2.4-1_armhf.deb
sudo systemctl start lantern
sudo systemctl enable lantern
curl -x https://127.0.0.1:8787 https://www.google.com/
```



#### 常見問題

##### The proxy server is refusing connections











