package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.Customer;
import vo.Employee;

//TODO: try-finally

public class SignDao {
	
	// return값이 boolean일 때의 문제점: DAO에서 데이터를 가공하는 것은 좋지 않음
	public String checkId(Connection conn, String id) throws Exception{
		String checkId = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// customer_id, employee_id, out_id 중 중복된 값이 있는지
		String sql = "select t.id from (select customer_id id from customer union select employee_id id from employee union select out_id id from outid) t where t.id = ?";		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			checkId = rs.getString("t.id");
		}
		
		if(rs != null) {
			rs.close();
		}
		
		if(stmt != null) {
			stmt.close();
		}
		
		return checkId;
	}
	
	
}
