---
title: Java线程
date: 2016-12-12 20:11:17
tags:
- Java
- Thread
categories: Programming
---

#### 线程合并(Join)

线程的合并的含义就是将几个并行线程的线程合并为一个单线程执行，应用场景是当一个线程必须等待另一个线程执行完毕才能执行时可以使用join方法。

<!-- more -->

```Bash
public static void main(String[] args) {
    Thread t1 = new MyThread1();
    t1.start();

    for (int i = 0; i < 10; i++) {
        System.out.println("主线程第" + i + "次执行！");
        if (i > 2) {
            try {
                //t1线程合并到主线程中，主线程停止执行过程，转而执行t1线程，直到t1执行完毕后继续。
                t1.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

static class MyThread1 extends Thread {
    public void run() {
        for (int i = 0; i < 10; i++) {
            System.out.println("线程1第" + i + "次执行！");
        }
    }
}
```

运行结果如下：

```
Connected to the target VM, address: '127.0.0.1:44229', transport: 'socket'
主线程第0次执行！
主线程第1次执行！
线程1第0次执行！
主线程第2次执行！
线程1第1次执行！
主线程第3次执行！
线程1第2次执行！
线程1第3次执行！
线程1第4次执行！
线程1第5次执行！
线程1第6次执行！
线程1第7次执行！
线程1第8次执行！
线程1第9次执行！
主线程第4次执行！
主线程第5次执行！
主线程第6次执行！
主线程第7次执行！
主线程第8次执行！
主线程第9次执行！
Disconnected from the target VM, address: '127.0.0.1:44229', transport: 'socket'

Process finished with exit code 0
```
