package repository;

import java.sql.*;

import vo.Customer;

// CustomerService가 호출
public class CustomerDao {

	// 로그인 메소드
	public Customer selectCustomerByIdAndPw(Connection conn, Customer customer) throws Exception {
		System.out.println("------------------ CustomerDao.selectCustomerByIdAndPw()");
		
		Customer loginCustomer = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "select customer_id customerId, customer_name customerName from customer" 
				+ " where customer_id = ? and customer_pass = password(?)";

		try {
			stmt = conn.prepareStatement(sql);
			

			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());

			rs = stmt.executeQuery();

			if (rs.next()) { // rs.next() == true 면 로그인 성공
				// loginCustomer 인스턴스 채우기
				loginCustomer = new Customer();
				loginCustomer.setCustomerId(rs.getString("customerId"));
				loginCustomer.setCustomerName(rs.getString("customerName"));
			}

		} finally {
			// 자원해제
			if (rs != null) {
				rs.close();
			}
			
			if (stmt != null) {
				stmt.close();
			}
		}

		return loginCustomer;
	}

	// 탈퇴: CustomerService.removeCustomer(Customer paramCustomer)
	public int deleteCustomer(Connection conn, Customer paramCustomer) throws Exception {
		// 할일: insert outid, delete customer
		// conn.close() 불가 -> 동일한 conn을 사용해야 트랜잭션 가능

		int row = 0;
		PreparedStatement stmt = null;
		String sql = "delete from customer where customer_id = ? and customer_pass = password(?)";

		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());

			row = stmt.executeUpdate();
			
		} finally {
			
			if(stmt != null) { stmt.close(); }
		
		}
		
		return row;
	}

	// 회원가입
	public int insertCustomer(Connection conn, Customer paramCustomer) throws Exception {
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "insert into customer(customer_id, customer_pass, customer_name, customer_address, customer_detail_address, customer_telephone, update_date, create_date)"
				+ "values(?, password(?), ?, ?, ?, ?, now(), now())";

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			stmt.setString(3, paramCustomer.getCustomerName());
			stmt.setString(4, paramCustomer.getCustomerAddress());
			stmt.setString(5, paramCustomer.getCustomerDetailAddress());
			stmt.setString(6, paramCustomer.getCustomerTelephone());

			row = stmt.executeUpdate();
		} finally {

			if (stmt != null) {
				stmt.close();
			}
		}

		return row;
	}
}
