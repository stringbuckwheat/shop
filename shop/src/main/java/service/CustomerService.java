package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CustomerDao;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {
	// loginAction.jsp 호출
	
	public Customer getCustomerByIdAndPw(Customer paramCustomer) throws Exception{
		Connection conn = null;
		Customer customer = null;
		
		try {
			conn = new DBUtil().getConnetion();

			CustomerDao customerDao = new CustomerDao();
			customer = customerDao.selectCustomerByIdAndPw(conn, paramCustomer);
			
			// 디버깅
			if(customer != null ) {
				System.out.println("회원 로그인 메소드 성공");
			}
			
		} catch(Exception e) {
			e.printStackTrace(); // *****
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return customer;
	}
	
	// 이제 예외를 action까지 던지지 않음
	// 일단 rset과 stmt의 close()는 생략
	public boolean removeCustomer(Customer paramCustomer) {
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnetion();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋 해제
			
			CustomerDao customerDao = new CustomerDao();
			
			if(customerDao.deleteCustomer(conn, paramCustomer) == 1) {
				throw new Exception(); // 오류는 발생하지 않았지만 삭제는 안 된 경우
			}
			
			OutIdDao outIdDao = new OutIdDao();
			
			if(outIdDao.insertOutId(conn, paramCustomer.getCustomerId()) != 1) {
				throw new Exception(); // 마찬가지 
			}
			
			conn.commit(); // exception 발생 시 내려오지 않음
		
		} catch(Exception e) {
			e.printStackTrace(); // *****
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			return false;
			
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return true;
	} // end for removeCustomer
}
