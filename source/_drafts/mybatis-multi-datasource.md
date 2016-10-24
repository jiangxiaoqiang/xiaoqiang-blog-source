---
title: MyBatis多数据源
tags:
- MyBatis
- MySQL
- HBase
- Multi-Datasource
categories: Programming
---

有时需要将数据向不同的数据源写入，例如基础数据需要向MySQL中写入，实时的数据需要写入HBase中，此时就需要一套映射框架向不同数据源写入数据。此时在MyBatis中的配置如下：

```XML
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tx="http://www.springframework.org/schema/tx"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans.xsd
    http://www.springframework.org/schema/tx
    http://www.springframework.org/schema/tx/spring-tx.xsd">
	<description>Spring 整合 MyBatis</description>
	<!-- 在基本的MyBatis中，session 工厂可以使用SqlSessionFactoryBuilder.来创建。在MyBatis-Spring中，使用了SqlSessionFactoryBean来替代。 -->
	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource" />
		<!-- 指定sqlMapConfig总配置文件，订制的environment在spring容器中不在生效 -->
		<property name="configLocation" value="classpath:mybatis.xml" />
	</bean>
	<!-- Mybatis 映射文件路径 用逗号隔开 -->
	<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
		<property name="basePackage" value="main.src.*" />
		<property name="sqlSessionFactoryBeanName" value="sqlSessionFactory" />
	</bean>
	<!-- hbase -->
	<bean id="sqlSessionFactory2" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource2" />
		<property name="configLocation" value="classpath:mybatis2hbase.xml" />
	</bean>

	<!-- HBase扫描与其他Bean扫描互斥,HBase的Bean只能由此进行扫描 -->
	<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
		<property name="basePackage" value="com.zw.oil.repository" />
		<property name="sqlSessionFactoryBeanName" value="sqlSessionFactory2" />
	</bean>
</beans>
```
