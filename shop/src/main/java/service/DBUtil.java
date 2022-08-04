package service;

import java.sql.*;

public class DBUtil {
	
	public Connection getConnetion() throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/shop";
		
		return DriverManager.getConnection(url, "root", "1234");
	}
}