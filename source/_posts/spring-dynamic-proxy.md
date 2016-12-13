---
title: Spring动态代理(Dynamic Proxy)
date: 2016-12-13 15:54:38
tags:
- spring
- dynamic Proxy
categories: Programming
---

#### cglib（Code Generlize Library）动态代理

CGLIB（Code Generlize Library）代理是针对类实现代理，主要是对指定的类生成一个子类，覆盖其中的所有方法，所以该类或方法不能声明称final的。首先使用Maven引入CGLIB的依赖包。

<!-- more -->

```XML
<dependency>
    <groupId>cglib</groupId>
    <artifactId>cglib</artifactId>
    <version>2.2.2</version>
</dependency>
```

```Java
package dolphin.test;

/**
 * @Author: jiangxiaoqiang
 * Created by 12/13/16 on 5:23 PM.
 */
public class BookCglibImpl {
    public void addBook() {
        System.out.println("增加图书Cglib...");
    }
}

package dolphin.test;

import net.sf.cglib.proxy.Enhancer;
import net.sf.cglib.proxy.MethodInterceptor;
import net.sf.cglib.proxy.MethodProxy;

import java.lang.reflect.Method;

/**
 * @Author: jiangxiaoqiang
 * Created by 12/13/16 on 5:24 PM.
 */
public class BookCglibPoxy implements MethodInterceptor {

    private Object target;

    /**
     * 创建代理对象
     *
     * @param target
     * @return
     */
    public Object getInstance(Object target) {
        this.target = target;
        Enhancer enhancer = new Enhancer();
        enhancer.setSuperclass(this.target.getClass());
        // 回调方法
        enhancer.setCallback(this);
        // 创建代理对象
        return enhancer.create();
    }

    // 回调方法
    public Object intercept(Object obj, Method method, Object[] args,
                            MethodProxy proxy) throws Throwable {
        System.out.println("事物开始");
        proxy.invokeSuper(obj, args);
        System.out.println("事物结束");
        return null;
    }
}

package dolphin.test;

/**
 * @Author: jiangxiaoqiang
 * Created by 12/13/16 on 5:43 PM.
 */
public class TestCglib {
    public static void main(String[] args) {
        BookCglibPoxy cglib=new BookCglibPoxy();
        BookCglibImpl bookCglib=(BookCglibImpl)cglib.getInstance(new BookCglibImpl());
        bookCglib.addBook();
    }
}
```


#### JDK的动态代理

JDK动态代理的两个核心分别是InvocationHandler和Proxy，此时代理对象和目标对象实现了相同的接口，目标对象作为代理对象的一个属性，具体接口实现中，可以在调用目标对象相应方法前后加上其他业务处理逻辑。代理模式在实际使用时需要指定具体的目标对象，如果为每个类都添加一个代理类的话，会导致类很多，同时如果不知道具体类的话，怎样实现代理模式呢？这就引出动态代理。JDK动态代理只能针对实现了接口的类生成代理。而不能实现接口的类就不能实现JDK的动态代理，cglib是针对类来实现代理的，他的原理是对指定的目标类生成一个子类，并覆盖其中方法实现增强，但因为采用的是继承，所以不能对final修饰的类进行代理。JDK动态代理中包含一个类和一个接口：

##### InvocationHandler接口

```Java
public interface InvocationHandler {
    public Object invoke(Object proxy,Method method,Object[] args) throws Throwable;
}
```

参数说明：

Object proxy：指被代理的对象。

Method method：要调用的方法

Object[] args：方法调用时所需要的参数

可以将InvocationHandler接口的子类想象成一个代理的最终操作类，替换掉ProxySubject。

##### Proxy类

Proxy类是专门完成代理的操作类，可以通过此类为一个或多个接口动态地生成实现类，此类提供了如下的操作方法：

```Java
public static Object newProxyInstance(ClassLoader loader, Class<?>[] interfaces,InvocationHandler h) throws IllegalArgumentException
```

参数说明：

ClassLoader loader：类加载器

Class<?>[] interfaces：得到全部的接口

InvocationHandler h：得到InvocationHandler接口的子类实例

