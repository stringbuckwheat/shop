package vo;

public class GoodsImg {
	private int goodsNo;
	private String fileName;
	private String originFilename;
	private String contentType;
	private String create_date;
	
	public int getGoodsNo() {
		return goodsNo;
	}
	
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	
	public String getFileName() {
		return fileName;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getOriginFilename() {
		return originFilename;
	}
	
	public void setOriginFilename(String originFilename) {
		this.originFilename = originFilename;
	}
	
	public String getContentType() {
		return contentType;
	}
	
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	
	public String getCreate_date() {
		return create_date;
	}
	
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	
	@Override
	public String toString() {
		return "GoodsImg [goodsNo=" + goodsNo + ", fileName=" + fileName + ", originFilename=" + originFilename
				+ ", contentType=" + contentType + ", create_date=" + create_date + "]";
	}
	
	
}
