---
title:使用travis CI自動構建Hexo項目
---

在使用Hexo寫網誌時，一般都是先寫好，在發布到本地github目錄，push到github網站上。但是令人頭疼的是總是會構建失敗，提示信息非常少。


## 部署Key

首先必須用ssh-keygen製作一個SSH Key，供GitHub當作Deploy key使用。

```Bash
ssh-keygen -t rsa -C "[email]"
ssh-keygen -t rsa -f ~/.ssh/id_rsa.travis -C "[email]"
ssh-keygen -t rsa -f ~/a/id_rsa -C "[email]"
```

當 SSH key 製作完成後，複製 Public key 到 GitHub 上的 Deploy key 欄位。這裡由於目錄下本身已經有原來的GitHub的rsa的key，所以生成的文件名為<code>id_rsa.travis</code>。

## 加密 Private Key

首先，安裝 Travis 的命令列工具：

```Bash
gem install travis
```

在使用gem命令前，需要先安装Ruby。在安裝完畢後，透過命令列工具登入到 Travis：

```Bash
travis login --auto
```








