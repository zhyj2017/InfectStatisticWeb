<%@ page pageEncoding="UTF-8"%>
<div id="container" style="height: 100%;width:100%;position: absolute;top:150px;z-index:-1"></div>
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/echarts-gl/dist/echarts-gl.min.js"></script>
<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/echarts-stat/dist/ecStat.min.js"></script>
<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/echarts/dist/extension/dataTool.min.js"></script>
<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/echarts/map/js/china.js"></script>
<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/echarts/map/js/world.js"></script>
<script type="text/javascript">
    var dom = document.getElementById("container");
    var myChart = echarts.init(dom);
    var type = "now";
    function fillData(data) {
        var option = null;
        option = {
            tooltip : {
                trigger : 'item',
                formatter : function(e, t, n) {
                    return (.5 == e.value ? e.name + "：有疑似病例" : e.seriesName
                        + "<br />" + e.name + "："
                        + (isNaN(e.value) ? 0 : e.value))
                        + '<br><a class="more" style="color: yellow" href="province.jsp?name='
                        + e.name
                        + '&year='
                        + $("#year").val()
                        + '&month='
                        + $("#month").val()
                        + '&day='
                        + $("#day").val()
                        + '">详情</a>';
                },
                //triggerOn: "click",
                enterable : true
            },
            visualMap : {
                type : 'piecewise',
                min : 0,
                max : 300,
                left : 'left',
                top : 'bottom', // 文本，默认为数值文本
                calculable : true,
                pieces : [ {
                    value : 0,
                    color : '#fff'
                }, {
                    min : 1,
                    max : 9,
                    color : 'rgb(255,170,133)'
                }, {
                    min : 10,
                    max : 99,
                    color : 'rgb(255,123,105)'
                }, {
                    min : 100,
                    max : 999,
                    color : 'rgb(204,41,41)'
                }, {
                    min : 1000,
                    max : 9999,
                    color : 'rgb(140,13,13)'
                }, {
                    min : 10000,
                    color : 'rgb(102,2,8)'
                } ]
            },

            series : [ {
                name : '确诊人数',
                type : 'map',
                mapType : 'china',
                roam : false,
                showLegendSymbol : false,
                label : {
                    normal : {
                        show : true
                    },
                    emphasis : {
                        show : true
                    }
                },
                data : data,
                colorMappingBy : 'value'
            } ]
        };
        return option;
    }
    function showSign(param) {
        if (param >= 0) {
            return "+" + param;
        } else {
            return param;
        }
    }
    function getData() {
        $.ajax({
            type : "get",
            async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url : "test", //请求发送到TestServlet处
            data : {
                year : $("#year").val(),
                month : $("#month").val(),
                day : $("#day").val(),
                type : type
            },
            dataType : "json", //返回数据形式为json
            success : function(result) {
                var nationData = result["全国"];
                var provinceName = result["省名"];
                var provinceValue = result["值"];
                var provinceData = new Array();
                for (var i = 0; i < provinceName.length; i++) {
                    var row = new Object();
                    row.name = provinceName[i];
                    row.value = provinceValue[i];
                    provinceData.push(row);
                }
                $(".dataNum1").text(nationData[6]);
                $(".dataNumYesterday1").text(
                    showSign(nationData[6] - nationData[0]));
                $(".dataNum2").text(nationData[7]);
                $(".dataNumYesterday2").text(
                    showSign(nationData[7] - nationData[1]));
                $(".dataNum4").text(nationData[8]);
                $(".dataNumYesterday4").text(
                    showSign(nationData[8] - nationData[2]));
                $(".dataNum5").text(nationData[10]);
                $(".dataNumYesterday5").text(
                    showSign(nationData[10] - nationData[4]));
                $(".dataNum6").text(nationData[11]);
                $(".dataNumYesterday6").text(
                    showSign(nationData[11] - nationData[5]));
                myChart.setOption(fillData(provinceData), true);
            }
        })
    }
    function typeToAll() {
        if (type == "now") {
            type = "all";
        }
        getData();
    }
    function typeToNow() {
        if (type == "all") {
            type = "now";
        }
        getData();
    }
    getData();
</script>
