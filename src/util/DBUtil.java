package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	static Connection conn;
	public static Connection getConnection() throws SQLException, ClassNotFoundException {		
		Class.forName("org.sqlite.JDBC");
		// 建立一个数据库名zieckey.db的连接，如果不存在就在当前目录下创建之
		conn = DriverManager.getConnection("jdbc:sqlite:infectDB");
		return conn;
	}
	public static void close() {
		try {
			if (conn != null)
				conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
