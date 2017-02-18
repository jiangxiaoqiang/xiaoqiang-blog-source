---
title: Raspberry Pi动手试用
date: 2017-02-08 11:30:48
tags:
- Raspberry Pi
categories: Equipment
---



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

#### 共享网络

由于没有采购屏幕，所以需要ssh链接。直接通过网线，一端链接树霉派，一端链接笔记本电脑，将无线网络共享给本地链接。

#### SSH登录树莓派

由于本人只选购了一个裸机，也没有屏幕，电源和网线是自己准备的。所以必须要SSH登录到树莓派上面进行操作，使用命令`ssh pi@192.168.1.101`登录时，提示拒绝连接:`ssh: connect to host 192.168.1.101 port 22: connection refused`。使用nmap也无法扫描到打开的端口，原来是树莓派官方默认关闭了SSH(话说关闭了不能搞点宣传吗，能高调点关闭吗，关了也不通知－－貌似也无法通知)，主要还是为了安全考虑，才关闭22端口:

> As of the November 2016 release, Raspbian has the SSH server disabled by default.

重新开启也很简单，把SD卡拔下来，进入到根目录，新建一个名为`ssh`的文件就行了(For headless setup, SSH can be enabled by placing a file named 'ssh', without any extension, onto the boot partition of the SD card)。

参考资料：

[INSTALLING OPERATING SYSTEM IMAGES](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)

[Cannot connect to raspbian jessie lite but to raspbian jessie](http://raspberrypi.stackexchange.com/questions/40689/cannot-connect-to-raspbian-jessie-lite-but-to-raspbian-jessie)

[INSTALLING OPERATING SYSTEM IMAGES ON LINUX](https://www.raspberrypi.org/documentation/installation/installing-images/linux.md)