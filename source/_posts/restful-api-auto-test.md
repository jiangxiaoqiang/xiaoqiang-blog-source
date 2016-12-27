---
title: Restful接口自动化测试
date: 2016-12-26 11:55:38
tags:
- Restful
- 接口自动化测试
categories: Programming
---

#### 使用Python脚本测试

安装pycurl包：

```Bash
pip install pycurl
```

<!-- more -->

#### 使用rest-assured框架测试

Testing and validation of REST services in Java is harder than in dynamic languages such as Ruby and Groovy. REST Assured brings the simplicity of using these languages into the Java domain.

##### 引入依赖包

引入[rest-assured](http://rest-assured.io/)框架的依赖包和TestNG的依赖包。

```
project(':cc-api') {
    apply from: ccCommonBuildScript
    description = 'credit-system-api'

    dependencies {
        compile 'io.rest-assured:json-path:3.0.1'
        compile 'org.testng:testng:6.8.17'//TestNG依赖包
        testCompile 'io.rest-assured:rest-assured:3.0.1'
        compile('com.jayway.restassured:rest-assured:2.3.1')//rest-assured框架依赖包
        compile project(':cc-business')
    }
}
```

##### 添加测试方法

测试方法如下：

```Java
import common.TestPublicVariable;
import org.testng.annotations.Test;
import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.*;

public class ApiXysjControllerTest {
    @Test
    public void testCountTotal() throws Exception {
        given().header(TestPublicVariable.APPID, TestPublicVariable.APPID_VALUE)
                .header("TIMESTAMP", "2016-12-19 16:58:02")
                .header("ECHOSTR", "sdsaasf")
                .header("TOKEN", "14d45648c62a746ae9dd9b90c03c50893061222d")
                .get("http://192.168.32.105:28080/api/xysj/counttotal")
                .then()
                .body("errCode", equalTo(0));
    }
}
```

上述方法在请求头中加入认证信息，get中为请求的地址，根据返回的error code为0判断服务端成功处理了此次请求。
