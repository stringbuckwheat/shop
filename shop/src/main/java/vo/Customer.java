package vo;

public class Customer {
	private String customerId;
	private String customerPass;
	private String customerName;
	private String customerAddress;
	private String customerDetailAddress;
	private String customerTelephone;
	private String customerUpdateDate;
	private String customerCreateDate;
	
	public String getCustomerId() {
		return customerId;
	}
	
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	
	public String getCustomerPass() {
		return customerPass;
	}
	
	public void setCustomerPass(String customerPass) {
		this.customerPass = customerPass;
	}
	
	public String getCustomerName() {
		return customerName;
	}
	
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	
	public String getCustomerAddress() {
		return customerAddress;
	}
	
	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}
	
	public String getCustomerTelephone() {
		return customerTelephone;
	}
	
	public void setCustomerTelephone(String customerTelephone) {
		this.customerTelephone = customerTelephone;
	}
	
	public String getCustomerUpdateDate() {
		return customerUpdateDate;
	}
	
	public void setCustomerUpdateDate(String customerUpdateDate) {
		this.customerUpdateDate = customerUpdateDate;
	}
	
	public String getCustomerCreateDate() {
		return customerCreateDate;
	}
	
	public void setCustomerCreateDate(String customerCreateDate) {
		this.customerCreateDate = customerCreateDate;
	}

	public String getCustomerDetailAddress() {
		return customerDetailAddress;
	}

	public void setCustomerDetailAddress(String customerDetailAddress) {
		this.customerDetailAddress = customerDetailAddress;
	}

	@Override
	public String toString() {
		return "Customer [customerId=" + customerId + ", customerPass=" + customerPass + ", customerName="
				+ customerName + ", customerAddress=" + customerAddress + ", customerDetailAddress="
				+ customerDetailAddress + ", customerTelephone=" + customerTelephone + ", customerUpdateDate="
				+ customerUpdateDate + ", customerCreateDate=" + customerCreateDate + "]";
	}
	
}
