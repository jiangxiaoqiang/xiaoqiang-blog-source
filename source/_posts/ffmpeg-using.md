---
title: ffmpeg-using
date: 2017-03-30 02:10:36
tags:
---


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

