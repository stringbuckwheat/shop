package repository;

import java.sql.*;

import vo.GoodsImg;

public class GoodsImgDao {
	public int insertGoodsImg(Connection conn, GoodsImg goodsImg) throws SQLException {
		int row = 0;
		
		String sql = "insert into goods_img(goods_no, filename, origin_filename, content_type, create_date) "  
					+ " values (?, ?, ?, ?, now())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsImg.getGoodsNo());
		stmt.setString(2, goodsImg.getFileName());
		stmt.setString(3, goodsImg.getOriginFilename());
		stmt.setString(4, goodsImg.getContentType());
		
		row = stmt.executeUpdate();
		
		if(stmt != null) {
			stmt.close();
		}
		
		return row;
	}
}
