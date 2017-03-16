---
title: Gradle使用经验总结
date: 2016-12-27 16:23:37
tags:
- Gradle
categories: Tool
---

使用以下配置文件对Gradle的构建进行配置：

* Gradle构建脚本（build.gradle）指定了一个项目和它的任务。
* Gradle属性文件（gradle.properties）用来配置构建属性。
* Gradle设置文件（gradle.settings）对于只有一个项目的构建而言是可选的，如果我们的构建中包含多于一个项目，那么它就是必须的，因为它描述了哪一个项目参与构建。每一个多项目的构建都必须在项目结构的根目录中加入一个设置文件。

<!-- more -->

Gradle 是以 Groovy 语言为基础, 基于DSL (领域特定语言Domain Specifies language) 语法的自动化构建工具, 但是它增加了一些额外的特性, 这使得Gradle更加的容易去阐释构建.一个构建脚本能够包含任何Groovy语言的元素 ( Any language element except for statement labels), 每个构建脚本都使用UTF-8编码.

#### 为什么使用Gradle

* 与Maven和Ant相比较，Maven和Ant的XML配置文件比较复杂。
* Gradle提供更细粒度的操作，自由定制化空间大
* 与Maven和Ant完全兼容
* Gradle对多语言、多平台有更原生(natural)的支持
* DSL(Domain Specific Language)比XML更简洁高效

#### 手动安装Gradle

下载Gradle，解压到指定文件夹，在用户根目录下的`.bash_profile`文件中，设置环境变量如下代码片段所示。

```Bash
export GRADLE_HOME=/opt/local/tools/gradle-2.12
export PATH=$PATH:$SONAR_HOME/bin:$SONAR_SCANNER/bin:$GRADLE_HOME/bin

# 使环境变量生效
source .bash_profile
```

非手动安装时，可以输入如下命令查看gradle的home目录：

```Bash
gradle getHomeDir
# Mac下
brew info gradle
```

注意在Intellij Idea下设置gradle的目录为`/usr/local/Cellar/gradle/3.2.1/libexec`。

#### 基础

在Ubuntu 16.04 LTS中安装Gradle:

```Bash
sudo apt install gradle -y

# 安装指定版本的Gradle
sudo apt install -y gradle=2.12
```

如下列出了Gradle常用的命令：

```Bash
# 查看所有任务
gradle task
# 查看所有的任务(会列出task之间的依赖关系)
gradle task --all

# 查看所有项目(查看所有项目要切换到项目的根目录执行命令)
gradle projects

# 清楚app目录下的build文件夹
gradle clean

# 检查依赖并编译打包 （正式和测试）
gradle build

# 编译并打Debug包
gradle assembleDebug

# 编译并打Release包
gradle assembleRelease
```

定义一个依赖通常需要三个元素：

* group:创建该library的组织名，通常也会是包名，
* name :是该library的唯一标识
* version:该library的版本号

一个简单的打包命令：

```Bash
gradle -p cc-web-boot bootRun
```

-p参数指定项目(project directory)的目录，如果不指定就是当前目录(-p, --project-dir,Specifies the start directory for Gradle. Defaults to current directory)。bootRun指代的是当前项目下的任务名称。打包完成后，生成的包文件在对应项目文件的build/libs目录下。使用命令查看当前property：

```Bash
# 查看当前所有的Property
gradle properties
```

其中allprojects表示所有的Project，在多项目构建中，它将包含多个Project；buildDir表示构建结果的输出目录。

#### 构建(build)

##### 构建常见问题

###### 错误: 编码GBK的不可映射字符

在使用Gradle部署的时候出现此错误，原因是由于java源文件的编码采用的是UTF-8编码，而本地Java编译器默认的编码采用的是操作系统的默认编码，在Window 7下默认是GBK，所以出现了此错误。解决方法就是显示指定JDK编译器的编码为UTF-8。在系统环境变量中增加一个变量，变量名为: `JAVA_TOOL_OPTIONS`， 变量值为：`-Dfile.encoding=UTF-8`，保存，重新打开命令提示符，再运行一次刚刚的构建的命令即可。

#### Resolving dependencies ':classpath'

