package repository;

import java.sql.*;

public class OutIdDao {
	// 탈퇴 회원의 아이디 입력
	public int insertOutId(Connection conn, String id) throws Exception {
		// 동일한 conn 필요
		// CustomerService.removeCustomer(Customer paramCustomer)
		
		System.out.println("------------ OutIdDao.insertOutId()");

		int row = 0;
		String sql = "insert into outid(out_id, out_date) values (?, now())";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt);
			
			stmt.setString(1, id);
			row = stmt.executeUpdate();
			
			if(row == 1) {
				System.out.println("OutIdDao.insertOutId() 성공!");
			}
			
		} finally {

			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
}
