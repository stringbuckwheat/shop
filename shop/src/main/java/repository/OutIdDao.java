package repository;

import java.sql.*;

//TODO: try-finally
public class OutIdDao {
	// 탈퇴 회원의 아이디 입력
	public int insertOutId(Connection conn, String id) throws Exception {
		// 동일한 conn 필요	
		// CustomerService.removeCustomer(Customer paramCustomer)
		
		int row = 0;
		
		String sql = "insert into outid(out_id, out_date) values (?, now())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		row = stmt.executeUpdate();
			
		stmt.close();

		return row;
	}
}
