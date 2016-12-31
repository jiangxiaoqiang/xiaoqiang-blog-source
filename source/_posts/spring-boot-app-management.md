---
title: spring-boot-app-management
date: 2016-12-31 23:24:09
tags:
- Spring Boot
categories: Programming
---

```Java
@ComponentScan
@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(Application.class);
        app.addListeners(new ApplicationPidFileWriter("app.pid"));
        app.run(args);
    }
}
```

when we already have our PID file we need bash script providing standard operations like stop, start, restart and status checking. Below you can find simple script solving that challenge. 