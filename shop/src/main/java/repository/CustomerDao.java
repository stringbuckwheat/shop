package repository;

import java.sql.*;

import service.DBUtil;
import vo.Customer;

public class CustomerDao {
	// CustomerService가 호출
	public Customer selectCustomerByIdAndPw(Connection conn, Customer customer) throws Exception{
		Customer loginCustomer = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "select customer_id customerId, customer_name customerName from customer where customer_id = ? and customer_pass = password(?)";
		
		stmt = conn.prepareStatement(sql);

		stmt.setString(1, customer.getCustomerId());
		stmt.setString(2, customer.getCustomerPass());

		rs = stmt.executeQuery();
		// System.out.println("rs: " + rs);
		
		// 받아온 값이 없으면 return
		if(!rs.next()) 
			return loginCustomer;
		
		// loginCustomer 인스턴스 채우기
		loginCustomer = new Customer();
		loginCustomer.setCustomerId(rs.getString("customerId"));
		loginCustomer.setCustomerName(rs.getString("customerName"));
		
		// 자원해제
		rs.close();
		stmt.close();
		
		return loginCustomer;
	}
	
	// 탈퇴: CustomerService.removeCustomer(Customer paramCustomer)
	public int deleteCustomer(Connection conn, Customer paramCustomer) throws Exception {
		// 할일: insert outid, delete customer
		// conn.close() 불가 -> 동일한 conn을 사용해야 트랜잭션 가능
		
		int row = 0;
		PreparedStatement stmt = null;

		String sql = "delete from customer where customer_id = ? and customer_pass = password(?)";
		stmt = conn.prepareStatement(sql);
	
		stmt.setString(1, paramCustomer.getCustomerId());
		stmt.setString(2, paramCustomer.getCustomerPass());
	
		row = stmt.executeUpdate();
	
		stmt.close();
		
		return row;
	}
	
	public int insertCustomer(Connection conn, Customer paramCustomer) throws Exception{
		int row = 0;
		
		String sql = "insert into customer(customer_id, customer_pass, customer_name, customer_address, customer_telephone, update_date, create_date)"
				+ "values(?, password(?), ?, ?, ?, now(), now())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCustomer.getCustomerId());
		stmt.setString(2, paramCustomer.getCustomerPass());
		stmt.setString(3, paramCustomer.getCustomerName());
		stmt.setString(4, paramCustomer.getCustomerAddress());
		stmt.setString(5, paramCustomer.getCustomerTelephone());
		
		row = stmt.executeUpdate();
		
		if(stmt != null) {
			stmt.close();
		}
		
		return row;
	}
}
