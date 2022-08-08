package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import service.DBUtil;
import vo.Board;
import vo.Customer;
import vo.Employee;

//TODO: try-finally
public class EmployeeDao {
	public Employee selectEmployeeByIdAndPw(Connection conn, Employee employee) throws Exception{
		Employee loginEmployee = null;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
				
		String sql = "select employee_id employeeId, employee_name employeeName from employee where employee_id = ? and employee_pass = password(?) and active = 'Y'";
		stmt = conn.prepareStatement(sql);

		stmt.setString(1, employee.getEmployeeId());
		stmt.setString(2, employee.getEmployeePass());

		rs = stmt.executeQuery();
		
		if(!rs.next()) 
			return loginEmployee;
		
		// return할 객체 세팅
		loginEmployee = new Employee();
		loginEmployee.setEmployeeId(rs.getString("employeeId"));
		loginEmployee.setEmployeeName(rs.getString("employeeName"));		
		
		// 여기까지 왔으면 null 체크 필요 X
		rs.close();
		stmt.close();
		
		return loginEmployee;
	}
	
	public int deleteEmployee(Connection conn, Employee paramEmployee) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;

		String sql = "delete from employee where employee_id = ? and employee_pass = password(?)";
		stmt = conn.prepareStatement(sql);
	
		stmt.setString(1, paramEmployee.getEmployeeId());
		stmt.setString(2, paramEmployee.getEmployeePass());
	
		row = stmt.executeUpdate();
	
		stmt.close();
		
		return row;
	}
	
	public List<Employee> selectEmployeeList(Connection conn, int rowPerPage, int beginRow) throws Exception{
		ArrayList<Employee> employeeList = new ArrayList<>();
		ResultSet rs =  null;
		PreparedStatement stmt = null;
		
		try {
			String sql = "select employee_id employeeId, employee_pass employeePw, employee_name employeeName, update_date updateDate, create_date createDate, active from employee order by create_date desc limit ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Employee e = new Employee();
				e.setEmployeeId(rs.getString("employeeId"));
				e.setEmployeePass(rs.getString("employeePw"));
				e.setEmployeeName(rs.getString("employeeName"));
				e.setUpdateDate(rs.getString("updateDate"));
				e.setCreateDate(rs.getString("createDate"));
				e.setEmployeeActive(rs.getString("active"));
				
				employeeList.add(e);
			}
		
		} finally {
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
		}
		return employeeList;
	}
	
	public int countAllEmployee(Connection conn) throws Exception {
		int lastPage = 0;
		String sql = "SELECT COUNT(*) cnt FROM employee";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			if(rs.next()) {
				lastPage = rs.getInt("cnt");
			}
			
		} finally {
			
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
		}
				
		return lastPage;
	}
	
	public int insertEmployee(Connection conn, Employee paramEmployee) throws Exception{
		int row = 0;
		
		String sql = "insert into employee(employee_id, employee_pass, employee_name, update_date, create_date)"
				+ "values(?, password(?), ?, now(), now())";
		// active 기본값 'n'라서 아직 삭제 불가
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramEmployee.getEmployeeId());
		stmt.setString(2, paramEmployee.getEmployeePass());
		stmt.setString(3, paramEmployee.getEmployeeName());
		
		row = stmt.executeUpdate();
		
		if(stmt != null) {
			stmt.close();
		}
		
		return row;
	}
	
	public int updateEmployeeActive(Connection conn, Employee paramEmployee) throws Exception {
		int row = -1;
		String sql = "update employee set update_date = now(), active = ? WHERE employee_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramEmployee.getEmployeeActive());
		stmt.setString(2, paramEmployee.getEmployeeId());
		
		row = stmt.executeUpdate();

		if(stmt != null) {
			stmt.close();
		}
		
		return row;
	}
}
