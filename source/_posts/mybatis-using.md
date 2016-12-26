---
title: MyBatis使用
date: 2016-12-20 22:20:23
tags:
- MyBatis
categories: Programming
---

* Java的实体属性中，属性赋值时是区分大小写的，比如adog不能成功映射到aDog

#### Mapper文件中遍历集合参数

在遍历List<Integer>时，直接使用如下的语句即可：

```XML
select * from table
<where>
    id in <foreach collection="ids" item="item" index="index"
open="(" separator="," close=")">#{item}</foreach>
</where>
```

<!-- more -->

如果是遍历List<String>，可以采用如下写法：

```XML
<select id=**"countByXdrShxym" **resultType=**"java.util.HashMap"**>    
    select XDR_SHXYM, count(*) AS total from TS_B_BLACKLIST where XDR_SHXYM in
    <foreach item=**"item" **index=**"index" **collection=**"list" **open=**"('" **separator=**"','" **close=**"')"**>${item}</foreach>    
    group by XDR_SHXYM
</select>
```

其中open和close需要单独加上单引号，链接分隔符(separator)也需要添加引号。另外遍历的item会出现解析出来是？的情况，将字符#替换为$，不过有SQL注入的风险。Mybatis如果采用#{xxx}的形式设置参数，Mybatis会进行sql注入的过滤。如果采用的是${xxx}，Mybatis不会进行sql注入过滤，而是直接将参入的内容输出为sql语句。

#### 特殊符号

优势想在SQL中添加特殊符号，比如在字符串变量中添加一个单引号，如下语句所示。

```XML
<select id="findList" parameterType="map" resultMap="SummaryXzxk">    
    SELECT *
    FROM TS_B_XZXK
    <trim prefix="WHERE" prefixOverrides="AND|OR">
        <if test = "xdr != null">            
        AND XDR like CONCAT('%', ${xdr}, '%')
        </if>
    </trim>
</select>
```

在变量xdr上添加单引号，可以写成如下语句：

```XML
<select>
    SELECT *
    FROM TS_B_XZXK
    <trim prefix="WHERE" prefixOverrides="AND|OR">
        <if test = "xdr != null">            
        AND XDR like CONCAT('%', &apos;${xdr}&apos;, '%')
        </if>
    </trim>
</select>
```

#### 传入参数

ＭyBatis的传入参数可以是各种Java的基本数据类型：包含int,String,Date等。基本数据类型作为传参，只能传入一个。通过#{参数名}即可获取传入的值，复杂数据类型：包含Java实体类、Map。通过#{属性名}或#{map的KeyName}即可获取传入的值，但是如果想传入一个collection时，可以使用mapper配置文件中的foreach语句。

#### MyBatis中${}与#{}的区别

当使用#{parameterName}引入参数的时候，Mybatis会把这个参数认为是一个字符串，在拼接SQL的时候其实首先是一个问号（？），然后查询的时候，将参数引入到问号（？）之中。比如
	`select * from emp where name = #{name}`，这样的一个SQL，解析以后是`select * from emp where name = ?`，由于是#{name}的方式引入，那么就将问号（？）替换成#{name}的值，比如传进一个字符串"yedward"，那么最终的查询SQL是`select * from emp where name = 'yedward'`。可以理解为#可以进行预编译，进行类型匹配，而$不进行数据类型匹配。

当使用${parameterName}引入参数的时候，Mybatis会将这个参数直接拼到SQL中去，就没有上面那种问号（？）。

1. #将传入的数据都当成一个字符串，会对自动传入的数据加一个双引号。如：order by #user_id#，如果传入的值是111,那么解析成sql时的值为order by "111", 如果传入的值是id，则解析成的sql为order by "id"

2. $将传入的数据直接显示生成在sql中。如：order by $user_id$，如果传入的值是111,那么解析成sql时的值为order by user_id,  如果传入的值是id，则解析成的sql为order by id.
　　
3. #方式能够很大程度防止sql注入。
　　
4. $方式无法防止Sql注入。

5. $方式一般用于传入数据库对象，例如传入表名.
	注：MyBatis排序时使用order by 动态参数时用$而不是#

6. 有时你只是想直接在SQL语句中插入一个不改变的字符串。比如，像ORDER BY，你可以这样来使用：
	ORDER BY ${columnName}

这里MyBatis不会修改或转义字符串。

总结：
写一句SQL-例如：`select * from user_role where user_code = "100";`
这句话而言，需要写成 `select * from ${tableName} where user_code = #{userCode}`
所以，$符是直接拼成sql的 ，#符则会以字符串的形式 与sql进行拼接。在直接拼接规则的时候可以用$，规则已经有了，只是传递参数进去，那么可以用#。

#### \_parameter参数

错误：

```
There is no getter for property named 'moduleCode' in 'class java.lang.String
```

将映射语句由：

```XML
<select id="findByUUID" parameterType="java.lang.String" resultMap="Corporation">
     SELECT *
     FROM TS_F_CORPORATION
     WHERE ID = &apos;${id}&apos;;
 </select>
```

改为：

```XML
<select id="findByUUID" parameterType="java.lang.String" resultMap="Corporation">
     SELECT *
     FROM TS_F_CORPORATION
     WHERE ID = &apos;${_parameter}&apos;;
 </select>
```

#### 分页(Page)

#### 拦截器实现分页(Implement by Interceptor)

由于不同的数据库厂商所提供的分页不同，例如ORACLE是子查询实现，MySQL是limit语句实现，所以在Mybatis中，默认的实现是基于逻辑分页(Logical Page)的。但是Mybatis支持拦截器(Interceptor),所以，我们可以根据不同的数据库，定制自己的数据库物理分页(Physical Page)逻辑。改变mybatis内部的分页行为，理论上只要把最终要执行的sql转变成对应的分页语句就行了。

##### Mybatis-PageHelper
