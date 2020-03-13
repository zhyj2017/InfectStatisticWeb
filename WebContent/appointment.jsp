<%--
  Created by IntelliJ IDEA.
  User: ZYJ
  Date: 2020/3/11
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="${pageContext.request.contextPath}/css/appointment.css" rel="stylesheet">
<html>
<head>
    <title>口罩预约</title>
</head>
<body>
    <div>
        <div class="phoneDiv">
            <div class="backButton" onclick="window.open('index.jsp','_self')">
                <img src="img/back.png">
            </div>
            <div class="title">
                口罩预约
            </div>
            <div class="informationForm">
                <form action="AppointServlet">
                    <div class="name">
                        姓名<br>
                        <input id="name" name="name" type="text">
                    </div>
                    <div class="identity">
                        身份证号<br>
                        <input id="identity" name="identity" type="text">
                    </div>
                    <div class="mobile">
                        手机号<br>
                        <input id="mobile" name="mobile" type="text">
                    </div>
                    <div class="time">
                        领取时间<br>
                        <select id="time" name="time">
                            <option>请选择领取时间</option>
                            <option>8:00-12:00</option>
                            <option>12:00-16:00</option>
                            <option>16:00-20:00</option>
                        </select>
                    </div>
                    <div class="place">
                        领取地点<br>
                        <select id="place" name="place">
                            <option>请选择领取地点</option>
                            <option>xx省xx市xx区xx药店</option>
                        </select>
                    </div>
                    <div class="submit">
                        <button type="submit">预约</button>
                    </div>
                    <%
                        String message = (String)request.getAttribute("message");
                        if(message != null) {
                    %>
                    <script type="text/javascript" language="javascript">
                        alert("<%=message%>");
                        window.location='appointment.jsp';
                    </script>
                    <%
                        }
                    %>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
