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
			int deleteRow = employeeDao.deleteEmployee(conn, paramEmployee);
			System.out.println("employee deleteRow: " + deleteRow);
			
			OutIdDao outIdDao = new OutIdDao();
			int insertRow = outIdDao.insertOutId(conn, paramEmployee.getEmployeeId());
			System.out.println("employee insertRow: " + insertRow);

			conn.commit(); // exception 발생 시 여기까지 내려오지 않음
		
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
