---
title: 向HBase中写入数据
tags:
---


org.springframework.dao.InvalidDataAccessApiUsageException: Error getting generated key or setting result to parameter object. Cause: java.sql.SQLFeatureNotSupportedException
; SQL []; null; nested exception is java.sql.SQLFeatureNotSupportedException


Configuration: core-default.xml, core-site.xml, hbase-default.xml, hbase-site.xml

```Java
try {
    // 创建必要的参数
    // Configuration conf = HBaseConfiguration.create();
    Configuration conf = new Configuration();
    conf.set("hbase.zookeeper.quorum", "192.168.24.136");
    conf.set("hbase.zookeeper.property.clientPort", "2181");
    // 初始化客户端
    Connection connection = ConnectionFactory.createConnection(conf);
    Table table = connection.getTable(TableName.valueOf("testtable"));
    // 对指定的列创建put对象
    Put put = new Put(Bytes.toBytes("col1"));
    // put.addColumn(Bytes.toBytes("col1"), Bytes.toBytes("col1"), Bytes.toBytes("val1"));
    put.addColumn(Bytes.toBytes("colfam1"), Bytes.toBytes("qual2"), Bytes.toBytes("val2"));
    table.put(put);
    // 关闭表
    table.close();
    // 关闭连接
    connection.close();
}catch(Exception e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
}
```
