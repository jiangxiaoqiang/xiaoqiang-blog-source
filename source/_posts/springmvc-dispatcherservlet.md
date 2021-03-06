---
title: Spring MVC-DispatcherServlet处理请求过程
---

Spring MVC基于模型-视图-控制器(Model-View-Controller,MVC)模式，它能够帮助我们建立灵活和松耦合的Web程序.Spring MVC中用户请求如下图所示：

<!-- more -->

{% asset_img example.jpg DispatcherServlet处理请求过程%}


#### 请求发出(HTTP Resquest)

一个请求携带信息进入Spring MVC程序时，第一站是Spring的DispatcherServlet(在web.xml中配置)，它是接收所有用户请求的前端控制器Servlet。DispatcherServlet对请求URL进行解析，得到请求资源标识符（URI）。然后根据该URI，调用HandlerMapping获得该Handler配置的所有相关的对象（包括Handler对象以及Handler对象对应的拦截器），最后以HandlerExecutionChain对象的形式返回；DispatcherServlet的任务是将请求转发给Spring MVC控制器(Controller)，控制器是用于处理用户请求的Spring Bean。DispatcherServlet根据获得的Handler，选择一个合适的HandlerAdapter。（如果成功获得HandlerAdapter后，此时将开始执行拦截器的preHandler()方法），获得Handler的代码如下,在DispatherServlet类的doDispatch方法中：

```Java
// Determine handler adapter for the current request.
HandlerAdapter ha = getHandlerAdapter(mappedHandler.getHandler());
```

#### 处理器映射(Handler Mapping)

一般程序中会有不止一个控制器，那么DispatcherServlet需要知道将请求发送给哪个控制器，所以DispatcherServlet将会查询处理器映射(handler mapping)来确定请求的下一站，处理器映射会根据用户请求的URL来决定是哪个控制器。提取Request中的模型数据，填充Handler入参，开始执行Handler（Controller)。 在填充Handler的入参过程中，根据你的配置，Spring将帮你做一些额外的工作：

* HttpMessageConveter： 将请求消息（如Json、xml等数据）转换成一个对象，将对象转换为指定的响应信息
* 数据转换：对请求消息进行数据转换。如String转换成Integer、Double等
* 数据根式化：对请求消息进行数据格式化。 如将字符串转换成格式化数字或格式化日期等
* 数据验证： 验证数据的有效性（长度、格式等），验证结果存储到BindingResult或Error中

#### 控制器(Controller)

DispatcherServlet选择了控制器之后，就会将请求发送给该控制器并等待控制器处理用户请求。控制器在完成了逻辑处理后，通常会返回处理结果并将这些结果在浏览器上显示，这些信息在Spring MVC中成为模型(Model)。Handler执行完成后，向DispatcherServlet 返回一个ModelAndView对象。调用handle方法的接口定义HandlerAdapter在spring-webmvc包中。

```Java
/**
    * Use the given handler to handle this request.
    * The workflow that is required may vary widely.
    * @param request current HTTP request
    * @param response current HTTP response
    * @param handler handler to use. This object must have previously been passed
    * to the {@code supports} method of this interface, which must have
    * returned {@code true}.
    * @throws Exception in case of errors
    * @return ModelAndView object with the name of the view and the required
    * model data, or {@code null} if the request has been handled directly
    */
ModelAndView handle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception;
```



#### 模型以及逻辑视图名称(Model)

控制器仅仅返回模型信息往往是不够的，需要对模型信息进行格式化，生成用户友好的方式如html进行显示。所以模型信息将会被发送给一个视图(View，例如jsp视图。事实上，控制器同时产生了模型以及视图名称，将这些信息发送回DispatcherServlet。

#### 视图解析器(View Parser)
DispatcherServlet收到控制器的视图名称并不直接表示某个特定的JSP，这个视图名称仅仅是个逻辑值，DispatcherServlet为了找到真正的视图，会使用视图解析器(view resolver)将视图名称匹配成一个具体的视图。根据返回的ModelAndView，选择一个适合的ViewResolver（必须是已经注册到Spring容器中的ViewResolver)返回给DispatcherServlet。

#### 视图(View)
目前为止，DispatcherServlet知道了具体由哪个视图来显示模型信息，那么它就会将模型信息交付给视图，请求的任务到这里就完成了。ViewResolver 结合Model和View，来渲染视图。

#### 响应(HTTP Response)
视图渲染模型信息并输出，该输出最后会传递给用户端，展示给用户查看。从以上步骤可以看到，Spring MVC要处理很多过程，但是大部分过程是Spring框架内部处理的，事实上，我们可以十分方便利用Spring MVC框架的编写功能强大的Web应用程序，下一章我们将搭建一个基础的Spring MVC实例程序。

原始地址：

* [Spring MVC入门-DispatcherServlet处理请求过程]

[Spring MVC入门-DispatcherServlet处理请求过程]:http://wiki.jikexueyuan.com/project/spring/mvc-framework/spring-mvc-form-handling-example.html
