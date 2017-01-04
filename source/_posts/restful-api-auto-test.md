---
title: 使用Rest-Assured做Restful接口自动化测试
date: 2016-12-26 11:55:38
tags:
- Restful
- Auto-test
- TestNG
categories: Programming
---

#### 使用Python脚本测试

安装pycurl包：

```Bash
pip install pycurl
```

安装时可能会出现如下问题：

<!-- more -->

```
Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-jzTgwZ/pycurl
```

使用如下命令安装依赖包：

```Bash
apt-get install libcurl4-openssl-dev
```

#### 使用rest-assured框架测试

rest-assured框架用于测试REST方式的接口，使用JSON schema验证返回体，大大的简化了测试代码。esting and validation of REST services in Java is harder than in dynamic languages such as Ruby and Groovy. REST Assured brings the simplicity of using these languages into the Java domain.

##### 引入依赖包

在Gradle中，引入[rest-assured](http://rest-assured.io/)框架的依赖包和TestNG的依赖包。

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

上述方法在请求头中加入认证信息，get中为请求的地址，根据返回的error code为0判断服务端成功处理了此次请求。测试结果如下图：

{% asset_img rest-test-result.png Restful接口测试%}
