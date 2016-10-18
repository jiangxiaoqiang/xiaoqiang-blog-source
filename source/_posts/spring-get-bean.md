---
title: Spring线程中Bean注入问题
tags:
  - Spring
  - Bean
categories: Programming
date: 2016-10-18 17:20:11
---


#### 实现ApplicationContextAware

在Spring中开启线程时，无法使用Bean的自动注入，此时需要手动获取Bean。方法如下：

<!-- more -->

```Bash
public class SpringApplicationContextHolder implements ApplicationContextAware {
	private static ApplicationContext context;

	@Override
	public void setApplicationContext(ApplicationContext context) throws BeansException {
		SpringApplicationContextHolder.context = context;
	}

	public static Object getSpringBean(String beanName) {
		return context == null ? null : context.getBean(beanName);
	}

	public static String[] getBeanDefinitionNames() {
		return context.getBeanDefinitionNames();
	}
}
```

#### 配置文件注册

在Spring中注册工具类的bean：

```XML
<bean class="com.zw.socket.service.kafka.comsumer.SpringApplicationContextHolder"></bean>
```

#### 获取Bean

获取Bean实例：

```Bash
ClientMessageTransfer clientMessageTransfer=(ClientMessageTransfer)SpringApplicationContextHolder.getSpringBean("clientMessageTransfer");
```


