import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

import com.sun.org.apache.xerces.internal.impl.xs.identity.Selector.Matcher;

import dao.ProvinceDAO;
import dao.ProvinceDAOImpl;
import pojo.Province;

//import com.sun.org.apache.xalan.internal.xsltc.compiler.Pattern;

import util.DBUtil;

public class writeDatabase {
	public static void main(String[] args) throws SQLException {

        try {
            //第一次运行，创建数据表，后注释
//            Connection conn = DBUtil.getConnection();
//            String sql = "create table infectData (name varchar(20),nowIp int, nowSp int," +
//                    " allIp int, allSp int,allCure int, allDead int,date Date)";
//            PreparedStatement statement = conn.prepareStatement(sql);
//            statement.executeUpdate();
//             DBUtil.close(null,statement,conn);
            //创建数据库表后即可使用，读取文件将数据存进数据库
            File folder = new File("D:\\homework\\infectResult");
            File files[] = folder.listFiles();
            String temp;
            String temps[];
            String name;
            int nowIp, nowSp, allIp, allSp, allCure, allDead;
            Date date;
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Province province = new Province();
            ProvinceDAO provinceDAO = new ProvinceDAOImpl();
            for (File file : files) {
                InputStreamReader inputReader = new InputStreamReader(new FileInputStream(file), "UTF-8");
                BufferedReader br = new BufferedReader(inputReader);
                String fileName = file.getName().substring(0, 10);
                date = new Date(format.parse(fileName).getTime());
                while ((temp = br.readLine()) != null) {
                    if (temp.indexOf("//") != 0 && !temp.equals("")) {
                        temps = temp.split(" ");
                        name = temps[0];
                        nowIp = getNum(temps[1]);
                        nowSp = getNum(temps[2]);
                        allCure = getNum(temps[3]);
                        allDead = getNum(temps[4]);
                        allIp = getNum(temps[5]);
                        allSp = getNum(temps[6]);
                        province.setName(name);
                        province.setNowIp(nowIp);
                        province.setNowSp(nowSp);
                        province.setAllCure(allCure);
                        province.setAllDead(allDead);
                        province.setAllIp(allIp);
                        province.setAllSp(allSp);
                        province.setDate(date);
                        provinceDAO.add(province);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

		ProvinceDAO provinceDAO = new ProvinceDAOImpl();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Province p = provinceDAO.get("全国", new Date(format.parse("2020-01-21").getTime()));
			System.out.println(p.getName() + " " + p.getNowIp() + " " + p.getNowSp() + " " + p.getAllCure() + " "
					+ p.getAlldead());
			Province ps[]=provinceDAO.getListByDate(new Date(format.parse("2020-01-21").getTime()));
			for (Province p1 : ps) {
				System.out.println(p1.getName() + " " + p1.getNowIp() + " " + p1.getNowSp() + " " + p1.getAllCure() + " "
						+ p1.getAlldead());
			}
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*String sql = "select * from infectData";
		try {
			Connection c = DBUtil.getConnection();
			PreparedStatement ps = c.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			int cnt = 0;
			while (rs.next()) {
				System.out.println(rs.getString("name")+" "+
				rs.getInt("nowIp")+" "+
				rs.getInt("nowSp")+" "+
				rs.getInt("allIp")+" "+
				rs.getInt("allSp")+" "+
				rs.getDate("date").toString());
			}
			DBUtil.close(rs, ps, c);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}*/

	}

	public static int getNum(String param) {
		Pattern pattern = Pattern.compile("\\d+");
		java.util.regex.Matcher matcher = pattern.matcher(param);
		while (matcher.find()) {
			return Integer.parseInt(matcher.group(0));
		}
		return -1;
	}
}
