# iOS多线程（NSThread、NSOperation、GCD）编程
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Travis](https://img.shields.io/travis/rust-lang/rust.svg)]()
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg)]()
[![Github All Releases](https://img.shields.io/badge/download-6M Total-green.svg)](https://github.com/minggo620/iOSMutipleThread/archive/master.zip) 

![文章配图](https://github.com/minggo620/iOSMutipleThread/blob/master/picture/multiplethread2.jpeg?raw=true)  

一周六早上，小明处于安全考虑，去银行服务厅申请多一张银行卡作为手机消费指定数额不多的专用卡。到了银行，看到大厅坐满了人，唱K的唱K，念经的念经，呕奶的呕奶，彼起此伏，声声入耳，直赶清华大学演奏团演奏的《小苹果》，呀~！其实真实的情况是：每个人都做着椅子上低下头盯着各自的手机，小明也不例外，找了个角落，浏览起3016年的新闻。半个小时过去了，40分钟过去了，一个小时过去！小明等怒了，大喊“嘿嘿嘿，开多一条线程不可以吗！！！”
#####“什么是多一条线程啊？”
![文章大纲](https://github.com/minggo620/iOSMutipleThread/blob/master/picture/multiplethread1.png?raw=true)  
###一.基本概念  
计算机操作系统都有的基本概念，以下概念简单方式来描述。   
 
1. 进程：  一个具有一定独立功能的程序关于某个数据集合的一次运行活动。可以理解成一个运行中的应用程序。
2. 线程：  程序执行流的最小单元，线程是进程中的一个实体。  
3. 同步：  只能在当前线程按先后顺序依次执行，不开启新线程。
4. 异步：  可以在当前线程开启多个新线程执行，可不按顺序执行。
5. 队列：  装载线程任务的队形结构。  
6. 并发：  线程执行可以同时一起进行执行。
7. 串行：  线程执行只能依次逐一先后有序的执行。    

***注意:***  
+一个进程可有多个线程。  
+一个进程可有多个队列。  
+队列可分并发队列和串行队列。  

###二.iOS多线程对比  
####1. NSThread  
每个NSThread对象对应一个线程，真正最原始的线程。  
1）优点：NSThread 轻量级最低，相对简单。  
2）缺点：手动管理所有的线程活动，如生命周期、线程同步、睡眠等。
#####2. NSOperation  
自带线程管理的抽象类。  
1）优点：自带线程周期管理，操作上可更注重自己逻辑。  
2）缺点：面向对象的抽象类，只能实现它或者使用它定义好的两个子类：NSInvocationOperation 和 NSBlockOperation。
#####3. GCD
Grand Central Dispatch (GCD)是Apple开发的一个多核编程的解决方法。  
1）优点：最高效，避开并发陷阱。  
2）缺点：基于C实现。
#####5. 选择小结  
1）简单而安全的选择NSOperation实现多线程即可。  
2）处理大量并发数据，又追求性能效率的选择GCD。  
3）NSThread本人选择基本上是在做些小测试上使用，当然也可以基于此造个轮子。

###三.场景选择  

1. **图片异步加载**。这种常见的场景是最常见也是必不可少的。异步加载图片有分成两种来说明一下。  
第一种，在UI主线程开启新线程按顺序加载图片，加载完成刷新UI。  
第二种，依然是在主线程开启新线程，顺序不定地加载图片，加载完成个字刷新UI。  
2. **创作工具上的异步。** 这个跟上边任务调度道理，只是为了丰富描述，有助于“举一反三”效果。如下描述的是app创作小说。  
场景一，app本地创作10个章节内容未成同步服务器，同时发表这10个章节产生的一系列动作，其中上传内容，获取分配章节Id，如何后台没有做处理最好方式做**异步按顺序执行。**  
场景二，app本地创作列表中有3本小说为发表，同时发表创作列表中的3本小说，自然考虑**并行队列执行**发表。  

###四.使用方法  
第三标题内容实现先留下一个悬念。具体实现还是先熟知一下各自的API先。
#####1. NSThread  





