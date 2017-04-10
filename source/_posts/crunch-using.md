---
title: crunch使用
date: 2017-04-03 17:19:32
tags:
- crunch
categories: Security
---



crunch是一个密码字典生成工具。

<!-- more -->

有时可能会存在忘记密码的情况，但是记得其中的单词，可以使用如下命令生成密码字典。

```
crunch 4 5 -o a.txt -p dog cat bird
```

然后再使用Hydra工具尝试取回密码：

```shell
hydra -L ~/user.txt -P ~/a.txt -t 1 -vV -e ns 192.168.32.105 ssh
```

#### 常见问题

```
[ERROR] Compiled without LIBSSH v0.4.x support, module is not available!
```

```shell
wget http://www.libssh.org/files/0.4/libssh-0.4.8.tar.gz
tar zxf libssh-0.4.8.tar.gz
cd libssh-0.4.8
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DWITH_SSH1=ON ..
make
sudo make install
```



