package vo;

public class Counter {
	private String counterDate;
	private String counterNum;
	
	public String getCounterDate() {
		return counterDate;
	}
	
	public void setCounterDate(String counterDate) {
		this.counterDate = counterDate;
	}
	
	public String getCounterNum() {
		return counterNum;
	}
	
	public void setCounterNum(String counterNum) {
		this.counterNum = counterNum;
	}

	@Override
	public String toString() {
		return "Counter [counterDate=" + counterDate + ", counterNum=" + counterNum + "]";
	}
	
}
