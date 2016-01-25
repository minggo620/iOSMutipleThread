# 多样的iOS多线程（NSThread、NSOperation、GCD）编程
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Travis](https://img.shields.io/travis/rust-lang/rust.svg)]()
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg)]()
[![Github All Releases](https://img.shields.io/badge/download-6M Total-green.svg)](https://github.com/minggo620/iOSMutipleThread/archive/master.zip) 

![文章配图](https://github.com/minggo620/iOSMutipleThread/blob/master/picture/multiplethread2.jpeg?raw=true)  

一周六早上，小明处于安全考虑，去银行服务厅申请多一张银行卡作为手机消费指定数额不多的专用卡。到了银行，看到大厅坐满了人，唱K的唱K，念经的念经，呕奶的呕奶，彼起此伏，声声入耳，直赶清华大学演奏团演奏的《小苹果》，呀~！其实真实的情况是：每个人都做着椅子上低下头盯着各自的手机，小明也不例外，找了个角落，浏览起3016年的新闻。半个小时过去了，40分钟过去了，一个小时过去！小明等怒了，大喊“嘿嘿嘿，开多一条线程不可以吗！！！”
#####“什么是多一条线程啊？”
![文章大纲](https://github.com/minggo620/iOSMutipleThread/blob/master/picture/multiplethread1.png?raw=true)  
###一.基本概念  
以下概念按最简单方式来描述。   
 
+1. 进程：  
一个具有一定独立功能的程序关于某个数据集合的一次运行活动。可以理解成一个运行中的应用程序。
+2. 线程：  
程序执行流的最小单元，线程是进程中的一个实体。  
+3. 同步：  
只能在当前线程按先后顺序依次执行，不开启新线程。
+4. 异步：  
可以在当前线程开启多个新线程执行，可不按顺序执行。
+5. 队列：  
装载线程任务的队形结构。  
+6. 并发：  
线程执行可以同时一起进行执行。
+7. 串行：  
线程执行只能依次逐一先后有序的执行。    

***注意:***  
+一个进程可有多个线程。  
+一个进程可有多个队列。  
+队列可分并发队列和串行队列。







