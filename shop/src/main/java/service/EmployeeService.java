package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	// loginAction.jsp 호출
	
	public Employee getEmployeeByIdAndPw(Employee paramEmployee) throws Exception{
		Connection conn = null;
		Employee employee = null;
		
		try {
			conn = new DBUtil().getConnetion();

			EmployeeDao employeeDao = new EmployeeDao();
			employee = employeeDao.selectEmployeeByIdAndPw(conn, paramEmployee);
			
			// 디버깅
			if(employee != null ) {
				System.out.println("직원 로그인 메소드 성공");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return employee;
	}
	
	
	public boolean removeEmployee(Employee paramEmployee) {
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnetion();
			conn.setAutoCommit(false); // db 자동 커밋 해제 
			
			EmployeeDao employeeDao = new EmployeeDao();	
			
			if(employeeDao.deleteEmployee(conn, paramEmployee) == 1) {
				throw new Exception();
			}
			
			OutIdDao outIdDao = new OutIdDao();
			
			if(outIdDao.insertOutId(conn, paramEmployee.getEmployeeId()) != 1) {
				throw new Exception();
			}
			conn.commit();
		
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
	} // end for removeEmployee
}
