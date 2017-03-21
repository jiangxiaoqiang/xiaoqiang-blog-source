---
title: Hadoop集群SSH免密钥登录
date: 2016-09-30 16:41:35
tags: [SSH,Cluster]
---


#### 免密登录原理

SSH之所以能够保证安全，原因在于它采用了公钥加密。过程如下：

1. 远程主机收到用户的登录请求，把自己的公钥发给用户；
2. 用户使用这个公钥，将登录密码加密后，发送回来；
3. 远程主机用自己的私钥，解密登录密码，如果密码正确，就同意用户登录。

#### 配置SSH免密登陆

首先，运行<code>ssh localhost</code>来产生<code>/home/用户名/.ssh</code>目录，然后执行下面命令。

<!-- more -->

```Bash
ssh-keygen -t rsa
```

生成RSA公钥和私钥，注意在生成时要设置一个密码，尽量设置复杂一些。将生成的"id_rsa.pub"追加（这里切记是追加，不是覆盖）到授权的key里面去。这样的效果是实现了当前用户无密SSH登陆到自己，在首次登录时需要输入一遍生成Public Key时候设置的密码，可以勾选为自动保存，就只需要输入一次，以后就可以直接ssh登录：

```Bash
#将id_rsa.pub追加到authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

如果要实现无密登陆到其它的主机，只需将生成的"id_rsa.pub"追加到其它主机的"\~/.ssh/authorized_keys"中去。这里我们使用的方法是先将本机的"\~/.ssh/id_rsa.pub"拷贝到你想无密登陆的主机上，再在相应的主机上使用"cat"命令将"\~/.ssh/id_rsa.pub"追加到该主机的 "\~/.ssh/authorized_keys"中。

```Bash
scp id_rsa.pub root@192.168.24.136:/tmp
```

#### 验证

当再使用如下命令：

```Bash
scp id_rsa.pub root@192.168.24.136:/tmp
```

从A服务器向192.168.24.136服务器拷贝时，不再提示输入密码时，则说明A服务器到192.168.24.136服务器可以免密钥登录,说明A服务器到192.168.24.136服务器的免密钥登录配置OK。

来自：

[SSH无密码验证配置]
[SSH无密码验证配置]:http://www.cnblogs.com/lijingchn/p/5580263.html
