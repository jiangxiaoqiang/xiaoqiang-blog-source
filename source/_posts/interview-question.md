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
