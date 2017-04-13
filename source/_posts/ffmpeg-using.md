---
title: ffmpeg-using
date: 2017-03-30 02:10:36
tags:
---

**FFmpeg**是一个[自由软件](https://zh.wikipedia.org/wiki/%E8%87%AA%E7%94%B1%E8%BB%9F%E9%AB%94)，可以运行音频和视频多种格式的录影、转换、流功能，包含了libavcodec——这是一个用于多个项目中音频和视频的解码器库，以及libavformat——一个音频与视频格式转换库。

“FFmpeg”这个单词中的“FF”指的是“Fast Forward”。有些新手写信给“FFmpeg”的项目负责人，询问FF是不是代表“Fast Free”或者“Fast Fourier”等意思，“FFmpeg”的项目负责人回信说：“Just for the record, the original meaning of "FF" in FFmpeg is "Fast Forward"...”

<!-- more -->

#### INSTALL H264 SUPPORT

ERROR: libx264 not found

```shell
cd /usr/src
git clone git://git.videolan.org/x264
cd x264
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl
make
sudo make install
```





#### 安装

```shell
cd /usr/src
git clone https://github.com/FFmpeg/FFmpeg.git
cd ffmpeg
sudo ./configure --arch=armel --target-os=linux --enable-gpl --enable-libx264 --enable-nonfree
make
sudo make install
```

#### ogv to mp4


```shell
ffmpeg -i out.ogv -vcodec h264 out.mp4
```
