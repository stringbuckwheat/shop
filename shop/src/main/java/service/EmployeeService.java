package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import repository.EmployeeDao;
import repository.OutIdDao;
import repository.SignDao;
import vo.Employee;

public class EmployeeService {
	private DBUtil dbUtil;
	private EmployeeDao employeeDao;
	
	public EmployeeService() {
		super();
		this.dbUtil = new DBUtil();
		this.employeeDao = new EmployeeDao();
	}

	public boolean addEmployee(Employee paramEmployee) {
		boolean result = true; // 메소드 실행 결과값을 담을 변수
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnetion();
			conn.setAutoCommit(false);
			
			if(employeeDao.insertEmployee(conn, paramEmployee) != 1) {
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
	
	public Employee getEmployeeByIdAndPw(Employee paramEmployee) throws Exception{
		Connection conn = null;
		Employee employee = null;
		
		try {
			conn = new DBUtil().getConnetion();
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
	
	
	public List<Employee> getEmployeeList(int rowPerPage, int currentPage){
		List<Employee> employeeList = null;
		Connection conn = null;
		
		// beginRow 구하기 
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// EmployeeDao.selectEmployeeList(int rowPerPage, int beginRow)
		try {
			conn = dbUtil.getConnetion();
			employeeDao.selectEmployeeList(conn, rowPerPage, beginRow);

			/*
			 * if (signDao.checkId(conn, id) == null) {
				result = true;
			}
			*/

			conn.commit(); // select인데도..?

		} catch (Exception e) {
			e.printStackTrace();

			try { 
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}

		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return employeeList;
	}
}
