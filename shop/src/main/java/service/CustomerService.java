package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CustomerDao;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {
	private CustomerDao customerDao;
	private DBUtil dbUtil;
	
	public CustomerService() {
		super();
		this.customerDao = new CustomerDao();
		this.dbUtil = new DBUtil();
	}

	public Customer getCustomerByIdAndPw(Customer paramCustomer) throws Exception{
		Connection conn = null;
		Customer customer = null;
		
		try {
			conn = dbUtil.getConnetion();
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
			conn = dbUtil.getConnetion();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋 해제
						
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
	
	public boolean addCustomer(Customer paramCustomer) {
		Connection conn = null;
		boolean result = true; // 메소드 실행 결과값을 담을 변수
		
		try {
			conn = dbUtil.getConnetion();
			conn.setAutoCommit(false);
			
			if(customerDao.insertCustomer(conn, paramCustomer) != 1) {
				throw new Exception();
			}
			
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			result = false;
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
}
