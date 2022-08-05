package service;

import java.sql.*;

import repository.CustomerDao;
import repository.SignDao;
import vo.Customer;
import vo.Employee;

public class SignService {
	private SignDao signDao;

	// return: true면 사용 가능한 아이디, false면 사용불가
	public boolean checkId(String id) {
		boolean result = false; // 메소드 실행 결과값을 담을 변수
		this.signDao = new SignDao();
		Connection conn = null;

		try {
			conn = new DBUtil().getConnetion();
			conn.setAutoCommit(false); // 자동 커밋 막기
			
			System.out.println(id + " 입력 -> " + signDao.checkId(conn, id));

			if (signDao.checkId(conn, id) == null) {
				result = true;
			}

			conn.commit(); // select인데도..?

		} catch (Exception e) {
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
	
	public boolean addCustomer(Customer paramCustomer) {
		boolean result = true; // 메소드 실행 결과값을 담을 변수
		this.signDao = new SignDao();
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnetion();
			conn.setAutoCommit(false);
			
			if(signDao.insertCustomer(conn, paramCustomer) != 1) {
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
	
	public boolean addEmployee(Employee paramEmployee) {
		boolean result = true; // 메소드 실행 결과값을 담을 변수
		this.signDao = new SignDao();
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnetion();
			conn.setAutoCommit(false);
			
			if(signDao.insertEmployee(conn, paramEmployee) != 1) {
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
