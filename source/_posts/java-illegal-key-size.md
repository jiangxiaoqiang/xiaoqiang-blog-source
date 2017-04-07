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

#### 發現問題產生原因

一说要替换local_policy.jar和US_export_policy.jar文件，替换了同样报错(實際替換是可以解決問題的，只是替換的位置不對，後面會提到)。經過反覆的嘗試，發現在本地运行此程序正常，在服务器上通过脚本启动程序正常，但是通过Ansible远程启动异常。所以想看看本地啓動程序和遠程啓動程序時，執行環境有何區別，在終端中用jps(Java Process)命令查看此計算機所有Java程序的PID，在終端中使用`jinfo pid`命令查看目標程序執行參數和運行環境时，提示如下错误：

```
Error attaching to process: sun.jvm.hotspot.runtime.VMVersionMismatchException: Supported versions are 25.111-b14. Target VM is 25.101-b13
sun.jvm.hotspot.debugger.DebuggerException: sun.jvm.hotspot.runtime.VMVersionMismatchException: Supported versions are 25.111-b14. Target VM is 25.101-b13
```

大意是此jinfo命令支持的jvm版本是25.111-b14，但是当前程序的jvm版本是25.101-b13。由於jvm版本與java版本的對應關係自己也不是很清楚，在服务器上执行`java -version`命令输出如下：

```
java version "1.8.0_111"
Java(TM) SE Runtime Environment (build 1.8.0_111-b14)
Java HotSpot(TM) 64-Bit Server VM (build 25.111-b14, mixed mode)
```

说明jvm版本25.111-b14对应的java版本是1.8.0_111，由此就比較清晰了，用Ansible遠程啓動時，運行此程序的Java版本和在遠程機器上通過腳本啓動程序所使用的Java版本是不一致的。由于服务器上安装有OpenJDK 1.6，怀疑是Ansible Session使用了OpenJDK，切换到OpenJDK下执行命令`./java -version`查看，输出如下：

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

问题就很明显了，Ansible默认使用的是`/usr/java/jdk1.8.0_101`路径下的JDK，而在服务器上启动程序时，默认使用的是`/opt/app/local/jdk1.8.0_111`路径下的JDK，两个JDK仅仅有一些版本上的细微差异。程序都能正常启动，能够正常跑起来，大部分的功能都OK，就是一些细微的地方有差异。非常不容易被发现。

#### 解決問題

所以将启动脚本的java路径写成绝对路径，此问题才算是找到原因并解决：

```shell
nohup /opt/app/local/jdk1.8.0_111/bin/java -Xmx8192M -Xms4096M -jar -Xdebug -Xrunjdwp:transport=dt_socket,suspend=n,server=y,address=5005 /opt/app/backend/credit-system-web-boot-1.0.0.jar >/dev/null &
```

这个问题一直纠结在心中好几天。同時也可以通過替換另一個Java的local_policy.jar和US_export_policy.jar文件來解決，不過肯定不能選擇這個解決方案的，因爲開發環境的Java版本是1.8.0\_111。同時也說明了爲什麼替換了local_policy.jar和US_export_policy.jar文件根本沒有生效，因爲根本就沒有使用1.8.0\_111版本的Java。

#### 新的問題

接下來新的問題又來了，爲什麼本地執行shell腳本是使用的環境變量裏指定的Java，而通過Ansible啓動時運行的又是另一個Java版本？直到找到了[《ssh连接远程主机执行脚本的环境变量问题》](http://feihu.me/blog/2014/env-problem-when-ssh-executing-command-on-remote/)這篇文章，最終的疑惑才解開。是由於通過Ansible啓動的是非交互非登錄shell，所以不會加載環境變量的設置，所以就使用的是`/usr/bin`目錄下的Java。

#### 此問題需要學到的

首先Bash有四種模式。四種模式加載的配置文件不同，而且配置文件加載的順序也不同。

##### interactive login shell

- 用户直接登陆到机器获得的第一个shell
- 用户使用`ssh user@remote`获得的shell

这种模式下，shell首先加载/etc/profile，然后再尝试依次去加载下列三个配置文件之一，一旦找到其中一个便不再接着寻找：

* ~/.bash_profile
* ~/.bash_login
* ~/.profile

##### non-interactive login shell

非交互式的登陆shell，这种是不太常见的情况。一种创建此shell的方法为：`bash -l script.sh`，前面提到过-l参数是将shell作为一个login shell启动，而执行脚本又使它为non-interactive shell。

##### interactive non-login shell

交互式的非登陆shell，这种模式最常见的情况为在一个已有shell中运行`bash`，此时会打开一个交互式的shell，而因为不再需要登陆，因此不是login shell。

##### non-interactive non-login shell

這裏遠程執行命令即屬於非登錄、非交互模式。对于这种模式而言，它会去寻找环境变量`BASH_ENV`，将变量的值作为文件名进行查找，如果找到便加载它。`BASH_ENV`環境變量保存一個Bash啓動文件路徑，當啓動一個非交互非登錄會話時會去讀取該變量指定的文件。

參考資料：

* [《ssh连接远程主机执行脚本的环境变量问题》](http://feihu.me/blog/2014/env-problem-when-ssh-executing-command-on-remote/)