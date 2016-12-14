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

通过@ResponseBody  直接返回对象,Spring MVC会自动把对象转化成Json,需要其他配置支持。
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

 注意：在使用@ResponseBody 返回json的时候，方法参数中一定不能他添加   PrintWriter printWriter
