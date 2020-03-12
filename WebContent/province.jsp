<%--
  Created by IntelliJ IDEA.
  User: ZYJ
  Date: 2020/3/10
  Time: 21:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<link href="${pageContext.request.contextPath}/css/province.css"
	rel="stylesheet">
<html>
<head>
<title>省份详情</title>
</head>
<body>
	<div>
		<div class="phoneDiv" "position:static">
			<div class="backButton" onclick="window.open('index.jsp','_self')">
				<img src="img/back.png">
			</div>
			<div class="title">实时统计</div>
			<div class="subtitle">
				湖北
				<!--导入数据-->
			</div>
			<div class="dataArea">
				<div class="data1">
					<div class="dataName">现有确诊</div>
					<div class="dataNum1">
						XXXX
						<!--导入数据-->
					</div>
					<div class="yesterday">昨日</div>
					<div class="dataNumYesterday1">
						-XXX
						<!--导入数据-->
					</div>
				</div>
				<div class="data2">
					<div class="dataName">累计确诊</div>
					<div class="dataNum2">
						XXXX
						<!--导入数据-->
					</div>
					<div class="yesterday">昨日</div>
					<div class="dataNumYesterday2">
						+XXX
						<!--导入数据-->
					</div>
				</div>
				<div class="data3">
					<div class="dataName">累计治愈</div>
					<div class="dataNum3">
						XXXX
						<!--导入数据-->
					</div>
					<div class="yesterday">昨日</div>
					<div class="dataNumYesterday3">
						-XXX
						<!--导入数据-->
					</div>
				</div>
				<div class="data4">
					<div class="dataName">累计死亡</div>
					<div class="dataNum4">
						XXXX
						<!--导入数据-->
					</div>
					<div class="yesterday">昨日</div>
					<div class="dataNumYesterday4">
						+XX
						<!--导入数据-->
					</div>
				</div>
				<div class="timeDiv">
					<form class="timeForm" action="" method="post">
						<div class="yearInput">
							<input id="year" name="year" type="text">年
						</div>
						<div class="monthInput">
							<input id="month" name="month" type="text">月
						</div>
						<div class="dayInput">
							<input id="day" name="day" type="text">日
						</div>
						<div class="confirmButton">
							<button type="submit">确认</button>
						</div>
					</form>
				</div>
			</div>
			<div class="chartButton">
				<div class="newConfirm">
					新增<br>确诊趋势
				</div>
				<div class="accumulatedConfirm">
					累计<br>确诊趋势
				</div>
				<div class="accumulatedCureDead">
					累计<br>治愈/死亡
				</div>
			</div>
			<%@include file="trend.jsp"%>
		</div>
	</div>
</body>
</html>
