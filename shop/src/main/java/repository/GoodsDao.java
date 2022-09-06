package repository;

import java.sql.*;
import java.util.*;

import vo.Goods;

public class GoodsDao {
	/*
	 * int insertGoods(Connection conn, Goods goods) - 상품 추가
	 * List<Goods> selectGoodsListByPage(Connection conn, int rowPerPage, int beginRow) - 상품 리스트
	 * int countAllGoods(Connection conn)
	 * Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) - 상세 페이지
	 * List<Map<String, Object>> selectCustomerGoodsListByPage(Connection conn, int rowPerPage, int beginRow, String sortBy, int categoryId) - 
	 */

	// 상품 추가 메소드 --  Statement.RETURN_GENERATED_KEYS
	public int insertGoods(Connection conn, Goods goods) throws Exception {
		System.out.println("------------------------------ GoodsDao.insertGoods()");

		// row가 아니라 방금 입력한 goods_no(value)를 return -> jdbc 메소드 이용
		int goodsNo = 0;
		String sql = "insert into goods(goods_name, goods_price, sold_out, update_date, create_date)"
				+ " values (?, ?, ?, now(), now())";

		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			// RETURN_GENERATED_KEYS == 1 --> 두 번의 쿼리 실행
			// 1) insert
			// 2) select last_ai_key from table

			stmt.setString(1, goods.getGoodsName());
			stmt.setInt(2, goods.getGoodsPrice());
			stmt.setString(3, goods.getSoldOut());

			stmt.executeUpdate(); // insert
			rs = stmt.getGeneratedKeys(); // return 값

			if (rs.next()) {
				goodsNo = rs.getInt(1);
				System.out.println("GoodsDao.insertGoods: " + goodsNo);
				// getGeneratedKeys가 반환하는 컬럼명을 알 순 없지만
				// 첫번째라는 것은 알 수 있으므로 rs.getInt(1)
			}
		} finally {
			if (rs != null) { rs.close(); }
			if (stmt != null) { stmt.close(); }
		}
		
