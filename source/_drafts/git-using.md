---
title: git-using
tags:
---

#### 常用命令

```Bash
#列出分支
git branch
```

查看提交历史：

```Bash
git log --graph --all
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