在使用命令构建时一直停留在`Resolving dependencies ':classpath'`输出，无法往下进行构建。此时可以检查Maven的URL是否可以正常访问，此处是最初使用的地址是公司内部的局域网中的Maven仓库，在客户现场后即无法访问公司的内部网路，将原来无法访问的局域网的地址`htttp://dn6:8078`修改为广域网Maven公共仓库的地址`http://repox.gtan.com:8078`即可。由此可以知道原因是Maven的Url此时指定的是内网的URL，而当前电脑无法连接到内网的服务器，所以会一直停留在解析依赖的输出，将Maven仓库的URL改为外网即可成功构建。

#### 插件(Plugin)

插件就是Gradle的扩展，简而言之就是为你添加一些非常有用的默认配置。Gradle 自带了很多插件，并且你也可以很容易的编写和分享自己的插件。Java plugin 作为其中之一，为你提供了诸如编译，测试，打包等一些功能。插件配置示例：

```
apply plugin: 'java'
apply plugin: 'propdeps'
apply plugin: 'org.springframework.boot'
```

如上写法为旧式写法(Legacy)。另一种使用二进制插件的写法如下：

```
plugins {
    id 'java'
}
```

Gradle常用的插件有：

| 插件名称  | 用途                                       |
| ----- | ---------------------------------------- |
| java  | Gradle是一个通用构建工具，也就是说，它不单是为Java而生。比如，还可以做Groovy，Scala的构建。这取决于使用什么样的插件。大部分Java项目的基本步骤都非常类似，编译Java源代码，运行单元测试，拷贝生成的class文件到目标目录，打包Jar文件（或者war包，ear包），而这些重复且约定俗成的任务，如果可以不用写一行构建代码就实现就完美了。Maven就做到这一点，采用约定优于配置的思想，预先定义常用的任务，并定义它们的执行顺序。Gradle吸收了Maven的这个优点，通过插件，实现预定义任务和任务之间依赖关系的导入，这样就可以在一行代码都不写的情况下，直接使用已经定义的任务。 |
| war   | War 的插件继承自 Java 插件并添加了对组装 web 应用程序的 WAR 文件的支持。它禁用了 Java 插件生成默认的 JAR archive，并添加了一个默认的 WAR archive 任务。 War 插件添加了两个依赖配置： `providedCompile`和`providedRuntime`。虽然它们有各自的`compile`和`runtime`配置，但这些配置有相同的作用域，只是它们不会添加到 WAR 文件中。 |
| scala | Scala 的插件继承自 Java 插件并添加了对 Scala 项目的支持。它可以处理 Scala 代码，以及混合的 Scala 和 Java 代码，甚至是纯 Java 代码。该插件支持联合编译，联合编译可以通过 Scala 及 Java 的各自的依赖任意地混合及匹配它们的代码。例如，一个 Scala 类可以继承自一个 Java 类，而这个 Java 类也可以继承自一个 Scala 类。这样一来，我们就能够在项目中使用最适合的语言，并且在有需要的情况下用其他的语言重写其中的任何类。 |

##### 插件属性(Plugin Properties)

Java插件有一些扩展属性:

```
# Java version compatibility to use when compiling Java source.
sourceCompatibility = 1.8
# Java version to generate classes for.
targetCompatibility = 1.8
```

#### SourceSet和项目布局

Java插件引入了一个概念叫做SourceSets，它代表了一组源文件，通过修改SourceSets中的属性，可以指定哪些源文件（或文件夹下的源文件）要被编译，哪些源文件要被排除。Gradle就是通过它实现Java项目的布局定义。

Java插件默认实现了两个SourceSet，main和test。每个SourceSet都提供了一系列的属性，通过这些属性，可以定义该SourceSet所包含的源文件。比如，java.srcDirs，resources.srcDirs。Java插件中定义的其他任务，就根据main和test的这两个SourceSet的定义来寻找产品代码和测试代码等。

#### Wrapper

