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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import dao.ProvinceDAO;
import dao.ProvinceDAOImpl;
import pojo.Province;
import util.DBUtil;
import util.DateUtil;

/**
 * Servlet implementation class MoreServlet
 */
@WebServlet("/MoreServlet")
public class MoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MoreServlet() {
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
		String name = request.getParameter("name");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Map<String, Object> map = new HashMap<String, Object>();
		List<Integer> province = new ArrayList<Integer>();
		List<Integer> allIpData = new ArrayList<Integer>();
		List<Integer> newIpData = new ArrayList<Integer>();
		List<Integer> allCureData = new ArrayList<Integer>();
		List<Integer> allDeadData = new ArrayList<Integer>();
		List<String> dates = new ArrayList<String>();
		String dateString = "";
		String yesterdayString = "";
		if (year != null && month != null && day != null && type != null && name != null) {
			if (!year.equals("") && !month.equals("") && !day.equals("")) {
				if (year.compareTo("2020") == 0
						&& ((Integer.parseInt(month) == 2 && Integer.parseInt(day) > 0 && Integer.parseInt(day) < 3)
								|| (Integer.parseInt(month) == 1 && Integer.parseInt(day) > 18
										&& Integer.parseInt(day) < 32))) {
					dateString = year + "-" + month + "-" + day;
				}
				else {
					dateString = "2020-02-02";
				}
			} else {
				dateString = "2020-02-02";
			}
			try {
				yesterdayString = DateUtil.getYesterday(dateString);
				Date today = new Date(format.parse(dateString).getTime());
				Province data[] = provinceDAO.getListByName(name);
				Province p = provinceDAO.get(name, new Date(format.parse(dateString).getTime()));
				province.add(p.getNowIp());
				province.add(p.getNowSp());
				province.add(p.getAllIp());
				province.add(p.getAllSp());
				province.add(p.getAllCure());
				province.add(p.getAlldead());
				if (format.parse(yesterdayString).getTime() < format.parse("2020-01-19").getTime()) {
					province.add(0);
					province.add(0);
					province.add(0);
					province.add(0);
					province.add(0);
					province.add(0);
				} else {
					p = provinceDAO.get(name, new Date(format.parse(yesterdayString).getTime()));
					province.add(p.getNowIp());
					province.add(p.getNowSp());
					province.add(p.getAllIp());
					province.add(p.getAllSp());
					province.add(p.getAllCure());
					province.add(p.getAlldead());
				}
				String tempday = "2020-01-19";
				for (Province p1 : data) {
					if (p1.getDate().getTime() <= today.getTime()) {
						if (format.format(p1.getDate()).compareTo(tempday) > 0) {
							while (format.format(p1.getDate()).compareTo(tempday) > 0) {
								dates.add(tempday);
								newIpData.add(0);
								allCureData.add(0);
								allDeadData.add(0);
								allIpData.add(0);
								tempday = DateUtil.getNxetday(tempday);
							}
							tempday = "2020-12-31";
						}
						if (type.equals("newIp")) {
							yesterdayString = DateUtil.getYesterday(format.format(p1.getDate()));
							if (format.parse(yesterdayString).getTime() < format.parse("2020-01-19").getTime()) {
								newIpData.add(p1.getAllIp());
							} else {
								p = provinceDAO.get(name, new Date(format.parse(yesterdayString).getTime()));
								newIpData.add(p1.getAllIp() - p.getAllIp());
							}
						} else if (type.equals("allIp")) {
							allIpData.add(p1.getAllIp());

						} else {
							allCureData.add(p1.getAllCure());
							allDeadData.add(p1.getAlldead());
						}
						dates.add(format.format(p1.getDate()));
					}
				}
				map.put("data", province);
				map.put("allCure", allCureData);
				map.put("allDead", allDeadData);
				map.put("allIp", allIpData);
				map.put("newIp", newIpData);
				map.put("date", dates);
				JSONObject json = JSONObject.parseObject(JSON.toJSONString(map));
				out.write(json.toString());
				out.flush();
				out.close();
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
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
