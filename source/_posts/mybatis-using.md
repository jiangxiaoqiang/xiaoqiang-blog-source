---
title: MyBatis使用
date: 2016-12-20 22:20:23
tags:
- MyBatis
categories: Programming
---

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

齐总open和close需要单独加上单引号，链接分隔符(separator)也需要添加引号。另外遍历的item会出现解析出来是？的情况，将字符#替换为$，不过有ＳＱＬ注入的风险。Mybatis如果采用#{xxx}的形式设置参数，Mybatis会进行sql注入的过滤。如果采用的是${xxx}，Mybatis不会进行sql注入过滤，而是直接将参入的内容输出为sql语句。

#### 特殊符号

优势想在ＳＱＬ中添加特殊符号，比如在字符串变量中添加一个单引号，如下语句所示。

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
