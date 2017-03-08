---
title: Nginx使用总结
date: 2017-01-09 13:08:05
tags:
- Nginx
categories: Tool
---

#### 安装

输入如下命令安装：

```Bash
# Ubuntu 16.04 LTS
sudo apt install nginx -y

# Fedora 24
sudo dnf install nginx -y

# Mac OS X
brew install nginx
```

安装完毕后配置文件在`/etc/nginx/`目录下。

<!-- more -->

#### 开机自动启动

开机启动在`/etc/rc.local`文件中添加nginx命令即可。

#### 常用命令

启动停止Nginx：

```Bash
# 查看Nginx的安装目录,一般在(/usr/local/nginx)下
whereis nginx

# 重启Nginx
sudo /etc/init.d/nginx restart

# 停止Nginx(legacy < Ubuntu 16.04)
sudo /etc/init.d/nginx stop
# Ubuntu 16.04 or higher or Fedora 24
sudo systemctl stop nginx
sudo service nginx stop
```

在修改配置文件后，可以输入如下命令检查配置文件的正确性：

```Bash
/usr/local/nginx/sbin/nginx -t
```

其中参数t表示测试配置文件，并退出，命令的结果为：

```
nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful
```

修改后使配置文件生效可以重启Nginx，不过更加方便的是重载Nginx：

```shell
sudo nginx -s reload
#命令写上绝对路径
sudo /usr/sbin/nginx -s reload
```

也可以输入如下命令查看Nginx帮助：

```Bash
/usr/local/nginx/sbin/nginx -h
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

#### 负载均衡(Load Balance)

Nginx除了作为常规的Web服务器外，还会被大规模的用于反向代理前端，因为Nginx的异步框架可以处理很大的并发请求，把这些并发请求hold住之后就可以分发给后台服务端(backend servers，也叫做服务池， 后面简称backend)来做复杂的计算、处理和响应，这种模式的好处是相当多的：隐藏业务主机更安全，节约了公网IP地址，并且在业务量增加的时候可以方便地扩容后台服务器。

{% asset_img loadbalance.png 负载均衡示意图%}

* 负载均衡算法

* 会话一致性

* 后台服务端的动态配置

* 基于DNS的负载均衡

Nginx的简单的负载均衡是HTTP Upstream模块，负载均衡的配置如下片段所示：

```
 upstream backend {
        server 192.168.1.2:8080;
        #server 192.168.1.3:28080 backup;
        #server 192.168.1.4:28080 backup;
        #server 192.168.1.5:8080 backup;
    }
```

nginx 的 upstream目前支持 4 种方式的分配
1)、轮询（默认）
      每个请求按时间顺序逐一分配到不同的后端服务器，如果后端服务器down掉，能自动剔除。
2)、weight
      指定轮询几率，weight和访问比率成正比，用于后端服务器性能不均的情况。
2)、ip_hash
      每个请求按访问ip的hash结果分配，这样每个访客固定访问一个后端服务器，可以解决session的问题。 
3)、fair（第三方）
      按后端服务器的响应时间来分配请求，响应时间短的优先分配。 
4)、url_hash（第三方）

upstream 每个设备的状态:

* down 表示单前的server暂时不参与负载
* weight  默认为1.weight越大，负载的权重就越大。
* max_fails ：允许请求失败的次数默认为1.当超过最大次数时，返回proxy_next_upstream 模块定义的错误
* fail_timeout:max_fails 次失败后，暂停的时间。
* backup： 其它所有的非backup机器down或者忙的时候，请求backup机器。所以这台机器压力会最轻。

#### 常见问题

##### 403 Forbidden

有时候当Nginx读取本地目录时会收到403错误，权限问题。先来了解一下Nginx的用户管理，Nginx在以Linux service脚本启动时，通过start-stop-domain启动，会以root权限运行daemon进程。然后daemon进程读取`/etc/nginx/nginx.conf`文件中的user配置选项，默认这里的user=nginx。也就是用nginx用户启动worker process。403错误就是因为nginx用户没有权限访问我当前开发用的用户目录，`/home/dean/work/resources`。解决方法是将user=nginx替换成root，然后重新启动nginx，可以了。

#####  the HTTP rewrite module requires the PCRE library

Nginx的Url rewrite模块依赖[PCRE](http://www.pcre.org/)(Perl Compatible Regular Expressionss)，The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5. PCRE has its own native API, as well as a set of wrapper functions that correspond to the POSIX regular expression API. The PCRE library is free, even for building proprietary software.在安装时提示 the HTTP rewrite module requires the PCRE library：

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

参考资料：

* [Nginx的负载均衡原理](http://kb.cnblogs.com/page/559213/)