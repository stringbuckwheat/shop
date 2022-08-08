package repository;

import java.sql.*;
import java.util.*;

import vo.Goods;

public class GoodsDao {
	
	public int insertGoods(Connection conn, Goods goods) throws Exception {
		// row가 아니라 방금 입력한 goods_no(value)를 return -> jdbc 메소드 이용
		int goodsNo = 0;
		String sql = "insert into goods(goods_name, goods_price, sold_out, update_date, create_date)"
				+ " values (?, ?, ?, now(), now())";
		
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		// RETURN_GENERATED_KEYS == 1 --> 두 번의 쿼리 실행
		// 1) insert 
		// 2) select last_ai_key from table
		
		stmt.setString(1, goods.getGoodsName());
		stmt.setInt(2, goods.getGoodsPrice());
		stmt.setString(3, goods.getSoldOut());
		
		stmt.executeUpdate(); // insert 
		ResultSet rs = stmt.getGeneratedKeys(); // return 값 
		
		if(rs.next()) {
			goodsNo = rs.getInt(1);
			System.out.println("GoodsDao.insertGoods: "+ goodsNo);
			// getGeneratedKeys가 반환하는 컬럼명을 알 순 없지만
			// 첫번째라는 것은 알 수 있으므로 rs.getInt(1)
		}
		
		if(rs != null) {
			rs.close();
		}
		
		if(stmt != null) {
			stmt.close();
		}
		
		return goodsNo;
	}
	
	
	public List<Goods> selectGoodsListByPage(Connection conn, int rowPerPage, int beginRow) throws Exception{
		ArrayList<Goods> goodsList = new ArrayList<>();
		String sql = "select goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, update_date updateDate, create_date createDate, sold_out soldOut" 
					+ " from goods limit ?, ?";
		ResultSet rs =  null;
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Goods g = new Goods();
				
				g.setGoodsNo(rs.getInt("goodsNo"));
				g.setGoodsName(rs.getString("goodsName"));
				g.setGoodsPrice(rs.getInt("goodsPrice"));
				g.setUpdateDate(rs.getString("updateDate"));
				g.setCreateDate(rs.getString("createDate"));
				g.setSoldOut(rs.getString("soldOut"));
				
				System.out.println("goodsDao.selectGoodsListByPage: " + g);
				goodsList.add(g);
			}
		} finally {
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return goodsList;
	}
	
	public int countAllGoods(Connection conn) throws Exception {
		int lastPage = 0;
		String sql = "select count(*) cnt FROM goods";
		
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

	
	
	// 상품 입력과 상품 이미지 입력이 동시에 이루어져야 함 - 트랜잭션 필요
	// join을 할 때는 부모테이블(왼쪽 테이블) DAO에 두기
	// 모든 상품 혹은 검색 리스트를 반환하려면 - List<Map<String, Object>> list
	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws Exception{
		// 자바 타입 중 가장 익명객체와 비슷한 타입 => map
		Map<String, Object> goodsAndImgOne = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "select g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.create_date createDate, "
				+ "g.update_date goodsUpdateDate, g.sold_out soldOut, gi.filename filename, gi.origin_filename originFilename, gi.content_type contentType " 
				+ "from goods g inner join goods_img gi on g.goods_no = gi.goods_no where g.goods_no = ?";

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				goodsAndImgOne = new HashMap<>();
				
				goodsAndImgOne.put("goodsNo", rs.getInt("goodsNo"));
				goodsAndImgOne.put("goodsName", rs.getString("goodsName"));
				goodsAndImgOne.put("goodsPrice", rs.getInt("goodsPrice"));
				goodsAndImgOne.put("createDate", rs.getString("createDate"));
				goodsAndImgOne.put("goodsUpdateDate", rs.getString("goodsUpdateDate"));
				goodsAndImgOne.put("soldOut", rs.getString("soldOut"));
				goodsAndImgOne.put("filename", rs.getString("filename"));
				goodsAndImgOne.put("originFilename", rs.getString("originFilename"));
				
			}

		} finally {
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return goodsAndImgOne;
	}
}
