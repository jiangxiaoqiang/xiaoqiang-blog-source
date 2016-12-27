---
title: Restful API文档编写
date: 2016-12-27 10:31:39
tags:
- Restful
- Swagger
categories: Programming
---

在写Restful(Representational state transfer)接口时，文档是必不可少的，文档采用Springfox自动生成。Swagger是用来描述和文档化RESTful API的一个项目。Swagger Spec是一套规范，定义了该如何去描述一个RESTful API。类似的项目还有RAML、API Blueprint。 根据Swagger Spec来描述RESTful API的文件称之为Swagger specification file，它使用JSON来表述，也支持作为JSON支持的YAML(YAML Ain't Markup Language)。swagger-core是一个Java的实现，现在支持JAX-RS。swagger-annotation定义了一套注解给用户用来描述API。spring-fox也是一个Java的实现，它支持Spring MVC， 它也支持swagger-annotation定义的部分注解。

<!-- more -->

对接口文档的要求有如下几点：

* 要实时更新，代码变动，参数变动后，文档要相应更新
* 请求/返回数据类型、请求/返回数据示例

#### 支持泛型返回值

接口的返回值是通过泛型来动态定义的，Springfox生成接口文档时，由于未指定具体的返回类型，所以无法生成返回实体对应的注释。可以通过手动定义返回实体，手动在接口返回时指定的方式来解决此问题。例如，返回的数据定义成泛型：

```Java
@lombok.Data
@io.swagger.annotations.ApiModel(value = "ApiResult", description = "Api返回结果")
public class ApiResult<T>{

    @ApiModelProperty(value = "错误码")
    private int errCode = 0;

    @ApiModelProperty(value = "错误消息")
    private String errMsg = "";

    @ApiModelProperty(value = "返回数据")
    private T data = null;
}
```

手动定义一个具体的实体消除泛型：

```Java
public class SingleBlacklistResult extends AbstractApiResult {
    private SummaryBlacklist data;
}
```

SummaryBlacklist就是编译时具体的泛型类型。在接口中指定返回类型：

```Java
@GetMapping
    @ApiOperation(value = "必须且只能传一个参数", response = BlackListApiResult.class)
    public ApiResult getBlackList(@RequestParam(required = false) @ApiParam("主体名（模糊）") String xdr
}
```

在接口文档页面即可看到返回的具体的实体了，如下图所示。

{% asset_img springfox-return-entity.jpg 返回泛型实体%}
