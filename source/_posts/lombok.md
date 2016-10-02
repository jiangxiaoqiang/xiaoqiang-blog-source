---
title: Lombok精简Java代码
tags: lombok
---


[lombok](https://projectlombok.org/)提供了简单的注解的形式来帮助我们简化消除一些必须有但显得很臃肿的java代码,特别是相对于POJO(Plain Ordinary Java Object)。安装Lombok Plugin和引入Jar包之后方可使用。


常用的 lombok 注解：

* **@Data**：注解在类上；提供类所有属性的 getting 和 setting 方法，此外还提供了equals、canEqual、hashCode、toString 方法
* **@Setter**：注解在属性上；为属性提供 setting 方法
* **@Getter**：注解在属性上；为属性提供 getting 方法
* **@Log4j**：注解在类上；为类提供一个 属性名为log 的 log4j 日志对象
* **@NoArgsConstructor**：注解在类上；为类提供一个无参的构造方法
* **@AllArgsConstructor**：注解在类上；为类提供一个全参的构造方法

如果不使用lombok注解，代码是这样：

<!-- more -->

```Java
public class Person {
    private String id;
    private Logger log = Logger.getLogger(Person.class);

    public Person() {

    }

    public Person(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
```


使用lombok注解，代码是这样：

```Java
@Data
@Log4j
@NoArgsConstructor
@AllArgsConstructor
public class Person {
    private String id;
}
```

一旦POJO字段较多时精简的代码就很明显了，而且使用Lombok的代码更加干净、易读，添加**@Data**注解之后，按Ctrl + O(Outline)可以看到生成了get和set方法。

#### @EqualsAndHashCode

@EqualsAndHashCode注解实现equals()方法和hashCode()方法。hashcode是用于散列数据的快速存取，如利用HashSet/HashMap/Hashtable类来存储数据时，都是根据存储对象的hashcode值来进行判断是否相同的。


