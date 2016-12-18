---
title: Interview面试题
date: 2016-12-14 21:10:43
tags:
- Interview
categories: Programming
---

#### 运算符优先级

```Java
public class Boy {
    public static void main(String[] args) {
        int i = 12;
        //输出为-120
        System.out.print(i += i -= i *= i);
    }
}
```

计算过程参考这里：

<!-- more -->

[Why the output is -120?](http://stackoverflow.com/questions/41144042/why-the-output-is-120/41144150#41144150)

#### 

synchronized是对类的当前实例进行加锁，防止其他线程同时访问该类的该实例的所有synchronized块，注意这里是“类的当前实例”，类的两个不同实例就没有这种约束了。那么static synchronized恰好就是要控制类的所有实例的访问了，static synchronized是限制线程同时访问jvm中该类的所有实例同时访问对应的代码快。实际上，在类中某方法或某代码块中有synchronized，那么在生成一个该类实例后，该类也就有一个监视快，放置线程并发访问改实例synchronized保护快，而static synchronized则是所有该类的实例公用一个监视快了，也就是两个的区别了,也就是synchronized相当于this.synchronized，而static synchronized相当于Something.synchronized。

synchronized针对同一个实例不能访问，针对不同的实例可以同时访问。static synchronized针对所有的实例均不能同时访问。synchronized本来就是修饰方法的，后来引申出synchronized修饰代码块，只是为了可以更精确的控制冲突限制的访问区域，使得表现更加高效率。synchronized方法只能锁定现阶段的对象，而synchronized区块可以锁定指定的对象，指定的对象直接跟在synchronized()括号之后。此外，synchronized关键字是不能继承的，也就是说，基类的方法synchronized f(){} 在继承类中并不自动是synchronized f(){}，而是变成了f(){}。继承类需要你显式的指定它的某个方法为synchronized方法。还有synchronized不能被继承，继承时子类的覆盖方法必须显示定义成synchronized。

除了方法前用synchronized关键字，synchronized关键字还可以用于方法中的某个区块中，表示只对这个区块的资源实行互斥访问。用法是: synchronized(object){/*区块*/}，它的作用域是object对象。当一个线程执行时，将object对象锁住，另一个线程就不能执行对应的块。synchronized方法实际上等同于用一个synchronized块包住方法中的所有语句，然后在synchronized块的括号中传入this关键字。当然，如果是静态方法，需要锁定的则是class对象。可能一个方法中只有几行代码会涉及到线程同步问题，所以synchronized块比synchronized方法更加细粒度地控制了多个线程的访问，只有synchronized块中的内容不能同时被多个线程所访问，方法中的其他语句仍然可以同时被多个线程所访问（包括synchronized块之前的和之后的）。

#### Java值传递

```Java
public class JavaPramPassing {
    String str = new String("good");
    char[] ch = {'a', 'b', 'c'};

    public static void main(String[] args) {
        JavaPramPassing javaPramPassing = new JavaPramPassing();
        javaPramPassing.change(javaPramPassing.str,javaPramPassing.ch);
        System.out.println(javaPramPassing.str);//good
        System.out.println(javaPramPassing.ch);//gbc
    }

    public void change(String str, char[] ch) {
        str = "test ok";
        ch[0] = 'g';
    }
}
```

Java参数，不管是原始类型还是引用类型，传递的都是副本(有另外一种说法是传值，但是说传副本更好理解吧，传值通常是相对传址而言)。要特殊考虑String，以及Integer、Double等几个基本类型包装类，它们都是immutable类型，因为没有提供自身修改的函数，每次操作都是新生成一个对象，所以要特殊对待，可以认为是和基本数据类型相似，传值(Pass by Value)操作。

* 如果参数类型是原始类型，那么传过来的就是这个参数的一个副本，也就是这个原始参数的值，这个跟之前所谈的传值是一样的。如果在函数中改变了副本的 值不会改变原始的值.
* 如果参数类型是引用类型，那么传过来的就是这个引用参数的副本，这个副本存放的是参数的地址。如果在函数中没有改变这个副本的地址，而是改变了地址中的 值，那么在函数内的改变会影响到传入的参数。如果在函数中改变了副本的地址，如new一个，那么副本就指向了一个新的地址，此时传入的参数还是指向原来的 地址，所以不会改变参数的值。
