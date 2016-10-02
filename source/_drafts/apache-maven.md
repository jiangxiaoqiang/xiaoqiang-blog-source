---
title:Apache Maven
---


## Failed to execute goal org.apache.maven.plugins:maven-surefire-plugin:2.10


这是因为测试代码时遇到错误，它会停止编译。只需要在pom.xml的<project>里添加以下配置，使得测试出错不影响项目的编译。

```XML
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-surefire-plugin</artifactId>
            <configuration>
            	<testFailureIgnore>true</testFailureIgnore>
            </configuration>
        </plugin>
    </plugins>
</build>
```
