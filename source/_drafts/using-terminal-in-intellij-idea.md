---
title: 在Intellij Idea中使用终端
tags:
- Intellij Idea
- Terminal
categories: Programming
---

如果需要SSH连接Linux服务器，在Intellij Idea中还有另一个选择，可以直接在Intellij Idea中是一哦那个内嵌的终端连接服务器，避免了窗口之间的切换，感觉还是很方便的。在Tools(Alt + T)-Start SSH Session中进行配置，如图所示。

<!-- more -->

{% asset_img new-ssh-session.jpg 新建SSH会话%}


也可以直接开启一个终端(Ctrl + F12),使用如下的命令登录。

```Bash
ssh root@192.168.24.136
```

可能会出现如下错误提示：

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:NxCwAt/k0XoMvpLGd1OUOdw4pBUAAT/V6tkPlCOWhhg.
Please contact your system administrator.
Add correct host key in /c/Users/Administrator/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /c/Users/Administrator/.ssh/known_hosts:8
ECDSA host key for 192.168.24.137 has changed and you have requested strict checking.
Host key verification failed.

```

生成新的密钥即可：

```Bash
ssh-keygen -R 192.168.24.136
```



