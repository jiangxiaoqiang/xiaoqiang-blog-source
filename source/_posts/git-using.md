---
title: Git使用技巧与经验总结
date: 2016-12-19 23:34:02
tags:
---

Git是目前世界上最先进的分布式版本控制系统，没有之一。Git有什么特点？简单来说就是：高端大气上档次！逼格那是相当高，装逼必备神器。当你说用Git管理源码的时候，逼格瞬间高好几个档次。最近项目中在用，结合以前使用的经验，简单的总结记录在此。另外Git在网络慢或者不稳定时，表现也很'好。

<!-- more -->

#### 常用命令

列出当前的Git配置：

```Bash
# 列出Git的配置，实际上是将.git目录下的config文件显示出来
git config --list
```

可以进入.git目录，命令所列出来的内容，实际上就是config文件里面的内容。

```Bash
#列出分支
git branch
```

查看提交历史：

```Bash
git log --graph --all
```

Git保存用户名和密码：

```Bash
# 是否保存认证信息
git config credential.helper store
```

注意是否保存认证信息仅仅是规定在当前库(repository)是否保存认证信息，不是git全局设置，其他库如果需要保存认证信息，需要单独执行此命令。使用`git config --list`命令查看当前库所有的配置。

Git查看Url：

```Bash
git remote -v
```

#### 添加(Add)

在使用Git的过程中，使用命令：

```Bash
# 添加当前目录的所有文件到暂存区
git add .
```

没有添加某一部分子目录的文件，让我有点郁闷，最后切换到那个目录下手动添加修改后(Modified)的文件。按理说应该是添加当前目录下所有的文件和子文件夹啊，百思不得其解。原来是由于子目录下的远程库的地址与当前库不一致所导致,子目录下还是next主题的URL,而不是当前库的URL,将子目录下的远程库的地址修改为当前库的地址即可:

```Bash
git remote set-url --add origin https://github.com/jiangxiaoqiang/xiaoqiang-blog-source.git
```

其中,origin是远程库的名字.添加了新地址后，原来的地址还存在，可使用`git config --list`命令查看，同时，使用如下命令删除原来的旧的远程地址：

```Bash
git remote set-url --delete origin https://github.com/iissnan/hexo-theme-next
```

#### 发起pull request

新建(check out)分支v1_xiaoqiang：

```
git checkout -b v1_xiaoqiang
```

| 参数 | 含义 |
|--------|--------|
| -b <branch> |  create and checkout a new branch  |
| -B <branch> |  create/reset and checkout a branch |

将新的分之push到origin分支中：

```Bash
git push origin v1_xiaoqiang
```

到GitLab页面里创建一个pull request即可。

#### 关于Commit的建议

* **one thing one commit**:在提交commit的时候尽量保证这个commit只做一件事情，比如实现某个功能或者修改了配置文件。
* **easy to read**:清楚的表达这个commit做了什么。
* **cherry-pick**:cherry-pick将Commit从一个分之拷贝到另一个分支，如果每个Commit包含的特性太多，那么就不能完美的pick出想要的特性。
* **code review**:易于别人做code review。

```
# 50-character subject line
#
# 72-character wrapped longer description. This should answer:
#
# * Why was this change necessary?
# * How does it address the problem?
# * Are there any side effects?
#
# Include a link to the ticket, if any.
```

常见的修改类型如下：

* feat (feature)
* fix (bug fix)
* docs (documentation)
* style (formating, missing semi colons, …)
* refactor
* test (when adding missing tests)
* chore (maintain)

#### 更新(update)

采用git pull时，提示如下：

```
hldev@hldev-100:~/hldata/backend/credit-system$ git pull
Username for 'http://dn6': xiaoqiang.jiang
Password for 'http://xiaoqiang.jiang@dn6':
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

    git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

    git branch --set-upstream-to=origin/<branch> v1_xiaoqiang
```

指定本地dev分支与远程origin/dev分支的链接，根据提示，设置dev和origin/dev的链接：

```Bash
git branch --set-upstream-to origin/v1 v1_xiaoqiang
```

#### 合并(merge)

下面是使用过的一个合并步骤,切换到v1分支，v1分支是开发的主分支：

```Bash
git checkout v1
```

将远程分支更新获取并合并到v1分支：

```Bash
git pull origin v1
```

