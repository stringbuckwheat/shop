package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import service.DBUtil;
import vo.Customer;
import vo.Employee;

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
}