		return goodsNo;
	}

	// 상품 페이지 리스트
	public List<Goods> selectGoodsListByPage(Connection conn, int rowPerPage, int beginRow) throws Exception {
		System.out.println("------------------------------ GoodsDao.selectGoodsListByPage()");
		ArrayList<Goods> goodsList = new ArrayList<>();
		String sql = "select goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, update_date updateDate, create_date createDate, sold_out soldOut"
				+ " from goods limit ?, ?";
		ResultSet rs = null;
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();

			while (rs.next()) {
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
			if (rs != null) {
				rs.close();
			}

			if (stmt != null) {
				stmt.close();
			}
		}

		return goodsList;
	}

	// 페이징
	public int countAllGoods(Connection conn, int categoryId) throws Exception {
		System.out.println("------------------------------ GoodsDao.countAllGoods()");
		int lastPage = 0;
		String sql = "select count(*) cnt FROM goods";
		
		if(categoryId != 0) {
			sql += " where category_id = " + categoryId;
		}

		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				lastPage = rs.getInt("cnt");
			}

		} finally {

			if (rs != null) {
				rs.close();
			}

			if (stmt != null) {
				stmt.close();
			}
		}

		System.out.println("lastPage: " + lastPage);
		return lastPage;
	}

	// 상품 입력과 상품 이미지 입력이 동시에 이루어져야 함 - 트랜잭션 필요
	// join을 할 때는 부모테이블(왼쪽 테이블) DAO에 두기
	// 모든 상품 혹은 검색 리스트를 반환하려면 - List<Map<String, Object>> list
	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws Exception {
		System.out.println("------------------------------ GoodsDao.selectGoodsAndImgOne()");

		// 자바 타입 중 가장 익명객체와 비슷한 타입 => map
		Map<String, Object> goodsAndImgOne = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "select g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.origin_filename originFilename "
				+ " from goods g inner join goods_img gi on g.goods_no = gi.goods_no where g.goods_no = ?";

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			rs = stmt.executeQuery();

			if (rs.next()) {
				goodsAndImgOne = new HashMap<>();

				goodsAndImgOne.put("goodsNo", rs.getInt("goodsNo"));
				goodsAndImgOne.put("goodsName", rs.getString("goodsName"));
				goodsAndImgOne.put("goodsPrice", rs.getInt("goodsPrice"));
				goodsAndImgOne.put("soldOut", rs.getString("soldOut"));
				goodsAndImgOne.put("originFilename", rs.getString("originFilename"));

			}

		} finally {
			if (rs != null) {
				rs.close();
			}

			if (stmt != null) {
				stmt.close();
			}
		}

		System.out.println("goodsAndImgOne: " + goodsAndImgOne);
		return goodsAndImgOne;
	}

	// 고객 상품리스트 페이지 정렬
	public List<Map<String, Object>> selectCustomerGoodsListByPage(Connection conn, int rowPerPage, int beginRow, String sortBy, int categoryId) throws SQLException {
		System.out.println("------------------------------ GoodsDao.selectCustomerGoodsListByPage()");

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename, g.hit "
				+ " FROM goods g" 
				+ " INNER JOIN goods_img gi"
				+ " ON g.goods_no = gi.goods_no";
		
		if(categoryId != 0) {
			sql += " where g.category_id = " + categoryId;
		}
		
		// 정렬 쿼리 분기
		if (sortBy == null || sortBy.equals("new")) { // || 특성상 NPE 안 남
			sql += " ORDER BY g.create_date desc ";
			System.out.println("최신순 정렬(기본값)");
		} else if (sortBy.equals("popular")) {
			sql += " ORDER BY g.hit desc";
			System.out.println("인기순 정렬");
		} else if (sortBy.equals("sales")) {
			// += 아니고 대입
			sql = "select g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename, ifnull(sum(o.order_quantity), 0) sum"
					+ " from goods g" 
					+ " left join orders o" 
					+ " on g.goods_no = o.goods_no" 
					+ " INNER JOIN goods_img gi "
					+ " ON g.goods_no = gi.goods_no ";
			
			if(categoryId != 0) {
				sql += " where g.category_id = " + categoryId;
			}

			sql += " group by g.goods_no order by sum desc";
			System.out.println("판매순 정렬");
			
		} else if (sortBy.equals("highPrice")) {
			sql += " ORDER BY g.goods_price desc";
			System.out.println("높은 가격순 정렬");
		} else if (sortBy.equals("lowPrice")) {
			sql += " ORDER BY g.goods_price";
			System.out.println("낮은 가격순 정렬");
		}

		sql += " limit ?, ?";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);

			System.out.println("stmt " + stmt); // 디버깅

			rs = stmt.executeQuery();

			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCnt = rsmd.getColumnCount(); // 컬럼의 수

			while (rs.next()) {
				Map<String, Object> m = new HashMap<>();

				for (int i = 1; i <= columnCnt; i++) {
					String tmp = rsmd.getColumnLabel(i);

					// getInt, getString 분기 -- 타입 검사 메소드
					if (tmp.equals("goodsNo") || tmp.equals("goodsPrice") || tmp.equals("orderNo")
							|| tmp.equals("orderQuantity") || tmp.equals("orderPrice") || tmp.equals("sum") || tmp.equals("hit")) {
						m.put(tmp, rs.getInt(rsmd.getColumnLabel(i)));
						continue;
					}

					m.put(tmp, rs.getString(rsmd.getColumnLabel(i)));
				}

				list.add(m);
			}

		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}

		System.out.println("list: " + list.size());
		// System.out.println(list);
		return list;
	}
	
	public List<Map<String, Object>> selectGoodsListBySearch(Connection conn, String search) throws Exception{
		System.out.println("------------------------------ GoodsDao.selectGoodsListBySearch()");
		System.out.println(search);

		List<Map<String, Object>> list = new ArrayList<>();
		String sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename, g.hit"
				+ " FROM goods g"
				+ " INNER JOIN goods_img gi"
				+ " ON g.goods_no = gi.goods_no"
				+ " where g.goods_name like concat('%', ?, '%')";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, search);
			
			System.out.println(stmt);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				
				 m.put("goodsNo", rs.getInt("goodsNo"));
				 m.put("goodsName", rs.getString("goodsName"));
				 m.put("goodsPrice", rs.getInt("goodsPrice"));
				 m.put("soldOut", rs.getString("soldOut"));
				 m.put("filename", rs.getString("filename"));
				 m.put("hit", rs.getInt("hit"));
				 
				 list.add(m);
			}
			    
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		System.out.println(list.size());
		System.out.println(list);
		
		return list;
	}

}