Wrapper主要是考虑在没有安装Gradle的电脑上使用Gradle命令。当执行gradlew(Gradle Wrapper)命令时，首先会检查电脑是否安装了Gradle，如果没有安装，会自动从gradle repository下载安装。注意安装不会真的在计算机中安装Gradle的发行版本，它会下载Gradle，存放在目录`$USER_HOME/.gradle/wrapper/dists`下，构建时使用命令调用而不是直接添加到当前计算机(试想如果不同的Gradle版本，如果添加到系统的环境变量了，构建时到底是以调用哪一个版本的Gradle呢)。需要查看Gradle Wrapper帮助，在命令行中输入如下命令：

```Bash
gradle Wrapper --help
```

会打印出所有Gradle Wrapper.Most tools require installation on your computer before you can use them. If the installation is easy, you may think that’s fine. But it can be an unnecessary burden on the users of the build. Equally importantly, will the user install the right version of the tool for the build? What if they’re building an old version of the software? The Gradle Wrapper (henceforth referred to as the “Wrapper”) solves both these problems and is the preferred way of starting a Gradle build.需要添加Wrapper，在gradle.build中添加如下block:

```
task wrapper(type: Wrapper) {
    description = 'Generates gradlew[.bat] scripts'
    gradleVersion = '3.2.1'
}
```

或者执行命令：

```Bash
gradle wrapper --gradle-version 3.2.1
```

命令执行之后，会生成wrapper任务脚本，和如下文件夹及文件：

```
gradlew
gradlew.bat
    gradle/wrapper/
    gradle-wrapper.jar
    gradle-wrapper.properties
```

在gradle-wrapper.properties中的gradle_user_home ，默认是用户的home目录。

```
Note, «GRADLE_USER_HOME» defaults to «USER_HOME»/.gradle, 
where «USER_HOME» is the home directory of the current user. 
This location can be configured via the -g 
and --gradle-user-home command line switches, 
as well as by the GRADLE_USER_HOME environment variable 
and org.gradle.user.home JVM system property.
```

#### Gradle界面(GUI)

在终端中输入如下命令可以查看Gradle的GUI：

```Bash
gradle --gui
```

#### 软件包管理

安装指定版本的软件可以使用如下命令：

```Bash
sudo apt install gradle=2.12
```

其中gradle是软件包的名称，2.12是软件包的版本。

#### 运行特定项目的任务

此处运行项目cc-web-boot下的bootRepackage任务：

```Bash
./gradlew build -p cc-web-boot/ bootRepackage -x test
```

如上命令在项目文件夹cc-web-boot下执行构建，并排除test任务，生成对应的jar包。bootRepackage任务依赖于Gradle assemble任务，assemble任务会编译程序中的源代码，并打包生成Jar文件，这个任务不执行单元测试。不使用spring-boot插件，主程序jar包，与依赖的jar包是分开的，需要分别打包，这在云环境中，上传部署比较麻烦，得传多个文件（或者上传前，先压缩成一个包，再传到服务器上解压），服务器节点多时，操作起来太累又重复。而使用spring-boot插件，会自动将依赖的包集成到主包里，非常方便。

#### 多项目构建

使用gradle构建多项目时，setting.gradle文件时必须存在的。并且要包含多个项目，示例如下：

```
include "dolphin-framework", "dolphin-common"
```

在多项目构建时，指定多项目共同的中央仓库，可以使用allproject块,如下代码片段所示。

```
allprojects {
    repositories {
        maven { url 'http://repox.gtan.com:8078' }
        mavenCentral()
        jcenter()
    }
}
```

mavenCentral指代Maven的中央仓库(Maven central repository)，jcenter指代的是Java中央仓库(JCenter repository)。在构建项目时，IDE中可能看不到jar包的下载进度(如：Intellij Idea)，此时可以切换到命令行模式，执行`gradle build`命令，可以看到构建的进度，比如文件下载的进度等。

#### buildscript

buildscript中的声明是gradle脚本自身需要使用的资源。可以声明的资源包括依赖项、第三方插件、maven仓库地址等。而在build.gradle文件中直接声明的依赖项、仓库地址等信息是项目自身需要的资源。

gradle是由groovy语言编写的，支持groovy语法，可以灵活的使用已有的各种ant插件、基于jvm的类库，这也是它比maven、ant等构建脚本强大的原因。虽然gradle支持开箱即用，但是如果你想在脚本中使用一些第三方的插件、类库等，就需要自己手动添加对这些插件、类库的引用。而这些插件、类库又不是直接服务于项目的，而是支持其它build脚本的运行。所以你应当将这部分的引用放置在buildscript代码块中。gradle在执行脚本时，会优先执行buildscript代码块中的内容，然后才会执行剩余的build脚本。buildscript脚本的简单示例如下：

