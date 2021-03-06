---
title: youtube缓慢卡顿的问题
date: 2017-02-03 13:28:28
tags:
- YouTube
categories: Internet
---

YouTube是全球最大的视频分享网站，内容五花八门，地铁的地下通道是怎么建造的？超级跑车怎么生产出来的？特斯拉的使用体验如何？物体速度超过光速会发生什么？......强烈的满足了我的好奇心。

<!-- more -->

本来服务器都相隔千山万水，还没有政策支持，速度慢也就不奇怪了。解决速度慢的问题大致有如下方法。


#### 调低视频质量

谁不喜欢高清无码呢？但是残酷的现实就在眼前啊，要求完美的自己也会降低标准。但是很多时候降低标准并不会奏效。那种要来了而不得的感觉，甭提有多让人抓狂了。

#### 增加网络带宽

同上，该卡的总是会卡。

#### 下载

将视频下载到本地是终极的解决方案，彻底告别卡顿。可以登录网站`www.savefrom.net`，直接将视频地址复制到网站的搜索框中下载，也可以安装网站的插件。发现了一个下载Youtube视频的工具：youtube-dl(youtube downloader)，项目托管在Github上，是用Python写的脚本。一共有2W+的Star，500+的Contributor，直到最近都还有更新。以前已经安装，使用如下命令升级：

```shell
sudo -H pip install --upgrade youtube-dl
```

由於在國內的網絡環境u無法訪問youtube，下載youtube視頻需要與代理結合。暫時記錄使用youtube-dl下載國內視頻的方法。以下載《The Big Bang Theroy》爲例，下載視頻使用如下命令：

```shell
youtube-dl http://tv.sohu.com/20150721/n417248066.shtml?txid=10ad708cb3c0cfcd5ea81608c0a558de&vfm=bdvtx&frp=v.baidu.com%2Ftv_intro%2F&bl=jp_video
```

如果想下載所有清晰度格式的視頻，可以添加`--all-formats`參數：

```shell
youtube-dl --all-formats http://tv.sohu.com/20150721/n417248066.shtml?txid=10ad708cb3c0cfcd5ea81608c0a558de&vfm=bdvtx&frp=v.baidu.com%2Ftv_intro%2F&bl=jp_video
```

畢竟也沒有必要下載所有格式的視頻，可以先列出不同清晰度格式的視頻選擇自己需要的視頻再下載：

```shell
youtube-dl --list-formats http://tv.sohu.com/20150721/n417248066.shtml?txid=10ad708cb3c0cfcd5ea81608c0a558de&vfm=bdvtx&frp=v.baidu.com%2Ftv_intro%2F&bl=jp_video
```

選擇需要的清晰度的視頻下載：

```shell
youtube-dl -f super http://tv.sohu.com/20150721/n417248066.shtml?txid=10ad708cb3c0cfcd5ea81608c0a558de&vfm=bdvtx&frp=v.baidu.com%2Ftv_intro%2F&bl=jp_video
```

-f參數表示format的含義，super表示超清格式。但是下載完畢的視頻是單個文件，麼有合併的，所以需要使用FFmpeg工具將之合併：



注意此種方式勿用於商業用途，視頻提供商需要大量的服務器和帶寬成本。
