package vo;

public class Employee {
	private String employeeId;
	private String employeePass;
	private String employeeName;
	private String updateDate;
	private String createDate;
	private String employeeActive;
	
	public String getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}
	public String getEmployeePass() {
		return employeePass;
	}
	public void setEmployeePass(String employeePass) {
		this.employeePass = employeePass;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getEmployeeActive() {
		return employeeActive;
	}
	public void setEmployeeActive(String employeeActive) {
		this.employeeActive = employeeActive;
	}
	
	@Override
	public String toString() {
		return "Employee [employeeId=" + employeeId + ", employeePass=" + employeePass + ", employeeName="
				+ employeeName + ", updateDate=" + updateDate + ", createDate=" + createDate + ", employeeActive="
				+ employeeActive + "]";
	}
	
	
}
