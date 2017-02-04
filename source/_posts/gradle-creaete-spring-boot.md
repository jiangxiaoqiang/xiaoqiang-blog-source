---
title: Gradle搭建项目
date: 2017-02-01 19:28:41
tags:
---

#### 创建一个Spring-Boot项目

##### 初始化

```Bash
gradle init
```

##### 增加配置




#### 多项目构建




* 一个多项目构建必须在根项目的根目录下包含settings.gradle文件，因为它指明了那些包含在多项目构建中的项目。
* 如果需要在多项目构建的所有项目中加入公用的配置或行为，我们可以将这项配置加入到根项目的build.gradle文件中(使用allprojects)。
* 如果需要在根项目的子项目中加入公用的配置或行为，我们可以将这项配置加入到根项目的build.gradle文件中(使用subprojects)。


#### 常见问题


##### call 'refresh' before multicasting events via the context

启动Spring Boot程序时报如下错误：


** WARNING ** : Your ApplicationContext is unlikely to start due to a @ComponentScan of the default package.

详细日志如下：

```
2017-02-03 18:32:33.444  WARN 15138 --- [           main] ionWarningsApplicationContextInitializer : 

** WARNING ** : Your ApplicationContext is unlikely to start due to a @ComponentScan of the default package.


2017-02-03 18:32:39.340  WARN 15138 --- [           main] ationConfigEmbeddedWebApplicationContext : Exception encountered during context initialization - cancelling refresh attempt: org.springframework.beans.factory.BeanDefinitionStoreException: Failed to parse configuration class [Application]; nested exception is org.springframework.context.annotation.ConflictingBeanDefinitionException: Annotation-specified bean name 'errorPageFilter' for bean class [org.springframework.boot.web.support.ErrorPageFilter] conflicts with existing, non-compatible bean definition of same name and class [org.springframework.boot.context.web.ErrorPageFilter]
2017-02-03 18:32:39.344 ERROR 15138 --- [           main] o.s.b.f.s.DefaultListableBeanFactory     : Destroy method on bean with name 'org.springframework.boot.autoconfigure.internalCachingMetadataReaderFactory' threw an exception

java.lang.IllegalStateException: ApplicationEventMulticaster not initialized - call 'refresh' before multicasting events via the context: org.springframework.boot.context.embedded.AnnotationConfigEmbeddedWebApplicationContext@51a9ad5e: startup date [Fri Feb 03 18:32:33 CST 2017]; root of context hierarchy
	at org.springframework.context.support.AbstractApplicationContext.getApplicationEventMulticaster(AbstractApplicationContext.java:404) [spring-context-4.3.5.RELEASE.jar:4.3.5.RELEASE]
	at org.springframework.context.support.ApplicationListenerDetector.postProcessBeforeDestruction(ApplicationListenerDetector.java:97) ~[spring-context-4.3.5.RELEASE.jar:4.3.5.RELEASE]
	at org.springframework.beans.factory.support.DisposableBeanAdapter.destroy(DisposableBeanAdapter.java:253) ~[spring-beans-4.3.5.RELEASE.jar:4.3.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.destroyBean(DefaultSingletonBeanRegistry.java:578) [spring-beans-4.3.5.RELEASE.jar:4.3.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.destroySingleton(DefaultSingletonBeanRegistry.java:554) [spring-beans-4.3.5.RELEASE.jar:4.3.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.destroySingleton(DefaultListableBeanFactory.java:959) [spring-beans-4.3.5.RELEASE.jar:4.3.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.destroySingletons(DefaultSingletonBeanRegistry.java:523) [spring-beans-4.3.5.RELEASE.jar:4.3.5.RELEASE]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.destroySingletons(DefaultListableBeanFactory.java:966) [spring-beans-4.3.5.RELEASE.jar:4.3.5.RELEASE]
	at org.springframework.context.support.AbstractApplicationContext.destroyBeans(AbstractApplicationContext.java:1033) [spring-context-4.3.5.RELEASE.jar:4.3.5.RELEASE]
	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:555) [spring-context-4.3.5.RELEASE.jar:4.3.5.RELEASE]
	at org.springframework.boot.context.embedded.EmbeddedWebApplicationContext.refresh(EmbeddedWebApplicationContext.java:122) [spring-boot-1.4.3.RELEASE.jar:1.4.3.RELEASE]
	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:761) [spring-boot-1.4.3.RELEASE.jar:1.4.3.RELEASE]
	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:371) [spring-boot-1.4.3.RELEASE.jar:1.4.3.RELEASE]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:315) [spring-boot-1.4.3.RELEASE.jar:1.4.3.RELEASE]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1186) [spring-boot-1.4.3.RELEASE.jar:1.4.3.RELEASE]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1175) [spring-boot-1.4.3.RELEASE.jar:1.4.3.RELEASE]
	at Application.main(Application.java:12) [main/:na]
```

是由于不能直接将application.java 文件放在main/java文件夹下，必须要新建一个包把他放进去。
>>>>>>> 4009afc05e30f3d939a628afa06ad3698f5cd3ea
