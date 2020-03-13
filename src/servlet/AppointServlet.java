package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/AppointServlet")
public class AppointServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String identity = request.getParameter("identity");
        String mobile = request.getParameter("mobile");
        String time = request.getParameter("time");
        String place = request.getParameter("place");
        String message = null;
        if (name != null && identity != null && mobile != null
                && !time.equals("请选择领取时间") && !place.equals("请选择领取地点")){
            message = "恭喜您，预约成功";
        }else {
            message = "信息输入有误，请重新输入";
        }
        request.setAttribute("message",message);
        request.getRequestDispatcher("appointment.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
