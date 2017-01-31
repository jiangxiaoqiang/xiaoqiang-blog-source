---
title: 使用命令行编译运行Java
date: 2017-01-08 00:12:31
tags:
- Java
- Javac
categories: Programming
---

在旧的电脑上打开IDE还是比较慢的，有时只需要运行一段很小的代码片段(Snippet),没有必要搬出IDE,所以就直接使用命令来编译,逼格高,速度快.

<!-- more -->

直接新建一个Java文件,名字叫xiaoqiang.java,输入简单的内容:

```Java
public class xiaoqiang{
      public static void main(String args[]){
        System.out.println("My name is xiaoqiang.");
      }
    }
```

保存后,输入如下命令编译:

```Bash
# Java编译器(Compiler)
javac xiaoqiang.java
```

编译完毕后,会生成一个xiaoqiang.class文件.输入如下命令运行程序:

```Bash
java xiaoqiang
```

输出为:My name is xiaoqiang.以后就可以直接写代码片段了,查看效果就可以简单的用命令搞定即可.研究一些代码片段非常方便.

#### 编译参数

有时在编译Java代码时会指定各种参数，如下的gradle脚本所示：

 ```
 compileJava {
    options.encoding = 'UTF-8'
    options.compilerArgs << "-Xlint:deprecation" << "-Xlint:unchecked" << "-Xlint:-options" << "-Xlint:unchecked"
    dependsOn(processResources)
}
 ```

其中制定了编译的编码为UTF-8.-X参数含义可以在终端中执行命令`javac -help`进行查看(Print a synopsis of nonstandard options)。查看-X更详细的说明可以使用`javac -X`命令。关于Xlint的说明：

```
-Xlint                     Enable recommended warnings
-Xlint:{all,auxiliaryclass,cast,classfile,deprecation,dep-ann,divzero,empty,fallthrough,finally,options,overloads,overrides,path,processing,rawtypes,serial,static,try,unchecked,varargs,-auxiliaryclass,-cast,-classfile,-deprecation,-dep-ann,-divzero,-empty,-fallthrough,-finally,-options,-overloads,-overrides,-path,-processing,-rawtypes,-serial,-static,-try,-unchecked,-varargs,none} Enable or disable specific warnings
```
