<%@ page pageEncoding="UTF-8"%>

<div style="height: 360px; min-height: 100px; margin-left: 25px;top:320px" id="main"></div>
<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
    var type = "newIp";

    //获取参数数据
    $("#year").attr("value",
        <%=request.getParameter("year")%>
    );
    $("#month").attr("value",
        <%=request.getParameter("month")%>
    );
    $("#day").attr("value",
        <%=request.getParameter("day")%>
    );
    var name ='<%=request.getParameter("name")%>';
    //判断日期与数据日期的合法
    if ($("#year").val()!="2020"||
        (2==$("#month").val()&&(1<$("#day").val()||2>$("#day").val()))||
        (1==$("#month").val()&&(19<$("#day").val()||31>$("#day").val()))){
        $("#year").attr("value","2020");
        $("#month").attr("value","02");
        $("#day").attr("value","02");
    }
    $(".subtitle").text(name);
    // 指定图表的配置项和数据
    var option = {
        title : { //图表标题
            text : getTitle()
        },
        tooltip : {
            trigger : 'axis', //坐标轴触发提示框，多用于柱状、折线图中
        },
        legend : { //图表上方的类别显示
            show : true,
            data : []
        },
        color : [],
        toolbox : { //工具栏显示
            show : true,
            feature : {
                saveAsImage : {}
                //显示“另存为图片”工具
            }
        },
        xAxis : { //X轴
            type : 'category',
            data : []
            //先设置数据值为空，后面用Ajax获取动态数据填入
        },
        yAxis : [ //Y轴（这里我设置了两个Y轴，左右各一个）
            {
                //第一个（左边）Y轴，yAxisIndex为0
                type : 'value',
                name : '人数',
            },
        ],
        series : []
    };

    //myChart.showLoading(); //数据加载完之前先显示一段简单的loading动画
    //myChart.setOption(option);
    var data = [];  //省份数据数组
    var newIp = []; //新增确诊数组
    var allIp = []; //累计确诊数组
    var allCure = []; //累计治愈数组
    var allDead = []; //累计死亡数组
    var dates = []; //1.19-参数日期的数组


    //显示正负号
    function showSign(param) {
        if (param >= 0) {
            return "+" + param;
        } else {
            return param;
        }
    }
    //以下为三种数据的请求
    function getNewIpData() {
        $.ajax({ //使用JQuery内置的Ajax方法
            type : "get", //post请求方式
            async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url : "MoreServlet",
            data : {
                name : name,
                type : type,
                year : $("#year").val(),
                month : $("#month").val(),
                day : $("#day").val()
            },
            dataType : "json", //返回数据形式为json
            success : function(result) {
                //document.write("123");
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                if (result != null) {
                    //解析json
                    newIp = result["newIp"];
                    dates = result["date"];
                    data = result["data"];
                    $(".dataNum1").text(data[0]);
                    $(".dataNumYesterday1").text(showSign(data[0] - data[6]));
                    $(".dataNum2").text(data[2]);
                    $(".dataNumYesterday2").text(showSign(data[2] - data[8]));
                    $(".dataNum3").text(data[4]);
                    $(".dataNumYesterday3").text(showSign(data[4] - data[10]));
                    $(".dataNum4").text(data[5]);
                    $(".dataNumYesterday4").text(showSign(data[5] - data[11]));
                    myChart.hideLoading(); //隐藏加载动画
                    myChart.setOption({ //载入数据
                        title : { //图表标题
                            text : getTitle()
                        },
                        tooltip : {
                            trigger : 'axis', //坐标轴触发提示框，多用于柱状、折线图中
                        },
                        dataZoom:[{
                            type:"inside"   //鼠标滚轮滚动进行缩放，详细配置可见echarts官网
                        }],
                        grid : {
                            x: 45,
                            x2: 65,
                            bottom:'20%',
                            top : '10%',
                        },
                        yAxis : [ //Y轴（这里我设置了两个Y轴，左右各一个）
                            {
                                //第一个（左边）Y轴，yAxisIndex为0
                                type : 'value',
                                name : '人数',
                                minInterval : 1,
                            }, ],
                        xAxis : {
                            type : 'category',
                            name : '日期',
                            data : dates
                            //填入X轴数据
                        },
                        legend : { //图表上方的类别显示
                            show : true,
                            data : [ '新增确诊人数' ]
                        },
                        color : [ '#FF3333', //曲线颜色
                        ],
                        series : [ //填入系列（内容）数据
                            {
                                // 根据名字对应到相应的系列
                                name : '新增确诊人数',
                                type : 'line',
                                symbol : 'circle',
                                data : newIp
                            }, ]
                    },true);

                }
            },
        })
    }
    function getAllIpData() {
        $.ajax({ //使用JQuery内置的Ajax方法
            type : "get", //post请求方式
            async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url : "MoreServlet", //请求发送到ShowInfoIndexServlet处
            data : {
                name : name,
                type : type,
                year : $("#year").val(),
                month : $("#month").val(),
                day : $("#day").val()
            },
            dataType : "json", //返回数据形式为json
            success : function(result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                if (result != null) {
                    allIp = result["allIp"];
                    dates = result["date"];
                    data = result["data"];
                    $(".dataNum1").text(data[0]);
                    $(".dataNumYesterday1").text(showSign(data[0] - data[6]));
                    $(".dataNum2").text(data[2]);
                    $(".dataNumYesterday2").text(showSign(data[2] - data[8]));
                    $(".dataNum3").text(data[4]);
                    $(".dataNumYesterday3").text(showSign(data[4] - data[10]));
                    $(".dataNum4").text(data[5]);
                    $(".dataNumYesterday4").text(showSign(data[5] - data[11]));
                    myChart.hideLoading(); //隐藏加载动画
                    myChart.setOption({ //载入数据
                        title : { //图表标题
                            text : getTitle()
                        },
                        tooltip : {
                            trigger : 'axis', //坐标轴触发提示框，多用于柱状、折线图中
                        },
                        dataZoom:[{
                            type:"inside"   //鼠标滚轮滚动进行缩放，详细配置可见echarts官网
                        }],
                        grid : {
                            x: 45,
                            x2: 65,
                            bottom:'20%',
                            top : '10%',
                        },
                        yAxis : [ //Y轴（这里我设置了两个Y轴，左右各一个）
                            {
                                //第一个（左边）Y轴，yAxisIndex为0
                                type : 'value',
                                name : '人数',
                                minInterval : 1,
                            }, ],
                        xAxis : {
                            type : 'category',
                            name : '日期',
                            data : dates
                            //填入X轴数据
                        },
                        legend : { //图表上方的类别显示
                            show : true,
                            data : [ '累计确诊人数' ]
                        },
                        color : [ '#FF3333', //曲线颜色
                        ],
                        series : [ //填入系列（内容）数据
                            {
                                // 根据名字对应到相应的系列
                                name : '累计确诊人数',
                                type : 'line',
                                symbol : 'circle',
                                data : allIp
                            }, ]
                    },true);

                }
            },
        })
    }
    function getAllCDData() {
        $.ajax({ //使用JQuery内置的Ajax方法
            type : "get", //post请求方式
            async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url : "MoreServlet", //请求发送到ShowInfoIndexServlet处
            data : {
                name : name,
                type : type,
                year : $("#year").val(),
                month : $("#month").val(),
                day : $("#day").val()
            },
            dataType : "json", //返回数据形式为json
            success : function(result) {
                //请求成功时执行该函数内容，result即为服务器返回的json对象
                if (result != null) {
                    allCure = result["allCure"];
                    allDead = result["allDead"];
                    dates = result["date"];
                    data = result["data"];
                    $(".dataNum1").text(data[0]);
                    $(".dataNumYesterday1").text(showSign(data[0] - data[6]));
                    $(".dataNum2").text(data[2]);
                    $(".dataNumYesterday2").text(showSign(data[2] - data[8]));
                    $(".dataNum3").text(data[4]);
                    $(".dataNumYesterday3").text(showSign(data[4] - data[10]));
                    $(".dataNum4").text(data[5]);
                    $(".dataNumYesterday4").text(showSign(data[5] - data[11]));
                    myChart.hideLoading(); //隐藏加载动画
                    myChart.setOption({ //载入数据
                        title : { //图表标题
                            text : getTitle()
                        },
                        tooltip : {
                            trigger : 'axis', //坐标轴触发提示框，多用于柱状、折线图中
                        },
                        dataZoom:[{
                            type:"inside"   //鼠标滚轮滚动进行缩放，详细配置可见echarts官网
                        }],
                        grid : {
                            x: 45,
                            x2: 65,
                            top:'10%',
                            bottom:'20%',
                        },
                        yAxis : [ //Y轴（这里我设置了两个Y轴，左右各一个）
                            {
                                //第一个（左边）Y轴，yAxisIndex为0
                                type : 'value',
                                name : '人数',
                                minInterval : 1,
                            }, ],
                        xAxis : {
                            type : 'category',
                            name : '日期',
                            data : dates
                            //填入X轴数据
                        },
                        legend : { //图表上方的类别显示
                            show : true,
                            data : [ '累计治愈人数', '累计死亡人数' ]
                        },
                        color : [ '#FF3333', //治愈曲线颜色
                            '#53FF53', //死亡曲线颜色
                        ],
                        series : [ //填入系列（内容）数据
                            {
                                // 根据名字对应到相应的系列
                                name : '累计治愈人数',
                                type : 'line',
                                symbol : 'circle',
                                data : allCure
                            }, {
                                name : '累计死亡人数',
                                type : 'line',
                                symbol : 'emptycircle',
                                data : allDead
                            } ]
                    },true);

                }
            },
        })
    }
    //获取标题
    function getTitle() {
        return null
    }
    //三种趋势图请求事件
    function typeToNewIp() {
        if (type != "newIp") {
            type = "newIp";
        }
        getNewIpData();
    }
    function typeToAllIp() {
        if (type != "allIp") {
            type = "allIp";
        }
        getAllIpData();
    }
    function typeToAllCD() {
        if (type != "allCD") {
            type = "allCD";
        }
        getAllCDData();
    }
    //数据请求事件
    function getData() {
        if (type == "newIp") {
            getNewIpData();
        } else if (type == "allIp") {
            getAllIpData();
        } else {
            getAllCDData();
        }
    }
    //初始化为请求新增确诊
    getNewIpData();
</script>

