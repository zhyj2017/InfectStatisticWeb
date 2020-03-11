<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<meta charset="utf-8">
</head>
<body style="height: 100%; margin: 0">
	<form action="">
		<input id="year" value="2020"><input> <input
			id="month" value="01"><input> <input id="day"
			value="19"><input>
	</form>
	<div id="container" style="height: 100%"></div>
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
		function fillData(data) {
			var option = null;
			option = {
				tooltip : {
					trigger : 'item',
					formatter : function(e, t, n) {
						return (.5 == e.value ? e.name + "：有疑似病例"
								: e.seriesName + "<br />" + e.name + "："
										+ (isNaN(e.value) ? 0 : e.value))
								+ '<br><button class="more" type="button" onclick="">详情</button>';
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
				toolbox : {
					show : true,
					orient : 'vertical',
					left : 'right',
					top : 'center',
					feature : {
						mark : {
							show : true
						},
						dataView : {
							show : true,
							readOnly : false
						},
						restore : {
							show : true
						},
						saveAsImage : {
							show : true
						}
					}
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
		function getData() {
			$.ajax({
				type : "get",
				async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
				url : "test", //请求发送到TestServlet处
				data : {
					year : $("#year").val(),
					month : $("#month").val(),
					day : $("#day").val()
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
					//document.write(provinceData);
					myChart.setOption(fillData(provinceData), true);
				}
			})
		}
		getData();
	</script>
</body>
</html>