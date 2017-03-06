---
title: Raspberry Pi动手试用
date: 2017-02-08 11:30:48
tags:
- Raspberry Pi
categories: Equipment
---



####  简介

树莓派（英语：Raspberry Pi），是一款基于Linux的单板机电脑。它由英国的树莓派基金会所开发，目的是以低价硬件及自由软件促进学校的基本计算机科学教育。剑桥计算机实验室厄普顿项目邮件组中相互交流想法时，为了方便指代厄普顿的电脑，邮件中使用了“树莓”这个水果名字。又由于最开始的原型机上只支持Python编程语言，“树莓”后面又跟上了代表Python的“派”。“树莓派”（Raspberry Pi）就这样诞生了。厄普顿于2009年成了慈善性质的“树莓派基金会”，成为研发树莓派的主要机构。树莓派的生产是通过有生产许可的两家公司：Element 14/Premier Farnell和RS Components。这两家公司都在网上出售树莓派。树莓派基金会于2016年2月发布了树莓派3,较前一代树莓派2，树莓派3的处理器升级为了64位的博通BCM2837，并首次加入了Wi-Fi无线网络及蓝牙功能，而售价仍然是35美元。树莓派3代的额定功率功率是4.0 W.


#### 烧录操作系统(Burn Operation System)

目前可以安装到Raspberry Pi上的系统有，官方推荐的系统可以点击[这里](https://www.raspberrypi.org/downloads/)：

<!-- more -->

* [Ubuntu Mate]([http://ubuntu-mate.org/raspberry-pi/)
* [Raspbian](https://www.raspberrypi.org/downloads/)
* [Pidora](http://pidora.ca/)
* [snappy-raspi2](https://developer.ubuntu.com/core/get-started)

入手Raspberry Pi后，启动Raspberry Pi之前需要将Raspbian系统烧录到SD卡中。此时需要自备读卡器和Micro SD卡。首先到[官网](https://www.raspberrypi.org/downloads/raspbian/)下载镜像，选择RASPBIAN JESSIE WITH PIXEL，可以下载zip包，也可以下载torrent文件。zip包大概有1.5GB大小，解压出来4.4GB左右。由于此处试用的是Ubuntu操作系统，输入如下命令查看Micro SD卡卷标名称：

```shell
df -h
```

h表示human readable，已人机交互友好的方式显示系统当前可用卷的信息。此处查出的卷标名称为`/media/dolphin/9016-4EF8`。然后卸载此卷，使得用户不能对此卷进行操作：

```
umount /media/dolphin/9016-4EF8
umount /media/dolphin/sdb1
umount /media/dolphin/Untitled
```

注意这里必须要先卸载此卷，否则在使用dd命令刻录时会提示`/media/dolphin/9016-4EF8 is a directionay`，从而导致刻录失败。输入如下命令进行烧录：

```shell
sudo dd if=2017-01-11-raspbian-jessie.img of=/dev/sdb bs=2M
```

of(output file)参数后面不要添加斜杠。if表示input file，bs表示block size。输入命令后系统在后台刻录，前台可能看不到进度，此时只需要耐心等待即可。如果想要看到写入的进度，可以使用dd的一款加强版本dcfldd，是dd的一个fork，在 dd 的基础上增加了取证和安全方面的功能。让人感到郁闷的是，烧录后，Ubuntu不管怎样都无法读出存储卡的数据了。使用命令重新加载也无法读出。**这里需要注意,SD卡分boot区和数据区，所以在使用dd命令刻录时，填写sdb，而不是sdb1。**

```Bash
sudo mount /dev/sdb1 /mnt -t ext3
```

提示错误如下：

```
dolphin@dolphin-F81Se:~$ sudo mount /dev/sdb1 /mnt -t ext3
mount: wrong fs type, bad option, bad superblock on /dev/sdb1,
       missing codepage or helper program, or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so
```

采用命令查看：

```Bash
dmesg|tail
```

提示如下：

```
[ 4978.374994] EXT4-fs (sdb1): VFS: Can't find ext4 filesystem
[ 4978.376737] EXT4-fs (sdb1): VFS: Can't find ext4 filesystem
[ 4978.378490] EXT4-fs (sdb1): VFS: Can't find ext4 filesystem
[ 4978.379857] FAT-fs (sdb1): bogus number of reserved sectors
[ 4978.379863] FAT-fs (sdb1): Can't find a valid FAT filesystem
[ 4978.383365] hfsplus: unable to find HFS+ superblock
[ 5008.676937] EXT4-fs (sdb1): VFS: Can't find ext4 filesystem
```

##### 问题解决

开始的时候还真没有想到会出现这么多的问题，本来以为挺简单，不过中间问题也比较多。在Mac上面格式化之后是Mac的文件系统格式，不过在Ubuntu下也可以识别，问题不大。因为下载的img镜像是在Ubuntu这台电脑上，所以刻录使用的是Ubuntu这台机器。使用dd命令刻录好之后，电脑怎么也识别不出U盘了，在Fedora上也是识别不出来。只好插到Mac上重新格式化才能识别。刻录完毕之后需要在闪存卡上添加文件的，所以，必须要Ubuntu刻录完毕后能够识别出U盘的文件系统。需要使用FAT32文件系统格式，开始的时候倒没有注意到这个问题。FAT32是古董级的文件系统了。不过FAT和FAT32也是目前兼容性最好的文件系统，几乎所有的设备都支持，FAT32的缺点是不支持单个文件大小在4GB以上的文件。exFAT给我们的最大好处：没有4GB的限制，没有32GB的限制，不会对U盘的寿命产生影响，有一大票的数码产品支持或即将支持。

| 名称     | 描述                                       | 特性                                       |
| ------ | ---------------------------------------- | ---------------------------------------- |
| ext2() | Ext2文件系统是Linux 特有的文件系统，它拥有传统UNIX 文件系统的许多特性，如块、inode 和目录等概念。Ext2 非常健壮，具有很多优良的性能。同时，Ext2 也是可扩展的，它提供 的扩展功能允许用户在不格式化文件系统的情况下使用新的特性。 Ext2的含义是Linux第二代文件系统(Linux second extended file system)。 | **最大文件大小**： 1TB     **最大文件极限**： 仅受文件系统大小限制    **最大分区/文件系统大小**： 4TB    **最大文件名长度**： 255 字符    **缺省最小/最大块大小**： 1024/4096 字节    **缺省inode 分配**： 每4096 字节为1  **在强制FS 检查前的最大装载**： 20（可配置） |
| Ext3   | Ext3 文件系统构筑于ext2 文件系统之上，对标准的Linux ext2 文件系统进行了日志扩展。 日志特性显著地减少文件系统崩溃后的恢复时间，它被广泛地应用于带有共享磁盘的HA 站 点。 |                                          |
| Ext4   | Ext4改进版的Ext3。                            |                                          |
| FAT    | 兼容性最好。                                   |                                          |
| FAT32  |                                          |                                          |
| exFAT  |                                          |                                          |
| NTFS   | 兼容性较好。                                   |                                          |

在Ubuntu下，可以输入命令`df -lhT`查看每个分区的文件系统类型。也可以打开文件`/etc/fstab(file system table)`文件进行查看。

##### unknown filesystem type 'exfat'

是由于当前文件系统不识别exfat文件系统的缘故。重新格式化SD卡为兼容性较高的文件系统(如:FAT、FAT32	)即可。




烧录完成之后，有可能当前电脑识别不出SD卡，此时可以将SD卡插入其他电脑，并修改其中的文件(我的电脑在Ubuntu下刻录之后，Ubuntu这台机器无法再读取U盘，但是安装Fedora系统的另一台计算机可以读取)，此处添加一个空的ssh文件。文件添加完毕后，将SD卡插入Raspberry Pi的卡槽中，接通电源启动Raspberry，那么就会默认启动sshd进程，知道了树莓派的IP后就可以使用ssh登录了。

#### 构建局域网

使用一根网线连接Pi和笔记本，组成一个局域网。在笔记本上配置DHCP(Dynamic Host Configuration Protocol)服务，这样Pi启动后就可以从DHCP获取IP：

```Bash
yum install dhcp -y
```

打开dhcp配置文件`sudo vim /etc/dhcp/dhcpd.conf`，配置dhcp：

```Shell
subnet 192.168.33.0 netmask 255.255.255.0 { 
    range 192.168.33.2 192.168.33.114; 
    default-lease-time 86400; 
    max-lease-time 259200; 
    option subnet-mask 255.255.255.0; 
    option broadcast-address 192.168.33.255; 
    option routers 192.168.33.2; 
    option domain-name-servers 192.168.33.2; 
}
```

配置完成后通过`dhcpd`命令启动，会提示相应文件的存储位置。

```
Config file: /etc/dhcp/dhcpd.conf
Database file: /var/lib/dhcpd/dhcpd.leases
PID file: /var/run/dhcpd.pid
```
配置与Pi连接的网卡的IP:

```Bash
sudo ifconfig enp0s25 192.168.33.2/24
```

enp0s25指代的是有线网卡的名称。en指代的是Ethernet,p0s25指代的是PCI接口物理位置为(0,25)，其中横坐标代表bus，纵坐标代表slot。自从将原来的旧的引导系统initd替换为systemd，网卡采用的是另一套命名规则。使用`arp`命令查看Raspberry Pi的IP，可以看到此处的IP是192.168.33.3：

```
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.33.3             ether   c8:37:eb:36:16:63   C                     enp0s25
gateway                  ether   f2:83:cd:94:23:14   C                     wlp3s0
```

#### SSH登录树莓派

`nmap`命令（Network Mapper）是一个开源的工具，可以用来寻找“开启的主机”。Linux，Mac OS，和Windows平台上都可以使用。输入如下命令获取树莓派的IP：

```shell
# 扫描局域网中UP的主机
nmap -sn 192.168.1.0/24
```

由于本人只选购了一个裸机，也没有屏幕，电源和网线是自己准备的。所以必须要SSH登录到树莓派上面进行操作，其实没有多大必要使用屏幕，到如今还比较庆幸当初没有花多余的钱购置配件，实在是没有任何必要。仅仅一个Raspberry Pi，一张8GB或以上的存储卡，一根网线，5V2A的充电器一个，USB数据线一条。许多配件家里都有现成的。使用命令`ssh pi@192.168.33.3`登录，注意或许会提示拒绝连接:`ssh: connect to host 192.168.33.3 port 22: connection refused`。使用nmap也无法扫描到打开的端口，原来是树莓派官方默认关闭了SSH(当初也是不知道，也没有屏幕，折腾了许久)，主要还是为了安全考虑，才关闭22端口:

> As of the November 2016 release, Raspbian has the SSH server disabled by default.

重新开启也很简单，把SD卡拔下来，进入到启动目录（这里也需要注意，一定要在启动目录boot下，因为Raspberry Pi有2个目录，不要弄错），新建一个名为`ssh`的文件就行了(For headless setup, SSH can be enabled by placing a file named 'ssh', without any extension, onto the boot partition of the SD card)。

成功登陆Raspberry Pi,截图记录一下，当初以为非常简单，动手起来还是不容易的：

{% asset_img ssh-login-raspberry-pi.jpg Raspberry Pi登陆%}

虽然已经通过Fedora登录Raspberry Pi，但是此时Raspberry Pi和Fedora在同一个局域网里，而Fedora和路由在另一个局域网里，所以Raspberry Pi目前还无法连接互联网，只是一个局域网里面的设备。

参考资料：

[树莓派：关于教育的故事](https://www.douban.com/note/607175261/)

[INSTALLING OPERATING SYSTEM IMAGES](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)

[Cannot connect to raspbian jessie lite but to raspbian jessie](http://raspberrypi.stackexchange.com/questions/40689/cannot-connect-to-raspbian-jessie-lite-but-to-raspbian-jessie)

[INSTALLING OPERATING SYSTEM IMAGES ON LINUX](https://www.raspberrypi.org/documentation/installation/installing-images/linux.md)

[树莓派](https://zh.wikipedia.org/wiki/%E6%A0%91%E8%8E%93%E6%B4%BE)