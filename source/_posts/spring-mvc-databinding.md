---
title: Spring MVC数据绑定流程
date: 2016-12-14 22:16:26
tags:
- Spring MVC
categories: Programming
---

SpringMVC主框架将ServletRequest对象及目标方法的入参实例传递给WebDataBinderFactory实例，以创建DataBinder实例对象。DataBinder调用装配在SpringMVC上下文中的ConversionService组件进行数据类型转换、数据格式化工作。将Servlet中的请求信息填充到入参对象中。调用Validator组件对已经绑定了请求消息的入参对象进行数据合法性校验，并最终生成数据绑定结果。

<!-- more -->

{% asset_img spring-mvc-databinding-process.png Spring MVC数据绑定过程图 %}

#### 到DispatcherServlet

客户端的请求到达服务端，首先到DispatcherServlet(org.springframework.web.servlet)的doService方法中。DispatcherServlet通过HandlerMapping获得HandlerExecutionChain，然后获得HandlerAdapter。请求方法参数的处理、响应返回值的处理，分别是HandlerMethodArgumentResolver和HandlerMethodReturnValueHandler，这两个接口都是Spring3.1版本之后加入的。


#### 执行请求


```Java
public Object invokeForRequest(NativeWebRequest request, ModelAndViewContainer mavContainer,
			Object... providedArgs) throws Exception {
	Object[] args = getMethodArgumentValues(request, mavContainer, providedArgs);
	if (logger.isTraceEnabled()) {
		logger.trace("Invoking '" + ClassUtils.getQualifiedMethodName(getMethod(), getBeanType()) +
				"' with arguments " + Arrays.toString(args));
	}
	Object returnValue = doInvoke(args);
	if (logger.isTraceEnabled()) {
		logger.trace("Method [" + ClassUtils.getQualifiedMethodName(getMethod(), getBeanType()) +
				"] returned [" + returnValue + "]");
	}
	return returnValue;
}
```
