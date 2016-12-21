---
title: git使用
date: 2016-12-19 23:34:02
tags:
---

Git是目前世界上最先进的分布式版本控制系统，没有之一。Git有什么特点？简单来说就是：高端大气上档次！逼格那是相当高，装逼必备神器。当你说用Git管理源码的时候，逼格瞬间高好几个档次。最近项目中在用，结合以前使用的经验，简单的总结记录在此。

<!-- more -->

#### 常用命令

```Bash
#列出分支
git branch
```

查看提交历史：

```Bash
git log --graph --all
```

#### 发起pull request

创建(check out)分支v1_xiaoqiang：

```
git checkout -b v1_xiaoqiang
```

将新的分之合并到origin分支中：

```Bash
git push origin v1_xiaoqiang
```

到GitLab页面里创建一个pull request即可。

#### 更新

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

#### Stash

“‘储藏”“可以获取你工作目录的中间状态——也就是你修改过的被追踪的文件和暂存的变更——并将它保存到一个未完结变更的堆栈中，随时可以重新应用。往堆栈推送一个新的储藏，只要运行：

```Bash
git stash
```

查看储藏：

```Bash
git stash list
```

应用储藏：

```Bash
git stash apply
```


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
