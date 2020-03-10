<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<meta charset="utf-8">
</head>
<body style="height: 100%; margin: 0">
	<div id="container" style="height: 100%"></div>
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
		option = null;
		option = {
			tooltip : {
				trigger : 'item'
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
				name : '感染人数',
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
				data : [ {
					name : '北京',
					value : 197
				}, {
					name : '天津',
					value : 45
				}, {
					name : '上海',
					value : 71
				}, {
					name : '重庆',
					value : 234
				}, {
					name : '河北',
					value : 71
				}, {
					name : '河南',
					value : 307
				}, {
					name : '云南',
					value : 44
				}, {
					name : '辽宁',
					value : 38
				}, {
					name : '黑龙江',
					value : 239
				}, {
					name : '湖南',
					value : 281
				}, {
					name : '安徽',
					value : 291
				}, {
					name : '山东',
					value : 409
				}, {
					name : '新疆',
					value : 44
				}, {
					name : '江苏',
					value : 173
				}, {
					name : '浙江',
					value : 421
				}, {
					name : '江西',
					value : 287
				}, {
					name : '湖北',
					value : 45044
				}, {
					name : '广西',
					value : 137
				}, {
					name : '甘肃',
					value : 11
				}, {
					name : '山西',
					value : 43
				}, {
					name : '内蒙古',
					value : 42
				}, {
					name : '陕西',
					value : 69
				}, {
					name : '吉林',
					value : 32
				}, {
					name : '福建',
					value : 109
				}, {
					name : '贵州',
					value : 41
				}, {
					name : '广东',
					value : 546
				}, {
					name : '青海',
					value : 0
				}, {
					name : '西藏',
					value : 0
				}, {
					name : '四川',
					value : 248
				}, {
					name : '宁夏',
					value : 13
				}, {
					name : '海南',
					value : 47
				}, {
					name : '台湾',
					value : 24
				}, {
					name : '香港',
					value : 58
				}, {
					name : '澳门',
					value : 4
				} ],
				colorMappingBy : 'value'
			} ]
		};

		if (option && typeof option === "object") {
			myChart.setOption(option, true);
		}
	</script>
</body>
</html>