查看当前分支：

```Bash
git branch
```

假如当前分支为名称：v1_xiaoqiang,将v1分支合并到当前分支：

```Bash
#切换到v1_xiaoqiang分支
git checkout v1_xiaoqiang
#将v1分支合并到当前分支（v1_xiaoqiang）
git merge v1
```

关闭文件对比(合并)工具后，辅助文件都会自动删除，但同时会生成一个test.txt.orig的文件，orig是original的缩写，内容是解决冲突前的冲突现场。默认该.orig文件可能不会自动删除，需要手动删除。

#### 撤销合并

使用git show命令查看父编号(parent number):

```Bash
git show s868dfa3e5267578eeec73947f334320740885f56
```

显示的内容如下：

```
commit 868dfa3e5267578eeec73947f334320740885f56
Merge: 0995c73 6d3ef06
Author: jiangxiaoqiang <jiangtingqiang@gmail.com>
Date:   Fri Jan 6 09:30:15 2017 +0800

    Merge branch 'v1' of http://dn6/backend/credit-system into v1
```

The first one is the first parent, the second one is the second parent。取消合并：

```Bash
git revert -m 1 HEAD
```

1就是1，表示0995c73对应的父来源，2表示6d3ef06对应的父来源。要撤销的那条merge线的编号,HEAD表示merge前的版本号。

#### 拉取（Pull）

git pull的作用是取回远程主机某个分支的更新，再与本地指定分之合并。实际包含2步操作，git fetch和git merge。

```
git pull <远程主机名>　<远程分支名>：<本地分支名>
```

比如取回origin主机的next分支，与本地的master分支合并，写成下面这样：

```Bash
git pull origin next:master
```

远程分支与当前分支合并，冒号后的内容可以省略：

```Bash
git pull origin next
```

等同于先做fetch，再做merge。

```Bash
git fetch origin
git merge origin/next
```

有时，当前仓库不止包含一个远程分支，比如一份代码存放在公司内网的git仓库中，一份代码存放在外网的仓库中。使用`git config --list`命令可查看。此时拉取时，指定不同的主机即可，例如：

```Bash
git pull osc v1
```

其中osc为远程主机的主机名，v1为本地分支。

TS_B_PJZC_T_SP_SXRMD

#### 储藏(Stash)

“‘储藏”“可以获取你工作目录的中间状态——也就是你修改过的被追踪的文件和暂存的变更——并将它保存到一个未完结变更的堆栈中，随时可以重新应用。往堆栈推送一个新的储藏，只要运行：

```Bash
git stash
```

查看所有储藏：

```Bash
git stash list
```

输出的内容如下：

```
hldev@hldev-100:~/hldata/backend/credit-system$ git stash list
stash@{0}: WIP on v1_xiaoqiang: ac284e4 refactor:根据属性名获取属性值优化
```

其中WIP代表:Work In Progress，应用储藏：

```Bash
git stash apply
```

丢弃储藏：

```Bash
git stash drop
```

drop后可以跟储藏的编号，如果没有指定，默认丢弃最新一次储藏。

#### 日志信息(log)

查看提交日志，常用的命令如下：

```Bash
git log --oneline --graph
```

提交日志一个有趣的应用是自动生成周报。如果要在每周五上交周报，那么可以运行如下命令：

```Bash
git log --author="jiangxiaoqiang" --after="1 week ago" --oneline
```

将输出的内容稍加编辑，即可生成一份简单的周报，当然前提是在每次提交的时候需要认真对待提交信息的填写，否则生成的内容也是没什么意义的。

#### 远程仓库(remote)

添加远程仓库：

```Bash
git remote add osc https://github.com/jiangxiaoqiang/xiaoqiang-blog-source.git
```

其中osc为远程仓库的名称，https://github.com/jiangxiaoqiang/xiaoqiang-blog-source.git为远程仓库的地址。


#### Your branch and 'origin/master' have diverged

If you absolutely sure this is your case then you can force Git to push your changes:

```Bash
#force push changes
git push origin master -f
```

##### Changes not staged for commit

```Bash
git stash
```

#### Please, commit your changes or stash them before you can merge

出现这个问题的原因是其他人修改了文件并提交到版本库中去了，而你本地也修改了xxx.php，这时候你进行git pull操作就好出现冲突了。
