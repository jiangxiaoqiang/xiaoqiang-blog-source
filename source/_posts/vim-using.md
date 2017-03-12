---
title: vim使用经验与技巧总结
date: 2016-12-24 23:51:47
tags:
- vim
categories: Programming
---


#### 替換（substitute）

```shell
:[range]s/pattern/string/[c,e,g,i]
# 示例
:%s/dn5/dn6/g
```

将文件中所有的dn5替换成dn6。`:%s/dn5/dn6/g`会在全局范围(`%`)查找`dn5`并替换为`dn6`，所有出现都会被替换（`g`）。

<!-- more -->


| 命令      | 作用                                       |
| ------- | ---------------------------------------- |
| range   | 指的是範圍，1,7 指從第一行至第七行，1,$ 指從第一行至最後一行，也就是整篇文章，也可以 % 代表。還記得嗎？ % 是目前編輯的文章，# 是前一次編輯的文章。 |
| pattern | 就是要被替換掉的字串，可以用 regexp 來表示。               |
| tring   | 將pattern 由 string 所取代。                   |
| c       | confirm，每次替換前會詢問。                        |
| e       | 不顯示 error。                               |
| g       | globe，不詢問，整行替換。                          |
| i       | ignore 不分大小寫。                            |


g 大概都是要加的，否則只會替換每一行的第一個符合字串。可以合起來用，如 cgi，表示不分大小寫，整行替換，替換前要詢問是否替換。

#### 常用命令


| 命令           | 作用                        |
| ------------ | ------------------------- |
| shift + g(G) | 跳转到文件末尾                   |
| :行号          | 在命令行模式下，冒号后输入数字，即可跳转到指定行中 |
| yy           | 拷贝当前行                     |
| P/p(paste)   | 粘贴                        |
| $            | 到一行的行尾                    |
| 0            | 到一行的行首                    |
| %d           | 删除全部内容(在命令行模式下)           |
| ggdG         | 删除全部内容(在插入模式下)            |
| d$           | 从当前位置开始删除，直到行尾            |
| u            | 取消编辑(undo)                |

在命令行模式下，输入斜杠，输入需要搜索的单词。匹配的单词会自动高亮，按n继续搜索下一个匹配结果，按#搜索上一个匹配结果。
/pattern 向下搜索 n继续搜索下一个
?pattern 向上搜索 #继续搜索上一个

#### 文件编码

有时在打开由Windows传输的文件时显示乱码，由于Windows操作系统下默认是采用的GBK编码，而Ubuntu下默认采用的是UTF-8编码，所以打开的时候会显示乱码。解决此问题可以在打开文件的时候指定编码，就不会出现乱码的情况了，以VIM编辑器为例，使用如下命令指定打开文件的编码：

```shell
vim file_name -c "e ++enc=GBK"
#实例
vim 最新脚本.sql -c "e ++enc=GBK"
```

此时可以正常无乱码查看文件了，此时如果想将此文件保存为UTF-8格式的文件，在下一次打开时就可以不用显示指定参数了，可以输入如下命令保存：

```shell
:w ++enc=utf-8 最新脚本utf-8.sql
```

保存后会生成一个新的以utf-8编码的文件`最新脚本utf-8.sql`。

#### vim获取文件权限

有时在使用vim打开文件后保存时，提示没有权限。此时当然可以退出再以sudo命令打开编辑的文件，或者保存到临时的文件中再执行mv命令。但是还有一种更好的方法，输入如下命令：

```shell
:w !sudo tee % 
```

此时文件即成功保存。此处利用了在vim中执行外部命令，在vim中执行外部命令的格式为：

```shell
#语法
:!<cmd>
#示例
:!ls
```

#### 插件管理Vundle

在vim中输入version命令可以查看vimrc文件的位置。在Fedora系统中，相关配置文件的位置为：

```
system vimrc file: "/etc/vimrc"
     user vimrc file: "$HOME/.vimrc"
 2nd user vimrc file: "~/.vim/vimrc"
      user exrc file: "$HOME/.exrc"
       defaults file: "$VIMRUNTIME/defaults.vim"
  fall-back for $VIM: "/etc"
 f-b for $VIMRUNTIME: "/usr/share/vim/vim80"
```

如果在Home目录下没有.vimrc文件，使用`touch .vimrc`命令手动创建。在Vim中插件管理使用Vundle。Vundle是基于Git仓库的插件管理软件。Vundle将插件的安装简化为类似yum软件安装的过程，只要:BundleInstall插件安装，:BundleClean插件卸载。BundleSearch插件名搜索插件。




##### The NERD Tree

`Ctr + w + h`光标focus左侧树形目录，ctrl+w+l 光标focus右侧文件显示窗口。多次摁 ctrl+w，光标自动在左右侧窗口切换。输入:q回车，关闭光标所在窗口



| 命令           | 作用                        |
| ------------ | ------------------------- |
| Ctrl + w + h | 光标focus左侧树形目录              |

如果需要搜索文件，直接在树形目录的Tab页输入斜杠命令后键入搜索关键字即可。