package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import vo.Goods;

public class GoodsDao {
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
}