```
buildscript {
    ext {
        springBootVersion = '1.4.2.RELEASE'
        jacksonVersion = '2.8.4'
        tomcatVersion = '7.0.70'
        springfoxVersion = '2.6.1'
        poiVersion = "3.14"
    }
    repositories {
        maven { url 'http://repox.gtan.com:8078' }
        mavenCentral()
        jcenter()
        maven { url 'http://repo.spring.io/plugins-release' }
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:${springBootVersion}")
        classpath 'org.springframework.build.gradle:propdeps-plugin:0.0.7'
    }
}
```

其中，ext为扩展属性(Extra properties),All enhanced objects in Gradle's domain model can hold extra user-defined properties. This includes, but is not limited to, projects, tasks, and source sets. Extra properties can be added, read and set via the owning object's ext property. Alternatively, an ext block can be used to add multiple properties at once.扩展属性在buildscript中指定后，可以在整个gradle脚本中使用(${属性名})。使用命令`gradle buildEnvironment`，可以打印出扩展属性到依赖关系图。


Note, «GRADLE_USER_HOME» defaults to «USER_HOME»/.gradle, where «USER_HOME» is
the home directory of the current user. This location can be configured via the -g and --gradle-user-home command line switches, as well as by the GRADLE_USER_HOME environment variable and org.gradle.user.home JVM system property.

#### 设置源码路径

在混合编程中，需要设置不同开发语言的源码路径，如下代码片段所示：

```
sourceSets {
    main {
        scala {
            srcDirs = ['src/main/scala', 'src/main/java']
        }
        java {
            srcDirs = []
        }
    }
    test {
        scala {
            srcDirs = ['src/test/scala', 'src/test/java']
        }
        java {
            srcDirs = []
        }
    }
}
```

#### Gradle构建生命周期(Gradle Build Lifecycle)

关于Gradle构建的生命周期，全部都是Gradle用户使用手册里面的内容，这里仅仅是摘抄而已，可以直接下载用户手册进行阅读。

初始化阶段(Initialization):Gradle supports single and multi-project builds. During the initialization phase, Gradle determines which projects are going to take part in the build, and creates a Project instance for each of these projects.

配置阶段(Configuration):During this phase the project objects are configured. The build scripts of all projects which are part of the build are executed. Gradle 1.4 introduced an incubating opt-in feature called configuration on demand . In this mode, Gradle configures only relevant projects.

执行阶段(Execution):Gradle determines the subset of the tasks, created and configured during the configuration phase, to be executed. The subset is determined by the task name arguments passed to the gradle command and the current directory. Gradle then executes each of the selected tasks.

Gradle构建流程如下,这是在实际执行Gradle构建指令后窗口输出的内容：processResources -> compileJava -> classes -> jar。

{% asset_img gradle-build-workflow.jpg Gradle构建流程%}

Gradle构建时，会先构建依赖包，再构建主要的包。每个包的构建按照上图的流程反复执行。processResources任务拷贝资源到生产环境的resource目录下(Copies production resources into the production resources directory).

#### Intellij Idea构建Gradle版本

在Intellij Idea中使用Gradle Wrapper构建时，有时明明指定的是某一个版本，Intellij Idea却去下载另一个版本，例如在build.gradle中指定的是3.2.1版本，而Intellij Idea却下载Gradle 2.13版本。此时需要执行命令：

```shell
# 刷新gradle wrapper（regenerate the wrapper with gradle(w) wrapper after changing gradleVersion）
./gradlew wrapper
# 指定版本
./gradlew wrapper --gradle-version 3.2.1
```

参考资料：

* [Multi-project Builds](https://docs.gradle.org/current/userguide/multi_project_builds.html)

* [Gradle Userguide]()

* [Gradle Build Language Reference](https://docs.gradle.org/current/dsl/)

* [Gradle学习笔记](https://blog.gmem.cc/gradle-study-note)