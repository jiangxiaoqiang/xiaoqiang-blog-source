---
title: Spring模块化配置
tags:
  - Spring
  - Configuration
categories: Programming
date: 2016-10-21 23:51:37
---


Spring的一大缺点就是配置文件非常多，想象如果没有注解扫描Bean，所有的Bean都配置在XML文件中，将会是一个噩梦，项目中会充斥着大量的配置文件。这也是Spring-Boot项目所要避免的问题之一，在做项目开发时，为了使配置显得有条理化，易于理解，可以采用Spring Import配置文件，项目中需要一个Spring的主文件，在Web.xml中指定Spring的主文件位置，主文件再Import各类配置文件。指定主文件如下代码片段所示：

<!-- more -->

```XML
<context-param>
	<param-name>contextConfigLocation</param-name>
	<param-value>classpath:spring-config/spring-main-config.xml</param-value>
</context-param>
```

其中<code>spring-main-config.xml</code>即是项目的Spring配置主文件。classpath是指WEB-INF文件夹下的classes目录,classpath 和 classpath* 区别是：classpath：只会到你的class路径中查找找文件;classpath*：不仅包含class路径，还包括jar文件中(class路径)进行查找.在部署完毕的WEB项目中，一般包含WEB-INF和META-INF文件夹。META-INF相当于一个信息包，目录中的文件和目录获得Java 2平台的认可与解释，用来配置应用程序、扩展程序、类加载器和服务manifest.mf文件，在用jar打包时自动生成。其中主配置文件中使用Import Resource如下代码片段所示：

```XML
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:util="http://www.springframework.org/schema/util"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans.xsd
    http://www.springframework.org/schema/aop
    http://www.springframework.org/schema/aop/spring-aop.xsd  
    http://www.springframework.org/schema/util
    http://www.springframework.org/schema/util/spring-util.xsd
    http://www.springframework.org/schema/context
    http://www.springframework.org/schema/context/spring-context.xsd">

	<description>spring主配置文件</description>

	<!-- 属性和配置文件读入 ,多个用逗号隔开 数据库参数和系统参数 -->
    <util:properties id="applicationProperties" location="classpath:application.properties" />
	<context:property-placeholder properties-ref="applicationProperties" ignore-resource-not-found="true" />

	<!-- 扫描注解@Component , @Service , @Repository。-->
	<context:component-scan
		base-package="main.src.*">
		<context:include-filter type="annotation"
			expression="org.aspectj.lang.annotation.Aspect" />
		<context:exclude-filter type="annotation"
			expression="org.springframework.stereotype.Controller" />
		<context:exclude-filter type="annotation"
			expression="org.springframework.web.bind.annotation.RestController" />
		<context:exclude-filter type="annotation"
			expression="org.springframework.web.bind.annotation.ControllerAdvice" />
	</context:component-scan>

	<!--aop 注解风格支持 proxy-targer-class默认false,用jdk动态代理,true是cglib .expose-proxy当前代理是否为可暴露状态,值是"ture",则为可访问。 -->
	<aop:aspectj-autoproxy expose-proxy="true"
		proxy-target-class="true" />
	<!--aop xml风格支持 -->
	<aop:config expose-proxy="true" proxy-target-class="true" />

	<!-- 导入其它spring配置文件 -->
	<import resource="classpath:spring-config/spring-filters.xml" />
	<import resource="classpath:spring-config/spring-datasource.xml" />
	<import resource="classpath:spring-config/spring-mybatis.xml" />
	<import resource="classpath:spring-config/spring-cache.xml" />
	<import resource="classpath:spring-config/spring-i18n.xml" />
	<import resource="classpath:spring-config/spring-json.xml" />
	<import resource="classpath:spring-config/spring-security.xml" />
	<import resource="classpath:spring-config/spring-exception.xml" />
	<import resource="classpath:spring-config/spring-log.xml" />
	<import resource="classpath:spring-config/spring-validator.xml" />
	<import resource="classpath:spring-config/spring-quartz.xml" />
	<import resource="classpath:spring-config/spring-socket-servlet.xml"/>
</beans>
```
