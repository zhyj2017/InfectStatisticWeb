package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.omg.CORBA.OBJ_ADAPTER;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.sun.java_cup.internal.runtime.virtual_parse_stack;

import dao.ProvinceDAO;
import dao.ProvinceDAOImpl;
import pojo.Province;
import util.DateUtil;

/**
 * Servlet implementation class test
 */
@WebServlet("/test")
public class ProvinceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProvinceServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		ProvinceDAO provinceDAO = new ProvinceDAOImpl();
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String type = request.getParameter("type");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> provinceName = new ArrayList<String>();
		List<Integer> provinceValue = new ArrayList<Integer>();
		List<Integer> nation = new ArrayList<Integer>();
		String dateString = "";
		String yesterdayString = "";
		//判断日期合法
		if (year != null && month != null && day != null && type != null) {
			if (!year.equals("") && !month.equals("") && !day.equals("")) {
				if (year.compareTo("2020") == 0
						&& ((Integer.parseInt(month) == 2 && Integer.parseInt(day) > 0 && Integer.parseInt(day) < 3)
								|| (Integer.parseInt(month) == 1 && Integer.parseInt(day) > 18
										&& Integer.parseInt(day) < 32))) {
					dateString = year + "-" + month + "-" + day;
				} else {
					dateString = "2020-02-02";
				}
			} else {
				dateString = "2020-02-02";
			}
			try {
				yesterdayString = DateUtil.getYesterday(dateString);
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			try {
				//写入日期前一天数据
				if (format.parse(yesterdayString).getTime() < format.parse("2020-01-19").getTime()) {
					nation.add(0);
					nation.add(0);
					nation.add(0);
					nation.add(0);
					nation.add(0);
					nation.add(0);
				} else {
					Date yesterday = new Date(format.parse(yesterdayString).getTime());
					Province p = provinceDAO.get("全国", yesterday);
					nation.add(p.getNowIp());
					nation.add(p.getNowSp());
					nation.add(p.getAllIp());
					nation.add(p.getAllSp());
					nation.add(p.getAllCure());
					nation.add(p.getAlldead());
				}
				Province data[] = provinceDAO.getListByDate(new Date(format.parse(dateString).getTime()));
				for (Province p : data) {
					if (!p.getName().equals("全国")) {
						provinceName.add(p.getName());
						if (type != null && type.equals("now")) {
							provinceValue.add(p.getNowIp());
						} else {
							provinceValue.add(p.getAllIp());
						}
					} else {
						//写入当天日期数据
						nation.add(p.getNowIp());
						nation.add(p.getNowSp());
						nation.add(p.getAllIp());
						nation.add(p.getAllSp());
						nation.add(p.getAllCure());
						nation.add(p.getAlldead());
						map.put("全国", nation);
					}
				}
				//写入map
				map.put("省名", provinceName);
				map.put("值", provinceValue);
				//转换成接送发送
				JSONObject json = JSONObject.parseObject(JSON.toJSONString(map));
				out.write(json.toString());
				out.flush();
				out.close();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
