package service;

import java.sql.*;

public class DBUtil {
	
	public Connection getConnection() throws Exception {
		// Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://43.200.247.48:3306/shop";
		
		return DriverManager.getConnection(url, "root", "1234");
	}
}