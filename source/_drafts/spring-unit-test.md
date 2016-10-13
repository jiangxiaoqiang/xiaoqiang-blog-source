---
title: Intellij Idea中Spring单元测试
tags:
- Spring
- Unit Test
- JUnit4
categories: Programming
---

最近发现在Intellij Idea中进行单元测试非常方便，单元测试有助于发现代码修改带来的影响。严谨的代码应该是容易理解、可以测试、易于修改。保证程序的稳定可控和代码质量，有必要进行单元测试。例如需要测试如下类中的方法：

<!-- more -->

```Java
@Component
@Log4j2
public class UserService {
    public List<UserInfo> getHistoryAlarmInfoImpl(String id) {
        return userDao.getUsers(id);
    }
}
```

在类上使用快捷键<code>Ctrl + Alt + T</code>，可以用此快捷键在测试类与被测试类之间进行跳转，弹出创建单元测试的界面，选择需要测试的方法。如下图所示：

{% asset_img intellij-create-unit-test.jpg Intellij Idea创建测试%}


自动生成的测试类如下：

```Java
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:/*.xml")
public class UserServiceTest {

    //@Autowired
    //private WsVehicleService wsVehicleService;

    @Test
    public void getUserInfo() throws Exception {
       // String requestJson = "\"{\"VEHICLEID\":\"cae21196-cb66-4256-88a6-7cdfb23e2c78\",\"STARTTIME\":1476115200,\"ENDTIME\":1476201599,\"TYPE\":1}\"";
       // wsVehicleService.getHistoryAlarmInfoImpl(requestJson);
    }
}
```

由于项目上下文配置文件非常多，以<code>classpath:/*.xml</code>来指定。
