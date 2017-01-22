---
title: localhost vs 127.0.0.1
date: 2017-01-21 22:30:31
tags:
- Network
- loopback
categories: Programming
---

IPv4 的网络标准把 从127.0.0.1 到 127.255.255.254 IP地址块都用作loopback 。所有的发到这些地址的数据包都会被毫发无损的返回去(looped back ) ， 这一千六百多万个个地址中，最知名的、最常用的就是127.0.0.1 。

<!-- more -->

比如使用命令：

```Bash
ping 127.0.0.1
ping 127.0.0.2
ping 127.255.255.254
```

在Fedora中，3个地址都是loopback，在Mac OS X中，只有127.0.0.1是loopback。

对于IPv6来说， 它只把一个地址用作loopback , 就是::1(0000:0000:0000:0000:0000:0000:0000:0001) 。

有了loopback 地址， 同一个计算机上的进程通信都很方便了， 根本不用走实际的物理网卡。比如说你在本机建立了一个Web服务器，然后通过浏览器用http://127.0.0.1:8080 去访问， 操作系统内的网络协议栈会把这个HTTP GET请求封装到一个TCP包中，写上目的端口号8080，  然后再封装到一个IP包中， 写上目的地址127.0.0.1 。但是这个IP数据包并不会发送到物理的网卡那里去，更不会通过数据链路层发送到局域网乃至互联网中， 实际上它发给了虚拟的网络接口, 然后立刻被looped back到IP层的输入队列中。IP层收到数据包，交付给TCP层， TCP层发现目的端口是8080， 就会把GET请求取出来，交付给绑定8080端口的Web服务器。在Unix 和 Linux系统中， 通过把loopback 接口命名为 lo(loopback) 或者 lo0  （注意第一个字母是L的小写字母，不是数字一）.在Mac OS X上输入ifconfig命令后，可以看到lo虚拟网卡的信息：

```
bogon:xiaoqiang-blog-source dolphin$ ifconfig
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384
	options=1203<RXCSUM,TXCSUM,TXSTATUS,SW_TIMESTAMP>
	inet 127.0.0.1 netmask 0xff000000 
	inet6 ::1 prefixlen 128 
	inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1 
	nd6 options=201<PERFORMNUD,DAD>
```

至于localhost , 这就是个本机的主机名， 在大多数机器上， 这个主机名都会被计算机操作系统映射到127.0.0.1 (ipv4)或者::1 (ipv6) ,那使用localhost 和ip 实际上一样了。

```
127.0.0.1 localhost 
::1 localhost    
```

当然你可以手工的修改hosts文件来改变这种默认映射。Windows的hosts 文件位置：   

```
%SystemRoot%\System32\drivers\etc\hosts 
```

Unix , Liunx的hosts 文件位置：

```
/etc/hosts    
```

但是有个有意思的例外就是mysql , 在Linux 上，当你使用localhost来连接数据库的时候，Mysql会使用Unix domain socket来传输数据，这种方式会快一些， 因为这是一种进程内通信(IPC)机制， 不走网络协议栈， 不需要打包拆包， 计算校验和，维护序号等操作。当你使用127.0.0.1的时候， mysql 还是会使用TCP/IP协议栈来进行数据传输。