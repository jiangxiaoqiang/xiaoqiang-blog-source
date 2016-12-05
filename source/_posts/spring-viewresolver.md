---
title: Spring视图解析器
date: 2016-12-02 17:32:27
tags:
- Spring
categories: Programming
---

#### InternalResourceViewResolver

在Sprinng MVC中，Handler执行完成后，向DispatcherServlet返回一个ModelAndView对象。此时就需要调用视图解析器(View Resolver)来渲染视图了。

<!-- more -->

```XML
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
    <property name="prefix" value="/WEB-INF/views/"/>
    <property name="suffix" value=".jsp"/>
</bean>
```

它是URLBasedViewResolver的子类，所以URLBasedViewResolver支持的特性它都支持。单从字面意思来看，可以把InternalResourceViewResolver解释为内部资源视图解析器，这就是InternalResourceViewResolver的一个特性。InternalResourceViewResolver会把返回的视图名称都解析为InternalResourceView对象，InternalResourceView会把Controller处理器方法返回的模型属性都存放到对应的request属性中，然后通过RequestDispatcher在服务器端把请求forword重定向到目标URL。比如在InternalResourceViewResolver中定义了prefix=/WEB-INF/，suffix=.jsp，然后请求的Controller处理器方法返回的视图名称为test，那么这个时候InternalResourceViewResolver就会把test解析为一个InternalResourceView对象，先把返回的模型属性都存放到对应的HttpServletRequest属性中，然后利用RequestDispatcher在服务器端把请求forword到/WEB-INF/test.jsp。注意InternalResourceViewResolver只能渲染jsp页面，如果需要渲染html看[这里](http://stackoverflow.com/questions/20564336/internalresourceviewresolver-to-resolve-both-jsp-and-html-together)。

#### ThymeleafViewResolver

在Java世界的MVC框架里，使用的视图技术不少，最基本的是JSP，还有知名的FreeMarker和Velocity等模板引擎。Thymeleaf也是一款优秀的模板引擎，它在HTML5/XHTML的视图层表现的很好，也能在离线情况下处理任何XML文件。它是完全可以替代JSP+JSTL(JSP Standard Tag Library，JSP标准标签库)的。

Thymeleaf官方的Q&A：

Q: 和FreeMarker,Velocity相比，Thymeleaf表现得怎样呢？

A：FreeMarker和Velocity都是软件领域杰出的作品，但它们在解决模板问题上的处理哲学和Thymeleaf不一样。Thymeleaf强调的是自然模板，也就是允许模板作为产品原型使用(笔者注:因为其后缀名就是.html，可以直接在浏览器打开)，而FreeMarker和Velocity不行。并且Thymeleaf的语法更简洁、更和目前Web开发的趋势相一致。其次，从架构的角度看，FreeMarker和Velocity更像个文本处理器，所以它们能够处理很多类型的内容，而Thymeleaf是基于XML的，只能处理XML格式的数据。因此这样看，FreeMarker和Velocity更通用些，但恰恰如此，Thymeleaf更能利用XML的特性，尤其是在Web应用中。

```XML
<!-- thymeleaf thymeleafViewResolver-->
<bean class="org.thymeleaf.spring4.view.ThymeleafViewResolver">
    <property name="templateEngine" ref="templateEngine" />
    <property name="characterEncoding" value="UTF-8" />
</bean>
```
