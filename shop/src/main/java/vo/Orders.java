package vo;

public class Orders {
	private int orderNo;
	private int goodsNo;
	private String customerId;
	private int orderQuantity;
	private int orderPrice;
	private String orderAddress;
	private String orderDetailAddress;
	private String orderState;
	private String updateDate;
	private String createDate;
	
	
	public int getOrderNo() {
		return orderNo;
	}
	
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	
	public int getGoodsNo() {
		return goodsNo;
	}
	
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	
	public String getCustomerId() {
		return customerId;
	}
	
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	
	public int getOrderQuantity() {
		return orderQuantity;
	}
	
	public void setOrderQuantity(int orderQuantity) {
		this.orderQuantity = orderQuantity;
	}
	
	public String getOrderState() {
		return orderState;
	}
	
	public void setOrderState(String orderState) {
		this.orderState = orderState;
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
	
	public int getOrderPrice() {
		return orderPrice;
	}
	
	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}
	
	public String getOrderAddress() {
		return orderAddress;
	}
	
	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
	}

	
	public String getOrderDetailAddress() {
		return orderDetailAddress;
	}

	public void setOrderDetailAddress(String orderDetailAddress) {
		this.orderDetailAddress = orderDetailAddress;
	}

	@Override
	public String toString() {
		return "Orders [orderNo=" + orderNo + ", goodsNo=" + goodsNo + ", customerId=" + customerId + ", orderQuantity="
				+ orderQuantity + ", orderPrice=" + orderPrice + ", orderAddress=" + orderAddress
				+ ", orderDetailAddress=" + orderDetailAddress + ", orderState=" + orderState + ", updateDate="
				+ updateDate + ", createDate=" + createDate + "]";
	}
	
}
