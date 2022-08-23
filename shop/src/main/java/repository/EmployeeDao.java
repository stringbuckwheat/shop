package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import vo.Employee;

public class EmployeeDao {
	public Employee selectEmployeeByIdAndPw(Connection conn, Employee employee) throws Exception {
		System.out.println("----------------------- EmployeeDao.selectEmployeeByIdAndPw()");
		Employee loginEmployee = null; // return용 변수

		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select employee_id employeeId, employee_name employeeName from employee where employee_id = ? and employee_pass = password(?) and active = 'Y'";

		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());

			rs = stmt.executeQuery();

			if (rs.next()) {
				// return할 객체 세팅
				loginEmployee = new Employee();
				loginEmployee.setEmployeeId(rs.getString("employeeId"));
				loginEmployee.setEmployeeName(rs.getString("employeeName"));
			}

		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}

		System.out.println("selectEmployeeByIdAndPw() 성공");
		return loginEmployee;
	}

	public int deleteEmployee(Connection conn, Employee paramEmployee) throws Exception {
		System.out.println("----------------------- EmployeeDao.deleteEmployee()");

		int row = 0;
		PreparedStatement stmt = null;
		String sql = "delete from employee where employee_id = ? and employee_pass = password(?)";

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());

			System.out.println(stmt);

			row = stmt.executeUpdate(); // 1이면 성공

			if (row == 1) {
				System.out.println("deleteEmployee() 성공");
			}

		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}

		return row;
	}

	public List<Employee> selectEmployeeList(Connection conn, int rowPerPage, int beginRow) throws Exception {
		System.out.println("----------------------- EmployeeDao.selectEmployeeList()");

		ArrayList<Employee> employeeList = new ArrayList<>(); // return용 변수
		ResultSet rs = null;
		PreparedStatement stmt = null;
		String sql = "select employee_id employeeId, employee_pass employeePw, employee_name employeeName, update_date updateDate"
				+ ", create_date createDate, active from employee order by create_date desc limit ?, ?";

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();

			while (rs.next()) {
				Employee e = new Employee();

				e.setEmployeeId(rs.getString("employeeId"));
				e.setEmployeePass(rs.getString("employeePw"));
				e.setEmployeeName(rs.getString("employeeName"));
				e.setUpdateDate(rs.getString("updateDate"));
				e.setCreateDate(rs.getString("createDate"));
				e.setEmployeeActive(rs.getString("active"));

				employeeList.add(e);
			}

			System.out.println("0 이상이면 성공: " + employeeList.size());

		} finally {
			if (rs != null) {
				rs.close();
			}

			if (stmt != null) {
				stmt.close();
			}
		}
		return employeeList;
	}

	// 전체 행의 수 반환 -> 페이징 용도
	public int countAllEmployee(Connection conn) throws Exception {
		System.out.println("----------------------- EmployeeDao.countAllEmployee()");

		int lastPage = 0;
		String sql = "SELECT COUNT(*) cnt FROM employee";

		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				lastPage = rs.getInt("cnt");
			}

		} finally {

			if (rs != null) {
				rs.close();
			}

			if (stmt != null) {
				stmt.close();
			}
		}

		return lastPage;
	}

	public int insertEmployee(Connection conn, Employee paramEmployee) throws Exception {
		System.out.println("----------------------- EmployeeDao.insertEmployee()");

		int row = 0;
		PreparedStatement stmt = null;
		String sql = "insert into employee(employee_id, employee_pass, employee_name, employee_address, employee_detail_address"
				+ ", update_date, create_date)" + "values(?, password(?), ?, ?, ?, now(), now())";

		try {

			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			stmt.setString(3, paramEmployee.getEmployeeName());
			stmt.setString(4, paramEmployee.getEmployeeAddress());
			stmt.setString(5, paramEmployee.getEmployeeDetailAddress());

			row = stmt.executeUpdate();
			
			if(row == 1) {
				System.out.println("insertEmployee 성공");
			}
			

		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	public int updateEmployeeActive(Connection conn, Employee paramEmployee) throws Exception {
		System.out.println("----------------------- EmployeeDao.updateEmployeeActive()");

		int row = -1;
		String sql = "update employee set update_date = now(), active = ? WHERE employee_id = ?";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeActive());
			stmt.setString(2, paramEmployee.getEmployeeId());

			row = stmt.executeUpdate();
			
			if(row == 1) {
				System.out.println("updateEmployeeActive 성공");
			}
			
		} finally {

			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
}
