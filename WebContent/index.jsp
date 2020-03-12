<%--
  Created by IntelliJ IDEA.
  User: ZYJ
  Date: 2020/3/10
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/css/index.css"
	rel="stylesheet">
<html>
<head>
<title>首页</title>
</head>
<body>
	<div>
		<div class="phoneDiv">
			<div class="title">实时疫情动态</div>
			<div class="subtitle">实时数据</div>
			<div class="dataArea">
				<div class="data1">
					<div class="dataName">现有确诊</div>
					<div class="dataNum1">
						45556
						<!--导入数据-->
					</div>
					<div class="yesterday">昨日</div>
					<div class="dataNumYesterday1">
						-2063
						<!--导入数据-->
					</div>
				</div>
				<div class="data2">
					<div class="dataName">现有疑似</div>
					<div class="dataNum2">
						2491
						<!--导入数据-->
					</div>
					<div class="yesterday">昨日</div>
					<div class="dataNumYesterday2">
						+439
						<!--导入数据-->
					</div>
				</div>
				<%--<div class="data3">--%>
				<%--<div class="dataName">--%>
				<%--现有重症--%>
				<%--</div>--%>
				<%--<div class="dataNum3">--%>
				<%--8752<!--导入数据-->--%>
				<%--</div>--%>
				<%--<div class="yesterday">--%>
				<%--昨日--%>
				<%--</div>--%>
				<%--<div class="dataNumYesterday3">--%>
				<%---374<!--导入数据-->--%>
				<%--</div>--%>
				<%--</div>--%>
				<div class="data3">
					<div class="dataName">累计确诊</div>
					<div class="dataNum4">
						78191
						<!--导入数据-->
					</div>
					<div class="yesterday">昨日</div>
					<div class="dataNumYesterday4">
						+411
						<!--导入数据-->
					</div>
				</div>
				<div class="data5">
					<div class="dataName">累计治愈</div>
					<div class="dataNum5">
						29917
						<!--导入数据-->
					</div>
					<div class="yesterday">昨日</div>
					<div class="dataNumYesterday5">
						+2596
						<!--导入数据-->
					</div>
				</div>
				<div class="data6">
					<div class="dataName">累计死亡</div>
					<div class="dataNum6">
						2718
						<!--导入数据-->
					</div>
					<div class="yesterday">昨日</div>
					<div class="dataNumYesterday6">
						+52
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

							<div id="jqbtn" onclick="getData()"
								style="width: 30px; height: 20px; background-color: #e6b900; border: 0px; border-radius: 3px;">提交</div>
						</div>
					</form>
				</div>
			</div>
			<div class="confirm">
				<div class="now" onclick="typeToNow()">现有确诊</div>
				<div class="accumulated" onclick="typeToAll()">累计确诊</div>
			</div>
			<div>
				<!--echarts图-->
				<%@include file="nationStatistic.jsp"%>

			</div>
			<div></div>
			<div></div>
			<div></div>
			<!--扩展功能块-->
		</div>

	</div>
</body>
</html>
