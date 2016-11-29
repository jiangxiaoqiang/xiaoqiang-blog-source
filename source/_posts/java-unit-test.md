---
title: Java单元测试
date: 2016-11-29 09:37:43
tags:
- Unit Test
categories: Programming
---

在Intellij Idea中按下快捷键:`Ctrl + Alt + T(Test)`，弹出如下界面，选择需要创建测试的方法。

<!-- more -->

{% asset_img choose-test-function.jpg 选择创建测试的方法%}


选择完毕后会自动生成一个测试类，编写相应的测试代码即可。

```Java
import org.junit.Test;

/**
 * Created by jiangxiaoqiang on 2016/11/29.
 */
public class VehicleMessageHandlerTest {
    @Test
    public void parseAlarm() throws Exception {
        VehicleMessageHandler vehicleMessageHandler = new VehicleMessageHandler();
        String result = vehicleMessageHandler.parseAlarm(1232131);
        System.out.print(result);
    }
}
```

在代码编辑器中右键，选择`Debug ‘parseAlarm’`菜单即可进行单元测试。

