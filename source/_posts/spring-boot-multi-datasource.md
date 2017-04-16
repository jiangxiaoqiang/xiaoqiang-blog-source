---

itle: spring-boot-multi-datasource
date: 2017-04-14 17:39:23
tags:
- Spring Boot
categories: Programming
---

#### 簡介

隨着項目的進行，需要同時操作多個不同的數據庫實例，涉及到多數據源的配置。

<!-- more -->

`JdbcTemplate`是Spring core包的核心类。它替我们完成了资源的创建以及释放工作，从而简化了我们对JDBC的使用。它还可以帮助我们避免一些常见的错误，比如忘记关闭数据库连接。JdbcTemplate将完成JDBC核心处理流程，比如SQL语句的创建、执行，而把SQL语句的生成以及查询结果的提取工作留给我们的应用代码。它可以完成SQL查询、更新以及调用存储过程，可以对`ResultSet`进行遍历并加以提取。它还可以捕获JDBC异常并将其转换成`org.springframework.dao`包中定义的，通用的，信息更丰富的异常。

#### 添加TargetSource

```shell
import java.lang.annotation.*;

/**
 * @Author: jiangxiaoqiang
 * Created by 4/13/17 on 6:54 PM.
 */
@Target({ ElementType.METHOD, ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface TargetDataSource {
    String name();
}
```

Java注解是附加在代码中的一些元信息，用于一些工具在编译、运行时进行解析和使用，起到说明、配置的功能。注解不会也不能影响代码的实际逻辑，仅仅起到辅助性的作用。包含在`java.lang.annotation`包中。

##### @Retention: 定义注解的保留策略

* @Retention(RetentionPolicy.SOURCE)   //注解仅存在于源码中，在class字节码文件中不包含
* @Retention(RetentionPolicy.CLASS)     // 默认的保留策略，注解会在class字节码文件中存在，但运行时无法获得
* @Retention(RetentionPolicy.RUNTIME)  // 注解会在class字节码文件中存在，在运行时可以通过反射获取到

##### @Target：定义注解的作用目标

@Target(ElementType.TYPE)   //接口、类、枚举、注解

@Target(ElementType.FIELD) //字段、枚举的常量

@Target(ElementType.METHOD) //方法

@Target(ElementType.PARAMETER) //方法参数

@Target(ElementType.CONSTRUCTOR)  //构造函数

@Target(ElementType.LOCAL_VARIABLE)//局部变量

@Target(ElementType.ANNOTATION_TYPE)//注解

@Target(ElementType.PACKAGE) ///包

 由以上的源码可以知道，他的elementType 可以有多个，一个注解可以为类的，方法的，字段的等等

##### @Document：说明该注解将被包含在javadoc中

##### @Inherited：说明子类可以继承父类中的该注解

其中@interface定義一個TargetSource的注解。


```
spring.datasource.primary.url=jdbc:dm://59.214.215.10:5236/DMSERVER
spring.datasource.primary.username=SYSDBA
spring.datasource.primary.password=SYSDBA
spring.datasource.primary.driver-class-name=dm.jdbc.driver.DmDriver
```

```
@Bean(name = "primaryJdbcTemplate")
public JdbcTemplate primaryJdbcTemplate(
        @Qualifier("primaryDataSource") DataSource dataSource) {
    return new JdbcTemplate(dataSource);
}
```