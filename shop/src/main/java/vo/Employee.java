package vo;

public class Employee {
	private String employeeId;
	private String employeePass;
	private String employeeName;
	private String employeeAddress;
	private String employeeDetailAddress;
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
	
	public String getEmployeeAddress() {
		return employeeAddress;
	}

	public void setEmployeeAddress(String employeeAddress) {
		this.employeeAddress = employeeAddress;
	}

	public String getEmployeeDetailAddress() {
		return employeeDetailAddress;
	}

	public void setEmployeeDetailAddress(String employeeDetailAddress) {
		this.employeeDetailAddress = employeeDetailAddress;
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
				+ employeeName + ", employeeAddress=" + employeeAddress + ", employeeDetailAddress="
				+ employeeDetailAddress + ", updateDate=" + updateDate + ", createDate=" + createDate
				+ ", employeeActive=" + employeeActive + "]";
	}
	
}
