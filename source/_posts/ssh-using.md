---
title: ssh-using
date: 2017-04-06 21:49:32
tags:
- ssh
categories: Tool
---

ssh是Scure Shell的簡稱。

<!-- more -->

#### 端口轉發

有时，本地电脑处于NAT内网中，难以从外部访问；而远程服务器可轻易被访问。利用远程转发功能，可允许他人通过远程服务器间接访问本地电脑的某个端口。

```shell
ssh -R 9090:localhost:80 my-remote-host.com
```

这样，访问`my-remote-host.com:9090`就等同于用本机访问`localhost:8080`。

#### 安裝 denyhosts 套件

它會定時檢查 /var/log/auth.log 檔， 只要來自某 IP 的登入次數符合以下任一條件 (以下為預設值)

1. 1 次 root 登入失敗 (`DENY_THRESHOLD_ROOT=1`)
2. 5 次企圖使用不存在的帳戶登入 (`DENY_THRESHOLD_INVALID=5`)
3. (5 天之內 `AGE_RESET_VALID=5d`) 發生 10 次一般正常用戶登入失敗 (`DENY_THRESHOLD_VALID=10`)

就會把那個 IP 加到 /etc/hosts.deny 去， 也就是封鎖了那個 IP。

#### 禁用密碼認證

密碼登錄永遠無法避免端口掃描後的暴力破解，密碼登錄需要自己去記憶密碼，而人的記憶在安全看來有一個缺點是長度不夠，和有規律。而有規律也是一大破綻，不管多長的密碼，找出了規律就會輕而易舉的破解，而一般的規律都是有章可循的，是極爲有限的。密碼認證也無法防止中間人攻擊，而更加安全的做法是開啓密鑰認證。可以很好的避免上述問題。在`/etc/ssh/sshd_config`中，做如下配置：

```shell
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
```

將本機的公鑰添加到遠程主機信任列表：

```shell
ssh -p 22222 hl@192.168.1.101 'mkdir -p .ssh && cat >> .ssh/authorized_keys' < ~/.ssh/id_rsa.pub
```

#### 禁止root登錄

在`/etc/ssh/sshd_config`文件中作如下設置：

```shell
PermitRootLogin no
```

另外在文件`/var/log/secure`中，可以查看登錄的日誌記錄。

#### 常見問題

##### Authentication refused: bad ownership or modes for file

SSH doesn’t like it if your home or `~/.ssh` directories have group write permissions. Your home directory should be writable only by you, `~/.ssh` should be 700, and authorized_keys should be 600。











