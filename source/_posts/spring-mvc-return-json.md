---
title: Spring MVC返回Json
date: 2016-12-14 22:08:11
tags:
- Spring MVC
categories: Programming
---

Spring MVC返回 json字符串的方式有很多种方法:

* 直接 PrintWriter 输出
* 使用 JSP 视图
* 使用Spring内置的支持

<!-- more -->

#### PrintWriter输出

```Java
//返回给前台一个字符串
 @RequestMapping(params = "method=getJson1")
 public void getJson(@RequestParam("userid") String userid,@RequestHeader("Accept-Encoding") String encoding,HttpServletRequest request,PrintWriter printWriter) {
  System.out.println("通过注解在参数中取值 "+userid);
  System.out.println("通过@RequestHeader获得的encoding "+encoding);
        printWriter.write("{key,1}");
        printWriter.flush();
        printWriter.close();
 }
 ```

#### @ResponseBody

通过@ResponseBody直接返回对象,Spring MVC会自动把对象转化成Json,需要其他配置支持。@ResponseBody这个注解就是使用消息转换机制，最终通过json的转换器转换成json数据的。SpringMVC使用消息转换器实现请求报文和对象、对象和响应报文之间的自动转换。可以使用@RequestBody和@ResponseBody两个注解，分别完成请求报文到对象和对象到响应报文的转换，底层这种灵活的消息转换机制，就是Spring3.x中新引入的HttpMessageConverter即消息转换器机制。
    1、开启  <mvc:annotation-driven />
    2、Jackson library 对应的jar必须加入到工程中
             3、方法的返回值必须添加 @ResponseBody

```Java
//把返回结果解析成json串返回到前台
 @RequestMapping(params = "method=json")
 public @ResponseBody User passValue(HttpServletRequest request) {
  User user = new User();
  user.setUser("aaaa");
  user.setPass("asfd");
  return user;
 }
 ```

 注意：在使用@ResponseBody 返回json的时候，方法参数中一定不能他添加   PrintWriter printWriter。从流中，只能读取到原始的字符串报文，同样，我们往输出流中，也只能写原始的字符。而在java世界中，处理业务逻辑，都是以一个个有业务意义的对象为处理维度的，那么在报文到达SpringMVC和从SpringMVC出去，都存在一个字符串到java对象的阻抗问题。这一过程，不可能由开发者手工转换。我们知道，在Struts2中，采用了OGNL（Object-Graph Navigation Language）来应对这个问题，而在SpringMVC中，它是HttpMessageConverter机制。