Ps:类加载器
在Proxy类中的newProxyInstance（）方法中需要一个ClassLoader类的实例，ClassLoader实际上对应的是类加载器，在Java中主要有一下三种类加载器;
* Booststrap ClassLoader：此加载器采用C++编写，一般开发中是看不到的；
* Extendsion ClassLoader：用来进行扩展类的加载，一般对应的是jre\lib\ext目录中的类;
* AppClassLoader：(默认)加载classpath指定的类，是最常使用的是一种加载器。

```Java
package dolphin.test;

/**
 * @Author: jiangxiaoqiang
 * Created by 12/13/16 on 5:08 PM.
 */
public interface Book {
    public void addBook();
}

package dolphin.test;

/**
 * @Author: jiangxiaoqiang
 * Created by 12/13/16 on 5:09 PM.
 */
public class BookImpl implements Book{

    public void addBook() {
        System.out.println("增加书");
    }
}

package dolphin.test;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/**
 * @Author: jiangxiaoqiang
 * Created by 12/13/16 on 5:10 PM.
 */
public class BookProxy implements InvocationHandler{

    private Object target;
    /**
     * 绑定委托对象并返回一个代理类
     * @param target
     * @return
     */
    public Object bind(Object target) {
        this.target = target;
        //取得代理对象
        return Proxy.newProxyInstance(target.getClass().getClassLoader(),
                target.getClass().getInterfaces(), this);   //要绑定接口(这是一个缺陷，cglib弥补了这一缺陷)
    }

    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        Object result=null;
        System.out.println("事物开始");
        //执行方法
        result=method.invoke(target, args);
        System.out.println("事物结束");
        return result;
    }
}

package dolphin.test;

/**
 * @Author: jiangxiaoqiang
 * Created by 12/13/16 on 5:12 PM.
 */
public class TestProxy {
    public static void main(String[] args) {
        BookProxy bookProxy = new BookProxy();
        Book book = (Book) bookProxy.bind(new BookImpl());
        book.addBook();
    }

}
```



#### 区别

* JDK动态代理只能对实现了接口的类生成代理，而不能针对类 。
* CGLIB是针对类实现代理，主要是对指定的类生成一个子类，覆盖其中的方法 。
* 因为是继承，所以该类或方法最好不要声明成final ，final可以阻止继承和多态。

final 所修饰的数据具有“终态”的特征，表示“最终的”意思：

* final 修饰的类不能被继承。
* final 修饰的方法不能被子类重写。
* final 修饰的变量（成员变量或局部变量）即成为常量，只能赋值一次。
* final 修饰的成员变量必须在声明的同时赋值，如果在声明的时候没有赋值，那么只有 一次赋值的机会，而且只能在构造方法中显式赋值，然后才能使用。
* final 修饰的局部变量可以只声明不赋值，然后再进行一次性的赋值。

#### 动态代理的应用

AOP（Aspect-Oriented Programming，面向切面编程），AOP包括切面（aspect）、通知（advice）、连接点（joinpoint），实现方式就是通过对目标对象的代理在连接点前后加入通知，完成统一的切面操作。在Spring中，有如下规则：

* 如果目标对象实现了接口，在默认情况下会采用JDK的动态代理实现AOP
* 如果目标对象实现了接口，也可以强制使用CGLIB生成代理实现AOP
* 如果目标对象没有实现接口，必须引入CGLIB，Spring会在JDK的动态代理和CGLIB代理之间进行切换。


实现AOP的技术，主要分为两大类：

一是采用动态代理技术(Dynamic Proxy)，利用截取消息的方式，对该消息进行装饰，以取代原有对象行为的执行；

二是采用静态织入(Static Weaving)的方式，引入特定的语法创建“方面”，从而使得编译器可以在编译期间织入有关“方面”的代码。

Spring提供了两种方式来生成代理对象: JDKProxy和Cglib，具体使用哪种方式生成由AopProxyFactory根据AdvisedSupport对象的配置来决定。

默认的策略是如果目标类是接口，则使用JDK动态代理技术，如果目标对象没有实现接口，则默认会采用CGLIB代理。如果目标对象实现了接口，可以强制使用CGLIB实现代理:

```XML
<!-- 添加CGLIB库，并在spring配置中加入如下配置 -->
<aop:aspectj-autoproxy proxy-target-class="true"/>
```
