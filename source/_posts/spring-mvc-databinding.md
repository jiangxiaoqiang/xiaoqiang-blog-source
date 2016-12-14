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
