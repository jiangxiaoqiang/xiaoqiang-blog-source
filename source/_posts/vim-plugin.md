---
title: Vim插件
date: 2017-03-12 23:40:55
tags:
- Plugin
categories: Tool
---

#### Vim-airline

一款状态栏增强插件，可以让你的Vim状态栏非常的美观。

<!-- more -->

安装vim-airline插件首先在`.vimrc`文件中添加插件名称`Plugin ‘bling/vim-airline'`，添加完毕后执行Vundle插件安装命令`:PluginInstall`命令安装插件。插件安装完毕后还未立即生效，在Vim配置文件`.vimrc`中添加如下配置即可生效：

```
" vim-airline
set laststatus=2 " 永远显示状态栏
```

效果如下图所示：

{% asset_img vim-plugin-airline.jpg Vim airline状态栏显示插件 %}

#### Vundle

Vundle是一款管理插件的插件。安装Vundle输入如下命令：

```shell
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

配置Vundle：

```
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
```

#### Ctrlp

ctrlp是一款相当棒的插件，主要的功能是对文件进行模糊的查找，如果你的project目录结构复杂，或者你正在阅读一个较大的项目的话，那么ctrlp可以帮你快速的定位到你想要文件。安装Ctrlp，在`.vimrc`文件中加入：

```shell
# 使用的Vundle版本是0.10.2,较早版本的写法是Bundle 'ctrlpvim/ctrlp.vim'
Plugin 'ctrlpvim/ctrlp.vim'
```

在Vim中执行命令`:PluginInstall`即可安装。安装完毕后，使用Vim打开文件夹，可以直接输入`Ctrl + P`快捷键调出Ctrlp的模糊搜索功能。输入需要搜索的关键字，匹配的文件出来后，可以按下`Ctrl + j/k`快捷键进行上下选择。选定需要打开的文件后，使用快捷键`Ctrl +x/v`水平/垂直分屏打开文件。按下`Ctrl + t`在新的Tab中打开文件。

#### NERD Tree

树形的文件浏览。

#### Vim Powerline



代码补全（YouCompleteMe，语法检查（syntastic），文件模糊搜索（ctrlp），显示vim状态栏（Vim Powerline）,主题颜色（Molokai）,显示文件结构（tagbar）
