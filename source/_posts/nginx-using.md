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

#### rewrite

```shell
location /main {
        root   /home/hldev/hldata/frontend/credit-system-frontend/dist;
        rewrite ^/(?!js|css).*$ /main/index.html break;
}
```

以上rewrite正則表達式表示，/後不緊接js或css字符的url鏈接。

#### location

每个 url 请求都会对应的一个服务，nginx 进行处理转发或者是本地的一个文件路径，或者是其他服务器的一个服务路径。而这个路径的匹配是通过 location 来进行的。我们可以将 server 当做对应一个域名进行的配置，而 location 是在一个域名下对更精细的路径进行配置。

```
location /api{
      proxy_pass http://dn5:28080;
      proxy_redirect off;
}
```

将前缀为api的请求发送到地址：`http://dn5:28080`。如下配置，指定项目根目录的默认首页为`index.html`，如果不指定默认首页，那么就需要在URL中明确指定首页。

```bash
location / {
        root   /home/app/frontend/credit-system-frontend/dist;
        index index.html;
}
```

#### 负载均衡(Load Balance)

Nginx除了作为常规的Web服务器外，还会被大规模的用于反向代理前端，因为Nginx的异步框架可以处理很大的并发请求，把这些并发请求hold住之后就可以分发给后台服务端(backend servers，也叫做服务池， 后面简称backend)来做复杂的计算、处理和响应，这种模式的好处是相当多的：隐藏业务主机更安全，节约了公网IP地址，并且在业务量增加的时候可以方便地扩容后台服务器。

{% asset_img loadbalance.png 负载均衡示意图%}

* 负载均衡算法

* 会话一致性

* 后台服务端的动态配置

* 基于DNS的负载均衡

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
sudo yum -y install pcre-devel openssl openssl-devel
 
./configure --prefix=/usr/local/nginx
make
make install
```

##### error while loading shared libraries: libpcre.so.0: cannot open shared object file: No such file or directory

在使用命令`nginx -s reload`刷新时提示错误：

```
error while loading shared libraries: libpcre.so.0: cannot open shared object file: No such file or directory
```

执行命令：

```shell
ldd which /usr/local/nginx/sbin/nginx
```

ldd命令用于打印程序或者库文件所依赖的共享库列表(print shared library dependencies)。比如需要看ls命令依賴哪些庫，可以輸入命令`ldd /bin/ls`，注意需要是全路徑。提示如下：

```
nginx:
        linux-vdso.so.1 =>  (0x00007ffd71300000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fb80682a000)
        libdl.so.2 => /lib64/libdl.so.2 (0x00007fb806625000)
        libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007fb8063ee000)
        libpcre.so.0 => not found
        libssl.so.10 => /lib64/libssl.so.10 (0x00007fb80617f000)
        libcrypto.so.10 => /lib64/libcrypto.so.10 (0x00007fb805d95000)
        libz.so.1 => /lib64/libz.so.1 (0x00007fb805b7f000)
        libc.so.6 => /lib64/libc.so.6 (0x00007fb8057bd000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fb806a5c000)
        libfreebl3.so => /lib64/libfreebl3.so (0x00007fb8055ba000)
        libgssapi_krb5.so.2 => /lib64/libgssapi_krb5.so.2 (0x00007fb80536c000)
        libkrb5.so.3 => /lib64/libkrb5.so.3 (0x00007fb805084000)
        libcom_err.so.2 => /lib64/libcom_err.so.2 (0x00007fb804e80000)
        libk5crypto.so.3 => /lib64/libk5crypto.so.3 (0x00007fb804c4e000)
        libkrb5support.so.0 => /lib64/libkrb5support.so.0 (0x00007fb804a3e000)
        libkeyutils.so.1 => /lib64/libkeyutils.so.1 (0x00007fb80483a000)
        libresolv.so.2 => /lib64/libresolv.so.2 (0x00007fb804620000)
        libselinux.so.1 => /lib64/libselinux.so.1 (0x00007fb8043f8000)
        libpcre.so.1 => /lib64/libpcre.so.1 (0x00007fb804197000)
```

原因可能是操作系统升级到了CentOS 7.3版本，没有对应的模块libpcre.so.0，只有对应的模块libpcre.so.1。使用如下命令可以快速解决问题：

```shell
# ln的功能是为某一个文件在另外一个位置建立一个同步的链接.当我们需要在不同的目录，用到相同的文件时，我们不需要在每一个需要的目录下都放一个必须相同的文件，我们只要在某个固定的目录，放上该文件，然后在 其它的目录下用ln命令链接（link）它就可以，不必重复的占用磁盘空间。這裏是將/lib64/libpcre.so.0鏈接到/lib64/libpcre.so.1，當程序訪問/lib64/libpcre.so.0時，自動訪問/lib64/libpcre.so.1
link /usr/lib64/libpcre.so.1 /lib64/libpcre.so.0
```

##### ERR\_INCOMPLETE\_CHUNKED_ENCODING

进入nginx日志查看：

```
2017/04/07 18:31:20 [crit] 7928#0: *33 open() "/home/app/local/tengine/proxy_temp/7/00/0000000007" failed (13: Permission denied) while reading upstream, client: 2.1.27.53, server: , request: "GET /pubapi/global/homePage HTTP/1.1", upstream: "http://192.168.1.2:28080/pubapi/global/homePage", host: "192.168.1.2", referrer: "http://192.168.1.2/"
```

原来是nginx没有目录`/home/app/local/tengine/proxy_temp`权限导致此问题。在配置文件中修改:

```shell
# user为/home/app/local/tengine/proxy_temp目录的属主
user  {user};
```


参考资料：

* [Nginx的负载均衡原理](http://kb.cnblogs.com/page/559213/)
