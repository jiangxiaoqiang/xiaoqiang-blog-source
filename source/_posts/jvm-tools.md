---
title: jvm工具
date: 2016-12-08 21:54:49
tags:
---


#### jps(JVM Process Status Tools)

jps是参照Unix系统的取名规则命名的，而他的功能和ps的功能类似，可以列举正在运行的饿虚拟机进程并显示虚拟机执行的主类以及这些进程的唯一ID（LVMID，对应本机来说和PID相同）。VMID与LVMID需要特别说明下：如果是本地虚拟机进程，VMID(Virtual Machine IDentifier,虚机标识符)和LVMID(Local Virtual Machine IDentifier,虚机标识符)是一致的，如果是远程虚拟机进程，那VMID的格式应当是：[protocol:][//] lvmid [@hostname[:port]/servername]

<!-- more -->

```Bash
jps -lv
```

输出为：

```
2609 sun.tools.jps.Jps -Dapplication.home=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-3.b16.fc24.x86_64 -Xms8m
2479 nutstore.client.gui.NutstoreGUI -ea -Dfile.encoding=UTF-8 -Xmx320M -XX:MinHeapFreeRatio=20 -XX:MaxHeapFreeRatio=40 -Dlog4j.defaultInitOverride=true -Djava.util.logging.config.file=/home/dolphin/.nutstore/dist/conf/java.logging.properties -Dnutstore.config.dir=/home/dolphin/.nutstore/dist/conf -Dnutstore.x64=True -Djava.library.path=/home/dolphin/.nutstore/dist/lib/native
```

#### jstat(JVM Statistics Monitoring Tools)

jstat是HotSpot Java虚拟机的性能统计工具。jstat主要用于监控虚拟机的各种运行状态信息，如类的装载、内存、垃圾回收、JIT编译器等，在没有GUI的服务器上，这款工具是首选的一款监控工具。每20秒查询一次进程2479的垃圾回收情况，监控5次，命令如下所示：

```Bash
jstat -gc 2479 20000 5
```

参数gc表示监视Java堆，包含eden、2个survivor区、old区和永久带区域的容量、已用空间、GC时间合计等信息。

{% asset_img jstat-gc.jpg jstat监控Java GC %}

上图中 S0 表示Survivor 0区的空间使用比例,S0C（Survivor 0 Count）， E, O, P 分别代表Eden, Old和Perm空间使用率，YGC 表示young gc的次数，YGCT(Young Generation Consume Time) 表示young gc消耗的时间。GCT(GC Time) 则用来统计执行gc的总时间。

| Column | Description |
| ----------------- |:-------------:|
|S0C |	Current survivor space 0 capacity (KB)|
|S1C |	Current survivor space 1 capacity (KB)|
|S0U |	Survivor space 0 utilization (KB)|
|S1U |	Survivor space 1 utilization (KB)|
|EC	| Current eden space capacity (KB)|
|EU	| Eden space utilization (KB)|
|OC	| Current old space capacity (KB)|
|OU	| Old space utilization (KB)|
|PC	 |Current permanent space capacity (KB)|
|PU	| Permanent space utilization (KB)|
|MC | Metaspace capacity (kB)|
|MU | Metacspace utilization (kB)|
|CCSC | Compressed class space capacity (kB)|
|CCSU | Compressed class space used (kB)|
|YGC	| Number of young generation GC Events|
|YGCT	| Young generation garbage collection time|
|FGC	| Number of full GC events|
|FGCT	| Full garbage collection time|
|GCT	| Total garbage collection time|

#### jinfo（JVM configuration Info for Java）

Jinfo的作用是实时查看虚拟机的各项参数信息jps –v可以查看虚拟机在启动时被显式指定的参数信息，但是如果你想知道默认的一些参数信息呢？除了去查询对应的资料以外，jinfo就显得很重要了。

#### jmap（JVM Memory Map for Java）

#### jhat（JVM Heap Analysis Tool）

#### jstack（JVM Stack Trace for java）

jstack用于JVM当前时刻的线程快照，又称threaddump文件，它是JVM当前每一条线程正在执行的堆栈信息的集合。生成线程快照的主要目的是为了定位线程出现长时间停顿的原因，如线程死锁、死循环、请求外部时长过长导致线程停顿的原因。通过jstack我们就可以知道哪些进程在后台做些什么？在等待什么资源等！

参考资料：

[jstat - Java Virtual Machine Statistics Monitoring Tool](http://docs.oracle.com/javase/1.5.0/docs/tooldocs/share/jstat.html)
