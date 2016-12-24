---
title: 在Fedora 24中使用xx-net
tags:
  - Fedora-24
  - xx-net
categories: Software
date: 2016-10-15 21:30:14
---

虽然此处实际在Linux平台进行的配置，但是XX-Net是跨平台的，在Windows、Mac OS下一样可以使用，在其他的操作系统下配置类似。在Fedora 24中安装完Google Chrome之后，还需要同步在Windows平台上保存的Google Chrome的书签（里面有好多收藏的好网站）、Cookie(不用每次登陆网页输入用户名和密码，记忆用户名和密码非常具有迷惑性，目前注册的用户名密码真的太多了，根本记不住，现在都是借助KeePass来记忆)等等数据。平时的搜索还是需要用Google，Google相比于百度，搜索出的结果更加精确，内容对于用户更加有意义。当你迫切想要知道某个问题的思路时，如果搜索出来一些无关痛痒的内容，是非常浪费时间的，消磨你的意志，会让你有一种被掏空了的感觉，对就是那种感觉。极大的降低了效率，想想如此庞大的用户基数，如果搜索出的内容不精准、没有意义所造成的资源浪费（时间、精力、意志力等）是非常恐怖的。所以这也是为什么费尽心思要使用Google，当你顺利的找到自己想要的内容并快速完成任务时，会深刻的体会到前期在科学上网里花费的时间是值得的。要做到以上两点，就需要借助XX-Net。

<!-- more -->

#### xx-net简介

XX-Net是一款让你可以让你提高工作效率的工具，它通过让你可以获取到更多的信息的方式达到。<!--比如家里的娃娃晚上总是不睡觉啊，大人也是天天熊猫眼，可以向朋友取经（限于朋友圈子），如果单身狗比较多，就只能自己摸索了，但是有了xx-net,你可以向任何一个国家的人求助阿，提高了寻找到解决方案的概率。-->XX-Net is a free desktop application that delivers fast, reliable and secure access to the open Internet for users in censored regions. It uses google app engine (GAE:Google App Engine) as a proxy server through the firewall.截至目前，xx-net在Github上(全球最大的同性交友网站)已经有10000+的star和1000+的watch。

#### 下载xx-net

下载在[Github](https://github.com/XX-net/XX-Net/blob/master/code/default/download.md).这里下载的是稳定版(Stable Version).

#### 启动xx-net

下载完毕后,解压文件夹，在终端中切换到解压的文件夹下，运行启动命令。如果是在Windows下，运行<code>start.vbs</code>。

```Bash
./start
```

#### 配置

配置主要分为两步，第一步是安装代理自动切换插件，第二步是导入备份文件，第三步是导入证书。

##### 安装代理切换插件

打开Google Chrome浏览器，切换到插件管理页面,可以选择Settings-Extensions,也可以访问链接：<code>chrome://extensions/</code>，将文件<code>/opt/xx-net/SwitchyOmega/SwitchyOmega.crx</code>托放到浏览器中，即可安装代理自动切换插件SwitchyOmega。

#### 导入备份文件

到SwitchyOmega的设置页面，找到Import/Export选项卡即可。导入完成后，点击SwitchyOmega，切换成“XX-Net自动切换”，如果使用的是X-Tunnel或SS，请点击“X-Tunnel自动切换”。

##### 导入证书

在Google Chrome浏览器中，访问地址：

```Bash
chrome://settings/certificates
```

选择Authorities选项卡，选择导入(Import)证书。证书的存放路径为:`/data/gae-proxy/`下。如下图所示。


{% asset_img import-authorize.png Google-Chrome导入证书%}

证书导入完成后在浏览器中访问地址：

```
localhost:8085
```

出现如下图所示页面表示导入成功。

{% asset_img configuration-success.png Google-Chrome导入证书%}

#### 验证配置并使用

访问Google搜索引擎，如果能够成功访问Google,代表配置成功。如果首次无法访问，可以待后台程序多运行一些时间，几十分钟到几小时不等。一段时间之后再次尝试。需要注意的是XX-Net代理上网不具有匿名性，或者说匿名性很弱。

参考资料：

* [使用Chrome浏览器](https://github.com/XX-net/XX-Net/wiki/%E4%BD%BF%E7%94%A8Chrome%E6%B5%8F%E8%A7%88%E5%99%A8)
