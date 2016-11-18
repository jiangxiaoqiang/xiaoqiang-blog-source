---
title: Redmine安装
date: 2016-11-15 18:48:19
tags:
---

#### Redmine简介

Redmine 是一个网页界面的项目管理与缺陷跟踪管理系统的自由及开放源代码软件工具。它集成了项目管理所需的各项功能：日历、燃尽图和甘特图 以协助可视化表现项目与时间限制，问题跟踪和版本控制。此外，Redmine也可以同时处理多个项目。
Redmine 是以 Ruby on Rails 撰写的架构，它横跨多个平台与数据库，它的设计很明显是受一些类似功能软件包的Trac所影响。此外，它也是Bitnami 应用库的一部分。

<!-- more -->

安装的环境是CentOS 7.2，查看CentOS版本可以使用命令：

```Bash
cat /etc/redhat-release
```

安装前查看[Redmine版本的对应关系](http://www.redmine.org/projects/redmine/wiki/RedmineInstall)。


#### 安装依赖包(Install pre-dependencies)

使用如下命令安装依赖包。

```Bash
yum -y install libyaml-devel zlib-devel curl-devel openssl-devel httpd-devel apr-devel apr-util-devel gcc ruby-devel gcc-c++ make postgresql-devel ImageMagick-devel sqlite-devel perl-LDAP mod_perl perl-Digest-SHA
```



#### 安装Ruby(Install Ruby)

```Bash
cd ~/Downloads  # YOUR FOLDER OF CHOICE
ftp ftp.ruby-lang.org
```

如果ftp未安装，输入如下命令安装ftp。

```Bash
yum install -y ftp
```

从FTP上获取Ruby安装文件：

```Bash
ftp> Anonymous  # USERLOGIN
ftp> 'none', just hit Enter  # NO PASSWORD
ftp> cd /pub/ruby
ftp> get get ruby-1.8.7-p358.tar.gz  # XXX is currently 358, as of 03/2012
ftp> bye
```

也可以使用wget下载安装文件，此处采用此种方式，使用wget命令下载能够看到文件下载的进度，FTP方式等了许久没有响应，遂放弃，采用wget下载：

```Bash
wget ftp://ftp.ruby-lang.org/pub/ruby/ruby-1.8.7-p358.tar.gz
```

解压安装文件：

```Bash
tar zxvf ruby-1.8.7-p358.tar.gz
```

安装：

```Bash
cd ruby-1.8.7.p358
./configure
make
make install
```

编译Ruby源码需要GCC(GNU C Compiler)，如果编译时提示没有安装GCC，输入如下命令安装：

```Bash
yum install gcc gcc-c++ kernel-devel
```

#### 安装Ruby(Install Ruby (Option 2))

```Bash
yum install ruby
```

检查安装是否成功：

```Bash
ruby -v
```

#### 安装RubyGems 1.4.2

RubyGems是一个方便而强大的Ruby程序包管理器(RubyGems is a package management framework for Ruby. )，Ruby的第三方插件是用gem方式来管理，非常容易发布和共享，一个简单的命令就可以安装上第三方的扩展库。特点：能远程安装包，包之间依赖关系的管理，简单可靠的卸载，查询机制，能查询本地和远程服务器的包信息，能保持一个包的不同版本，基于Web的查看接口，能查看你安装的gem的信息。更换gem源为Ruby中国的源。默认的官方源因为网络问题速度慢.

```Bash
#删除官方源
gem sources --remove https://rubygems.org/
#添加Ruby中国源，添加源的时间比较久
#没有进度提示，所以需要耐心等待
#大概在10几分钟左右
gem sources --add https://gems.ruby-china.org/
#查询gem源记录
gem sources –l
```



```Bash
wget http://production.cf.rubygems.org/rubygems/rubygems-1.4.2.tgz
tar zxvf rubygems-1.4.2.tgz
cd rubygems-1.4.2
ruby setup.rb
gem -v
```

#### 安装Ruby on Rails

安装Rails 4.2版本。

```Bash
gem install rails -v=4.2
```

提示错误：


```
ERROR:  Error installing rails:
        ERROR: Failed to build gem native extension.

    /usr/bin/ruby extconf.rb
mkmf.rb can't find header files for ruby at /usr/share/include/ruby.h

```

输入如下命令即可解决：

```Bash
yum -y install gcc mysql-devel ruby-devel rubygems
```

安装完毕后输入如下命令查看版本。

```Bash
rails -v
```


#### 安装Redmine

下载安装包：

```Bash
wget http://www.redmine.org/releases/redmine-3.3.1.tar.gz
```

解压缩：

```Bash
tar zxvf redmine-3.3.1.tar.gz
```

#### 数据库配置(Link Redmine to the Database)



```Bash
#登录数据库
mysql -u root -p
#重置密码
alter user root@localhost identified by '$zwkj123456ZWKJ';
#创建数据库
create database redmine character set utf8;
#创建用户
create user 'redmine'@'localhost' identified by '$zwkj123456ZWKJ';
#添加权限
grant all privileges on redmine.* to 'redmine'@'localhost';
```

##### Configure database.yml

```Bash
cd /var/www/redmine/config
cp database.yml.example database.yml
nano database.yml
```

#### Rails配置(Rails Settings)

安装bundler：

```Bash
gem install bundler --verbose
```

安装依赖：

```Bash
#切换到redmine目录
#redmine目录下有安装时需要的配置文件
#所以需要切换到此目录下运行bundle命令
cd /var/www/redmine
bundle install
```

输出如下：

```Bash
[root@localhost redmine]# bundle install
Don't run Bundler as root. Bundler can ask for sudo if it is needed, and installing your bundle as root will break this
application for all non-root users on this machine.
/usr/share/gems/gems/psych-2.0.0/lib/psych.rb:98: warning: already initialized constant Psych::VERSION
/usr/share/ruby/psych.rb:98: warning: previous definition of VERSION was here
/usr/share/gems/gems/psych-2.0.0/lib/psych.rb:101: warning: already initialized constant Psych::LIBYAML_VERSION
/usr/share/ruby/psych.rb:101: warning: previous definition of LIBYAML_VERSION was here
Fetching gem metadata from https://rubygems.org/..........
Fetching version metadata from https://rubygems.org/..
Fetching dependency metadata from https://rubygems.org/.
Resolving dependencies...
Using rake 11.3.0
Using i18n 0.7.0
Installing json 1.8.3 with native extensions
Using minitest 5.9.1
Using thread_safe 0.3.5
Using builder 3.2.2
Using erubis 2.7.0
Using mini_portile2 2.1.0
Using rack 1.6.5
Using mime-types-data 3.2016.0521
Using arel 6.0.3
Using public_suffix 2.0.4
Using bundler 1.13.6
Installing ffi 1.9.14 with native extensions
Using coderay 1.1.1
Using concurrent-ruby 1.0.2
Using docile 1.1.5
Using htmlentities 4.3.1
Using thor 0.19.1
Using metaclass 0.0.4
Using mimemagic 0.3.2
Using multi_json 1.12.1
Installing mysql2 0.3.21 with native extensions
Using net-ldap 0.12.1
Using ruby-openid 2.3.0
Using rbpdf-font 1.19.0
Installing rdoc 5.0.0
Installing redcarpet 3.3.4 with native extensions
Using request_store 1.0.5
Installing rmagick 2.16.0 with native extensions
Using rubyzip 1.2.0
Using websocket 1.2.3
Using simplecov-html 0.9.0
Using yard 0.9.5
Using tzinfo 1.2.2
Using nokogiri 1.6.8.1
Using rack-test 0.6.3
Using mime-types 3.1
Installing addressable 2.5.0
Installing childprocess 0.5.9
Using sprockets 3.7.0
Installing mocha 1.2.1
Installing rack-openid 1.4.2
Installing rbpdf 1.19.0
Installing simplecov 0.9.2
Installing activesupport 4.2.7.1
Using loofah 2.0.3
Installing xpath 2.0.0
Using mail 2.6.4
Installing css_parser 1.4.6
Installing selenium-webdriver 3.0.1
Using rails-deprecated_sanitizer 1.0.3
Using globalid 0.3.7
Installing activemodel 4.2.7.1
Using rails-html-sanitizer 1.0.3
Installing capybara 2.10.1
Installing roadie 3.2.0
Using rails-dom-testing 1.0.7
Installing activejob 4.2.7.1
Installing activerecord 4.2.7.1
Installing protected_attributes 1.1.3
Installing actionview 4.2.7.1
Installing actionpack 4.2.7.1
Installing actionmailer 4.2.7.1
Installing actionpack-action_caching 1.1.1
Installing actionpack-xml_parser 1.0.2
Installing railties 4.2.7.1
Using sprockets-rails 3.2.0
Installing jquery-rails 3.1.4
Installing roadie-rails 1.1.1
Installing rails 4.2.7.1
Bundle complete! 31 Gemfile dependencies, 71 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.
```

```Bash
#安装依赖软件
gem install bundler
```

初始化redmine数据库：

```Bash
rake db:migrate RAILS_ENV=production
rake redmine:plugins:migrate RAILS_ENV=production
rake tmp:cache:clear
rake tmp:sessions:clear
```

#### 启动Redmine

启动Redmine：

```Bash
#查找rails安装目录
whereis rails
#切换到redmine目录下(此步骤不可缺)
cd /var/www/redmine
#启动redmine
ruby /usr/local/bin/rails server webrick -e production –d

bundle exec rake assets:precompile RAILS_ENV=production

```

#### 常见问题

访问地址`http://localhost:3000`时提示错误：

```Bash
Missing `secret_token` and `secret_key_base` for 'production' environment, set these values in `config/secrets.yml`
```

Rails的安全机制需要一个秘钥。在Rails 4.x版本的时候, 秘钥的设置在`RAILS_ROOT/config/secrets.yml`。在非生产环境下, 秘钥都是'明文', '硬编码', 写在secrets.yml里面的。这种方式会由于源代码的泄露, 造成安全问题, 所以这种方式存在安全隐患。所以Rails要求在生产环境下, 通过操作系统的环境变量来设置秘钥, 这样相对比较稳妥。

这里可以采取2种方法:

　　1. 自己动手, 利用linux系统的机制来设置环境变量 SECRET_KEY_BASE = XXX

　　2. 使用GEM dotenv-deployment帮你设置, 具体机制和方法1本质没区别。

PS: Rails产生秘钥的指令: `rake secret RAILS_ENV=production`, 会产生一个秘钥。这里我选择方法2, 利用/etc/profile.d/ 下面添加脚本的方式来设置秘钥:

```Bash
#产生一个秘钥
rake secret RAILS_ENV=production
export SECRET_KEY_BASE=生成的Key
#查看设置的Key
echo $SECRET_KEY_BASE
```


然后刷新你的shell,`echo $SECRET_KEY_BASE`, 输出成功，重新启动计算机。访问`http://localhost:3000`。如果无法访问，检查防火墙是否允许3000端口，或者关闭防火墙即可。如果需要在外网访问，需要绑定地址：

```Bash
#参数b表示绑定(bind)
ruby /usr/local/bin/rails server webrick -e production –d -b 192.168.24.221
```

参考资料：

[Redmine on CentOS installation HOWTO](http://www.redmine.org/projects/redmine/wiki/Redmine_on_CentOS_installation_HOWTO)

[rails production secret_key的设置](http://www.cnblogs.com/mahong-shaojiu-ruby/p/5707771.html)

[centos6.7安装redmine系统](http://muzizero.blog.51cto.com/6059241/1783563)