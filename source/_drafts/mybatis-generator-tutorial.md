---
MyBatis-Generator使用
---

新建MyBatis-Generator配置文件generatorConfig.xml：

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
  PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
  "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
<generatorConfiguration>
    <!--数据库驱动-->
    <classPathEntry location="mysql-connector-java-5.0.8-bin.jar"/>
    <context id="DB2Tables" targetRuntime="MyBatis3">
        <commentGenerator>
            <property name="suppressDate" value="true"/>
            <property name="suppressAllComments" value="true"/>
        </commentGenerator>
        <!--数据库链接地址账号密码-->
        <jdbcConnection driverClass="com.mysql.jdbc.Driver" connectionURL="jdbc:mysql://localhost/dolphin" userId="root" password="123456">
        </jdbcConnection>
        <javaTypeResolver>
            <property name="forceBigDecimals" value="false"/>
        </javaTypeResolver>
        <!--生成Model类存放位置-->
        <javaModelGenerator targetPackage="dolphin.pojo" targetProject="D:\OneDrive\SourceCode\Dolphin\dolphin\src\main\java">
            <property name="enableSubPackages" value="true"/>
            <property name="trimStrings" value="true"/>
        </javaModelGenerator>
        <!--生成映射文件存放位置-->
        <sqlMapGenerator targetPackage="dolphin.mapping" targetProject="D:\OneDrive\SourceCode\Dolphin\dolphin\src\main\java">
            <property name="enableSubPackages" value="true"/>
        </sqlMapGenerator>
        <!--生成Dao类存放位置-->
        <javaClientGenerator type="XMLMAPPER" targetPackage="dolphin.dao" targetProject="D:\OneDrive\SourceCode\Dolphin\dolphin\src\main\java">
            <property name="enableSubPackages" value="true"/>
        </javaClientGenerator>
        <!--生成对应表及类名-->
        <table tableName="user_t" domainObjectName="Messgae" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false"></table>
    </context>
</generatorConfiguration>
```

生成文件命令：

``` bash
java -jar "D:\My Documents\EGDownloads\mybatis-generator-1.3.5\mybatis-generator-core-1.3.5\lib\mybatis-generator-core-1.3.5.jar" -configfile generatorConfig.xml -overwrite
```
运行以上程序时会提示如下错误：

<code>Exception in thread "main" java.lang.RuntimeException: Cannot resolve classpath entry: mysql-connector-java-5.0.8-bin.jar</code>

将mysql-connector-java-5.0.8-bin.jar放在当前目录下。


## 新建一个Maven Web项目

### Create a new post

File-->New Project,选择Maven Project如下图所示。

![](images\build-ssm-frame\select-maven-project.png)

## 集成Spring



``` bash
$ hexo new "My New Post"
```

More info: [Writing](https://hexo.io/docs/writing.html)

### Run server

``` bash
$ hexo server
```

More info: [Server](https://hexo.io/docs/server.html)

### Generate static files

``` bash
$ hexo generate
```

More info: [Generating](https://hexo.io/docs/generating.html)

### Deploy to remote sites

``` bash
$ hexo deploy
```

More info: [Deployment](https://hexo.io/docs/deployment.html)
