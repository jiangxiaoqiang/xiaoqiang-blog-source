---
title: 使用Travis CI自動構建Hexo項目
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

在使用gem命令前，需要先安装Ruby。有时候下载失败需要多次运行命令，在安裝完畢後，透過命令列工具登入到 Travis：

```Bash
travis login --auto
```
如此一來，我們就能透過 Travis 提供的命令列工具加密剛剛所製作的 Private key，並把它上傳到 Travis 上供日後使用。

假設 Private key 的檔案名稱為 ssh_key， Travis 會加密並產生 ssh_key.enc，並自動在 .travis.yml 的 before_install 欄位中，自動插入解密指令。

```Bash
travis encrypt-file ssh_key --add
```

正常來說 Travis 會自動解析目前的 repo 並把 Private key 上傳到相對應的 repo，但有時可能會秀逗，提示如下错误：

```
Can't figure out GitHub repo name. Ensure you're in the repo directory, or speci
fy the repo name via the -r option (e.g. travis <command> -r <owner>/<repo>)
```

這時你必須在指令後加上 -r 選項來指定 repo 名稱，例如：

```Bash
travis encrypt-file ssh_key --add -r jiangxiaoqiang/jiangxiaoqiang.github.com
```


