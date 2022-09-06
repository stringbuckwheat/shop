package service;

import java.sql.*;

public class DBUtil {
	
	public Connection getConnection() throws Exception {
		// Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.106.67:3306/shop";
		
		return DriverManager.getConnection(url, "root", "1234");
	}
}