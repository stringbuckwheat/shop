package repository;

import java.sql.*;
import java.util.*;

import vo.Review;

public class ReviewDao {
	// C: Review 작성
	public int insertReview(Connection conn, Review review) throws SQLException {
		System.out.println("-------------- ReviewDao.insertReview()");
		int row = 0;
		
		PreparedStatement stmt = null;
		// orderNo, reviewContent, updateDate, createDate, rating
		String sql = "INSERT INTO review(orderNo, reviewContent, rating, updateDate, createDate)"
				+ " VALUES(?, ?, ?, now(), now())";
		
		try {
			
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt);
			
			stmt.setInt(1, review.getOrderNo());
			stmt.setString(2, review.getReviewContent());
			stmt.setInt(3, review.getRating());
			
			row = stmt.executeUpdate();
			
		} finally {

			if(stmt != null) {
				stmt.close();
			}
			
		}
		
		return row;
	}
	
	// R: orderNo(PK)에 해당하는 리뷰가 있는지 없는지 확인하는 메소드
	// 같은 주문에 대한 중복 리뷰를 방지하기 위해
	public int selectReviewOne(Connection conn, int orderNo) throws SQLException {
		int cnt = -1;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 없으면 0, 있으면 1을 반환하는 쿼리
		String sql = "select EXISTS (select order_no from review where order_no = ? limit 1) as cnt";
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			rs = stmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
			
		} finally {

			if (rs != null) {
				rs.close();
			}

			if (stmt != null) {
				stmt.close();
			}
		}
		
		return cnt;
	
	}
	
	// R: 개별 유저의 리뷰리스트
	public List<Map<String, Object>> selectReviewListByUser(Connection conn, String id) throws SQLException{
		List<Map<String, Object>> list = new ArrayList<>();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		
		String sql = ""; //TODO orders, goods, goods_img 테이블과 조인해서 상품정보도 함께 출력 
		

		try {
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			
			System.out.println(stmt);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				
				//TODO m.put()
				
				list.add(m);
			}
		
		} finally {
			
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		
		}
				
		return list;
	}
	
	// R: 전체 리뷰리스트(for admin)
	public List<Map<String, Object>> selectAllReviewList(Connection conn) throws SQLException{
		List<Map<String, Object>> list = new ArrayList<>();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		
		String sql = ""; //TODO orders, goods, goods_img 테이블과 조인해서 상품정보도 함께 출력 
		

		try {
			
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				
				//TODO m.put()
				
				list.add(m);
			}
		
		} finally {
			
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		
		}
				
		return list;
	}
	
	// R: 제품id별 리뷰리스트
	public List<Map<String, Object>> selectReviewListByGoodsNo(Connection conn, int goodsNo) throws SQLException{
		List<Map<String, Object>> list = new ArrayList<>();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		
		String sql = ""; //TODO orders, goods, goods_img 테이블과 조인해서 상품정보도 함께 출력 
		

		try {
			
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				
				//TODO m.put()
				
				list.add(m);
			}
		
		} finally {
			
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		
		}
				
		return list;
	}
	
	// U: 리뷰 수정
	public int updateReview(Connection conn, Review review) throws SQLException {
		System.out.println("-------------- ReviewDao.updateReview()");
		
		int row = 0;
		PreparedStatement stmt = null;
		// orderNo, reviewContent, updateDate, createDate, rating
		String sql = "UPDATE review SET review_content = ?, rating = ?, update_date = NOW()"
				+ " WHERE order_no = ?";
		
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt);
			
			stmt.setString(1, review.getReviewContent());
			stmt.setInt(2, review.getRating());
			stmt.setInt(3, review.getOrderNo());
			
			row = stmt.executeUpdate();
			
		} finally {
			
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return row;
	}
	
	// D: 리뷰 삭제
	public int deleteReview(Connection conn, int orderNo) throws SQLException {
		int row = 0;
		
		PreparedStatement stmt = null;
		String sql = "DELETE FROM review WHERE order_no = ?";
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
}
