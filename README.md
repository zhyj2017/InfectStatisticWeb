# InfectStatisticWeb
某次疫情统计可视化的实现

* 项目简介  
该项目通过web技术直观地反映了全国和各省份的疫情情况。

* 开发工具  
eclipse（该项目在eclipse运行时存在背景图像无法显示的bug，建议使用IDEA运行，IDEA的本次作业项目在子目录InfectStatisticWeb下）。

* 如何运行  
首先在DBUtil.java中配置好本地数据库路径，第一次运行writeDateBase.java创建数据库表，第二次运行读取指定路径下所有疫情日志文件，将数据保存至数据库中。配置Tomcat服务器后运行index.jsp即可使用。

* 功能简介
    1. 实现通过地图的形式来直观显示疫情的大致分布情况，还可以查看具体省份的疫情统计情况。
    2. 点击某个省份显示该省疫情的具体情况。
    3. 查看当前热点新闻功能。
    4. 查看有关疫情的科普知识功能。
    5. 口罩预约功能。

* 组队信息  
041702303陈伟杰  
221701238周宇靖

* 作业链接  
[https://edu.cnblogs.com/campus/fzu/2020SPRINGS/homework/10460](https://edu.cnblogs.com/campus/fzu/2020SPRINGS/homework/10460)

* 博客链接  
[https://www.cnblogs.com/Dreamer2020/p/12484768.html](https://www.cnblogs.com/Dreamer2020/p/12484768.html)
