---
title: Spring Boot多数据源配置
date: 2017-04-14 17:39:23
tags:
- Spring Boot
categories: Programming
---

#### 簡介

隨着項目的進行，需要同時操作多個不同的數據庫實例，涉及到多數據源的配置。

<!-- more -->

`JdbcTemplate`是Spring core包的核心类。它替我们完成了资源的创建以及释放工作，从而简化了我们对JDBC的使用。它还可以帮助我们避免一些常见的错误，比如忘记关闭数据库连接。JdbcTemplate将完成JDBC核心处理流程，比如SQL语句的创建、执行，而把SQL语句的生成以及查询结果的提取工作留给我们的应用代码。它可以完成SQL查询、更新以及调用存储过程，可以对`ResultSet`进行遍历并加以提取。它还可以捕获JDBC异常并将其转换成`org.springframework.dao`包中定义的，通用的，信息更丰富的异常。

#### 指定多數據源配置

```
#
# 基础数据源
#
spring.datasource.type=com.zaxxer.hikari.HikariDataSource
spring.datasource.url=jdbc:dm://192.168.1.102:5236/DMSERVER
#spring.datasource.url=jdbc:dm://cqxyrw
spring.datasource.driver-class-name=dm.jdbc.driver.DmDriver
spring.datasource.username=dolphin
spring.datasource.password=123456

# 更多数据源
custom.datasource.names=ds1
custom.datasource.ds1.type=com.zaxxer.hikari.HikariDataSource
custom.datasource.ds1.driver-class-name=dm.jdbc.driver.DmDriver
custom.datasource.ds1.url=jdbc:dm://192.168.1.101:5236/DMSERVER
custom.datasource.ds1.username=dolphin
custom.datasource.ds1.password=123456
```

#### 实例化不同数据源实现

可以通过实例化不同的Datasource，进而实例化不同的JdbcTemplate，在方法中使用不同的JdbcTemplate而实现多数据源。

##### 配置Bean

注入Datasource与JdbcTemplate配置：

```Java
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;

/**
 * Created by jiangxiaoqiang on 17-4-17.
 */
@Configuration
public class DataSourceConfig {
    @Bean
    @Primary
    @ConfigurationProperties(prefix = "spring.datasource")
    public DataSource primaryDataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean
    @Primary
    public JdbcTemplate primaryJdbcTemplate(DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }

    @Bean(name = "secondaryDataSource")
    @Qualifier("secondaryDataSource")
    @ConfigurationProperties(prefix = "custom.datasource.ds1")
    public DataSource secondaryDataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "secondaryJdbcTemplate")
    public JdbcTemplate secondaryJdbcTemplate(
            @Qualifier("secondaryDataSource") DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }
}
```

注意这里需要在主数据源上添加@Primary注解，表示主数据源优先选择，如果使用非主数据源，则在注入的时候使用@Qualifier进行限定。

##### 注入JdbcTempldate

```Java
@Autowired@Qualifier("secondaryJdbcTemplate")
private JdbcTemplate secondaryJdbcTemplate;
```


##### 使用JdbcTemplate

```Java
public void findAll2() {
    String sql = "select * from A";      
    List<Map<String, Object>> list = secondaryJdbcTemplate.queryForList(sql);
    System.out.print(list.get(0));
}
```


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

#### 指定數據源


```Java
public List<Corporation> findAll2() {
        String sql = "select * from A";
        DataSource ds1 = DynamicDataSourceRegister.customDataSources.get("ds1");
        jdbcTemplate.setDataSource(ds1);
        return (List<Corporation>) jdbcTemplate.query(sql, new RowMapper<Corporation>() {

            @Override
            public Corporation mapRow(ResultSet rs, int rowNum) throws SQLException {
                Corporation c = new Corporation();
                String d = rs.getString("ID");
                c.setId(d);
                return c;
            }

        });
    }
```