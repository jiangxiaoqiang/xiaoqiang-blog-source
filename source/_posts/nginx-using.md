---
title: Nginx使用
date: 2017-01-09 13:08:05
tags:
- Nginx
categories: Programming
---

#### 安装

在Ubuntu下，输入如下命令安装：

```Bash
sudo apt install nginx -y
```

安装完毕后配置文件在`/etc/nginx/config.d`。

<!-- more -->

#### 常用命令

```Bash
# 查看Nginx的安装目录,一般在(/usr/local/nginx)下
whereis nginx

# 重启Nginx
sudo /etc/init.d/nginx restart
```

#### location

每个 url 请求都会对应的一个服务，nginx 进行处理转发或者是本地的一个文件路径，或者是其他服务器的一个服务路径。而这个路径的匹配是通过 location 来进行的。我们可以将 server 当做对应一个域名进行的配置，而 location 是在一个域名下对更精细的路径进行配置。

```
location /api{
      proxy_pass http://dn5:28080;
      proxy_redirect off;
}
```

将前缀为api的请求发送到地址：`http://dn5:28080`.

#### 常见问题

#####  the HTTP rewrite module requires the PCRE library

在安装时提示 the HTTP rewrite module requires the PCRE library：

```
./configure: error: the HTTP rewrite module requires the PCRE library.
You can either disable the module by using --without-http_rewrite_module
option, or install the PCRE library into the system, or build the PCRE library
statically from the source with nginx by using --with-pcre=<path> option.
```

安装pcre-devel与openssl-devel解决问题：

```Bash
yum -y install pcre-devel openssl openssl-devel
 
./configure --prefix=/usr/local/nginx
make
make install
```