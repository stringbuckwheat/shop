package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	private DBUtil dbUtil;
	private EmployeeDao employeeDao;

	public boolean addEmployee(Employee paramEmployee) {
		System.out.println("--------------- EmployeeService.addEmployee()");
		boolean result = true; // 메소드 실행 결과값을 담을 변수
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			this.employeeDao = new EmployeeDao();
			
			if(employeeDao.insertEmployee(conn, paramEmployee) != 1) {
				// 오류는 나지 않았지만 정상적 삽입도 아닌 경우 의도적으로 오류를 발생시킴
				throw new Exception(); 
			}
			
			conn.commit();
			System.out.println("addEmployee() 성공");
			
		} catch(Exception e) {
			result = false;
			
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
		
		return result;
	}
	
	// 로그인 메소드
	public Employee getEmployeeByIdAndPw(Employee paramEmployee) throws Exception{
		System.out.println("--------------- EmployeeService.getEmployeeByIdAndPw()");

		Connection conn = null;
		Employee employee = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.employeeDao = new EmployeeDao();
			// where id and pw
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
	
	// 직원 삭제/탈퇴
	public boolean removeEmployee(Employee paramEmployee) {
		System.out.println("--------------- EmployeeService.removeEmployee()");

		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // db 자동 커밋 해제 
			
			this.employeeDao = new EmployeeDao();

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
	
	// adminindex -> employeeList 구하기
	public List<Employee> getEmployeeList(int rowPerPage, int currentPage){
		System.out.println("--------------- EmployeeService.getEmployeeList()");

		List<Employee> employeeList = null;
		Connection conn = null;
		
		// beginRow 구하기 
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// EmployeeDao.selectEmployeeList(conn, int rowPerPage, int beginRow)
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.employeeDao = new EmployeeDao();
			employeeList = employeeDao.selectEmployeeList(conn, rowPerPage, beginRow);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return employeeList;
	}
	
	// 직원 권한 수정 메소드
	public void modifyEmployeeActive(Employee paramEmployee) {
		System.out.println("--------------- EmployeeService.modifyEmployeeActive()");

		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋 막기

			this.employeeDao = new EmployeeDao();
			if(employeeDao.updateEmployeeActive(conn, paramEmployee) == 1) {
				System.out.println("employeeDao.updateEmployeeActive 메소드 성공!");
			}
			
			conn.commit();
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
	}
	
	// 페이징 용도
	public int getLastPage(int rowPerPage) {
		Connection conn = null;
		int lastPage = 0;
		
		try {
			
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.employeeDao = new EmployeeDao();
			int cnt = employeeDao.countAllEmployee(conn);
			lastPage = (int) Math.ceil (cnt / (double)rowPerPage);
			
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return lastPage;
	}
	
}
