package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import util.DBUtil;
import pojo.Province;

import java.util.ArrayList;
import java.util.List;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import util.DBUtil;
import pojo.Province;

import java.util.ArrayList;
import java.util.List;

public class ProvinceDAOImpl implements ProvinceDAO {

	//增加
	@Override
	public void add(Province province) {
		// TODO Auto-generated method stub
		String sql = "insert into infectData values(? ,? ,? ,? ,? ,? ,? ,?)";
		try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setString(1, province.getName());
			ps.setInt(2, province.getNowIp());
			ps.setInt(3, province.getNowSp());
			ps.setInt(4, province.getAllIp());
			ps.setInt(5, province.getAllSp());
			ps.setInt(6, province.getAllCure());
			ps.setInt(7, province.getAlldead());
			ps.setDate(8, province.getDate());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}

	@Override
	public void update(Province province) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(String name, Date date) {
		// TODO Auto-generated method stub

	}

	//获取单个对象
	@Override
	public Province get(String name, Date date) {
		// TODO Auto-generated method stub
		String sql = "select * from infectData where name = ? and date = ?";
		Province temp = new Province();
		try {
			Connection c = DBUtil.getConnection();
			PreparedStatement ps = c.prepareStatement(sql);
			ps.setString(1, name.trim());
			ps.setDate(2, date);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				temp.setName(rs.getString("name"));
				temp.setNowIp(rs.getInt("nowIp"));
				temp.setNowSp(rs.getInt("nowSp"));
				temp.setAllIp(rs.getInt("allIp"));
				temp.setAllSp(rs.getInt("allSp"));
				temp.setAllCure(rs.getInt("allCure"));
				temp.setAllDead(rs.getInt("allDead"));
				temp.setDate(rs.getDate("date"));
			}
			DBUtil.close(rs, ps, c);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return temp;
	}

	//通过日期获取对象集
	@Override
	public Province[] getListByDate(Date date) {
		// TODO Auto-generated method stub
		String sql = "select * from infectData where date = ? ";
		try {
			Connection c = DBUtil.getConnection();
			PreparedStatement ps = c.prepareStatement(sql);
			ps.setDate(1, date);
			ResultSet rs = ps.executeQuery();
			Province temp;
			List<Province> list = new ArrayList<Province>();
			while (rs.next()) {
				temp = new Province();
				temp.setName(rs.getString("name"));
				temp.setNowIp(rs.getInt("nowIp"));
				temp.setNowSp(rs.getInt("nowSp"));
				temp.setAllIp(rs.getInt("allIp"));
				temp.setAllSp(rs.getInt("allSp"));
				temp.setAllCure(rs.getInt("allCure"));
				temp.setAllDead(rs.getInt("allDead"));
				temp.setDate(rs.getDate("date"));
				list.add(temp);
			}
			DBUtil.close(rs, ps, c);
			return (Province[]) list.toArray(new Province[list.size()]);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return null;
	}

	//通过名字获取对象集
	@Override
	public Province[] getListByName(String name) {
		// TODO Auto-generated method stub
		String sql = "select * from infectData where name = ? order by date";
		try {
			Connection c = DBUtil.getConnection();
			PreparedStatement ps = c.prepareStatement(sql);
			ps.setString(1, name.trim());
			ResultSet rs = ps.executeQuery();
			Province temp;
			List<Province> list = new ArrayList<Province>();
			while (rs.next()) {
				temp = new Province();
				temp.setName(rs.getString("name"));
				temp.setNowIp(rs.getInt("nowIp"));
				temp.setNowSp(rs.getInt("nowSp"));
				temp.setAllIp(rs.getInt("allIp"));
				temp.setAllSp(rs.getInt("allSp"));
				temp.setAllCure(rs.getInt("allCure"));
				temp.setAllDead(rs.getInt("allDead"));
				temp.setDate(rs.getDate("date"));
				list.add(temp);
			}
			DBUtil.close(rs, ps, c);
			return (Province[]) list.toArray(new Province[list.size()]);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return null;
	}

}

