---
title: fedora 24安装Intellij Idea
tags:
- Fedora
- Intellij
categories: Programming
---

#### 解压文件

展开压缩文件：

```Bash
tar -xvf ideaIC-15.0.2.tar.gz
```

Create symbolic links so that the IDE can be opened from any location:
ln -sf /opt/idea-IC-143.1184.17 /opt/idea
ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea

Open the IntelliJ IDE by the running the following command:
idea

#### 创建桌面快捷方式

Create a desktop launcher:
To create a desktop launcher create a idea.desktop file in the Desktop folder inside the HOME folder. Copy paste the following contents in the file:

```Bash
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Name=IntelliJ IDEA
GenericName=Java IDE
Comment=IntelliJ IDEA.
Exec=idea
Icon=/opt/idea/bin/idea.png
Terminal=false
Type=Application
Categories=Development;IDE
```
