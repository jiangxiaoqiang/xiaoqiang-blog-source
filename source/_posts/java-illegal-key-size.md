---
title: Java illegal key size错误
date: 2017-04-01 20:33:49
tags:
- Java
categories: Programming
---



最近遇到一个奇怪的问题，程序使用Ansible在服务端远程启动，运行到如下代码时：

<!-- more -->

```java
 // 设置加密模式为AES的CBC模式
Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
SecretKeySpec keySpec = new SecretKeySpec(aesKey, "AES");
IvParameterSpec iv = new IvParameterSpec(aesKey, 0, 16);
cipher.init(Cipher.ENCRYPT_MODE, keySpec, iv);

// 加密
byte[] encrypted = cipher.doFinal(unencrypted);

// 使用BASE64对加密后的字符串进行编码
return base64.encodeToString(encrypted);
```

在语句`cipher.init(Cipher.ENCRYPT_MODE, keySpec, iv);`处报错：

>  java.security.InvalidKeyException: Illegal key size

一说要替换local_policy.jar和US_export_policy.jar文件，替换了同样报错。在本地运行正常，在服务器上通过脚本启动正常，通过Ansible远程启动异常。用jps命令查看程序的PID，使用`jinfo pid`查看程序时，提示如下错误：

```
Error attaching to process: sun.jvm.hotspot.runtime.VMVersionMismatchException: Supported versions are 25.111-b14. Target VM is 25.101-b13
sun.jvm.hotspot.debugger.DebuggerException: sun.jvm.hotspot.runtime.VMVersionMismatchException: Supported versions are 25.111-b14. Target VM is 25.101-b13
```

jinfo命令支持的版本是25.111-b14，但是当前程序的版本是25.101-b13。在服务器上执行`java -version`命令输出如下：

```
java version "1.8.0_111"
Java(TM) SE Runtime Environment (build 1.8.0_111-b14)
Java HotSpot(TM) 64-Bit Server VM (build 25.111-b14, mixed mode)
```

说明jvm版本25.111-b14对应的java版本是1.8.0_111。由于服务器上安装有OpenJDK 1.6，怀疑是Ansible Session使用了OpenJDK，切换到OpenJDK下执行命令`./java -version`查看，输出如下：

```
java version "1.6.0_28"
OpenJDK Runtime Environment (IcedTea6 1.13.0pre) (rhel-1.66.1.13.0.el6.ns6.00-x86_64)
OpenJDK 64-Bit Server VM (build 23.25-b01, mixed mode)
```

所以没有使用OpenJDK的jvm，另外又在用户目录下发现了一个`jdk1.8.0_101`的版本，使用命令查看：

```
java version "1.8.0_101"
Java(TM) SE Runtime Environment (build 1.8.0_101-b13)
Java HotSpot(TM) 64-Bit Server VM (build 25.101-b13, mixed mode)
```

问题就很明显了，Ansible默认使用的是`/usr/java/jdk1.8.0_101`路径下的JDK，而在服务器上启动程序时，默认使用的是`/opt/app/local/jdk1.8.0_111`路径下的JDK，两个JDK仅仅有一些版本上的细微差异。程序都能正常启动，能够正常跑起来，大部分的功能都OK，就是一些细微的地方有差异。非常不容易被发现。所以将启动脚本的java路径写成绝对路径，此问题才算是找到原因并解决：

```shell
nohup /opt/app/local/jdk1.8.0_111/bin/java -Xmx8192M -Xms4096M -jar -Xdebug -Xrunjdwp:transport=dt_socket,suspend=n,server=y,address=5005 /opt/app/backend/credit-system-web-boot-1.0.0.jar >/dev/null &
```

这个问题一直纠结在心中好几天。