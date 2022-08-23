package repository;

import java.sql.*;
import java.util.*;
import vo.Orders;

public class OrdersDao {
	
	// 주문하기 - Orders VO를 받고 방금 입력한 orderNo를 리턴
	public int insertOrder(Connection conn, Orders order) throws SQLException {
		System.out.println("---------------- OrdersDao.insertOrder(Orders order)");

		int orderNo = 0; // 방금 입력한 orderNo를 저장할 변수
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "insert into orders (goods_no, customer_id, order_quantity, order_state, order_price, order_address, order_detail_address, update_date, create_date)"
				+ " values (?, ?, ?, '주문 완료', ?, ?, ?, now(), now())";
		
		try {
			
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setInt(1, order.getGoodsNo());
			stmt.setString(2, order.getCustomerId());
			stmt.setInt(3, order.getOrderQuantity());
			stmt.setInt(4, order.getOrderPrice());
			stmt.setString(5, order.getOrderAddress());
			stmt.setString(6, order.getOrderDetailAddress());
			
			stmt.executeUpdate();
			rs = stmt.getGeneratedKeys(); // return 값
			
			if (rs.next()) {
				orderNo = rs.getInt(1);
				
				System.out.println("NoticeDao.insertNotice - 직전 insert의 orderNo: " + orderNo);
				// getGeneratedKeys가 반환하는 컬럼명을 알 순 없지만
				// 첫번째라는 것은 알 수 있으므로 rs.getInt(1)
			}
			
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return orderNo;
	}
		
		// 장바구니 전체 주문을 위해 Map 타입 파라미터로 오버로딩
		// 성공한 row수를 리턴 
		public int insertOrder(Connection conn, Map<String, Object> map) throws SQLException {
			System.out.println("---------------- OrdersDao.insertOrder(Map<String, Object> map)");

			int row = 0;
			PreparedStatement stmt = null;
			String sql = "insert into orders (goods_no, customer_id, order_quantity, order_state, order_price, order_address, order_detail_address, update_date, create_date)"
					+ " values (?, ?, ?, '주문완료', ?, ?, ?, now(), now())";
			
			try {
				
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, (int)map.get("goodsNo"));
				stmt.setString(2, (String)map.get("customerId"));
				stmt.setInt(3, (int)map.get("cartQuantity"));
				stmt.setInt(4, (int)map.get("orderPrice"));
				stmt.setString(5, (String)map.get("orderAddress"));
				stmt.setString(6, (String)map.get("orderDetailAddress"));
				
				System.out.println(stmt);
				
				row = stmt.executeUpdate();
				
			} finally {
				if(stmt != null) {
					stmt.close();
				}
			}
			
			return row;
		}
	
	// 5-1) 전체 주문 목록(관리자)
	public List<Map<String, Object>> selectOrdersList(Connection conn, int rowPerPage, int beginRow) throws SQLException{
		System.out.println("---------------- OrdersDao.selectOrdersList()");
		
		// null이 아니라 size가 0인 리스트를 리턴
		List<Map<String, Object>> orderList = new ArrayList<>(); // 다형성
		
		// orders + goods + customer 조인
		String sql = "select o.order_no orderNo, c.customer_id customerId, c.customer_name customerName" 
				+ ", g.goods_name goodsName, o.order_quantity orderQuantity, o.order_state orderState"
				+ ", o.order_price orderPrice, o.update_date updateDate, o.create_date createDate"
				+ " from orders o inner join goods g on g.goods_no = o.goods_no"
				+ " inner join customer c on o.customer_id = c.customer_id"
				+ " order by o.create_date desc limit ?, ?";
		
		ResultSet rs =  null;
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCnt = rsmd.getColumnCount(); //컬럼의 수를 받아오는 메서드
			// 우리는 컬럼 수를 아니까 꼭 안 써도 됨
			
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				
				for(int i=1 ; i<=columnCnt; i++){
					String tmp = rsmd.getColumnLabel(i);
					
					// getInt, getString 분기
					if(tmp.equals("orderNo") || tmp.equals("goodsNo") || tmp.equals("orderQuantity") || tmp.equals("orderPrice")) {
						m.put(tmp, rs.getInt(rsmd.getColumnName(i)));
						continue;
					}
					
					m.put(tmp, rs.getString(rsmd.getColumnName(i)));
				}			
				
				orderList.add(m);
			}
			
			// System.out.println(orderList);
			
		} finally {
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return orderList;
	}
	
	// Orders 테이블의 전체 컬럼 수를 리턴 -> 페이징 용도
	public int countAllOrders(Connection conn) throws Exception {
		System.out.println("---------------- OrdersDao.countAllOrders()");

		int lastPage = 0;
		String sql = "select count(*) cnt FROM orders";
		
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
	
	// 2-1) 고객 한 명의 주문 목록 - 관리자, 고객
	public List<Map<String, Object>> selectOrderListByCustomer(Connection conn, String customerId, int rowPerPage, int beginRow) throws SQLException{
		System.out.println("---------------- OrdersDao.selectOrderListByCustomer()");

		List<Map<String, Object>> orderList = new ArrayList<>(); // 다형성

		String sql = "select o.order_no orderNo, g.goods_no goodsNo, c.customer_id customerId,"
				+ " o.order_quantity orderQuantity, o.order_state orderState, o.update_date updateDate,"
				+ " o.create_date createDate, o.order_price orderPrice, o.order_address orderAddress"
				+ " from orders o inner join goods g on g.goods_no = o.goods_no"
				+ " inner join customer c on o.customer_id = c.customer_id"
				+ " where o.customer_id = ?"
				+ " order by o.create_date desc limit ?, ?";
		
		ResultSet rs =  null;
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			
			rs = stmt.executeQuery();
			
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCnt = rsmd.getColumnCount(); //컬럼의 수
			
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				
				for(int i=1 ; i<=columnCnt; i++){
					String tmp = rsmd.getColumnName(i);
					
					// getInt, getString 분기
					if(tmp.equals("orderNo") || tmp.equals("goodsNo") || tmp.equals("orderQuantity") || tmp.equals("orderPrice")) {
						m.put(tmp, rs.getInt(rsmd.getColumnName(i)));
						continue;
					}
					
					m.put(tmp, rs.getString(rsmd.getColumnName(i)));
				}			
				
				orderList.add(m);
			}
			
			// System.out.println(orderList);
			
		} finally {
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return orderList;
	}
	
	// 5-2) 주문 상세보기
	public Map<String, Object> selectOrderOne(Connection conn, int orderNo) throws SQLException{
		System.out.println("---------------- OrdersDao.selectOrderOne()");

		Map<String, Object> map = null;
		
		String sql = "select o.order_no orderNo, g.goods_no goodsNo, o.customer_id customerId, o.order_quantity orderQuantity, o.order_state orderState, o.update_date updateDate, o.create_date createDate, o.order_price orderPrice, o.order_address orderAddress "
				+ ", g.goods_name goodsName, g.goods_price goodsPrice"
				+ ", c.customer_name customerName, c.customer_address customerAddress, c.customer_telephone customerTelephone "
				+ " from orders o inner join goods g on o.goods_no = g.goods_no"
				+ " inner join customer c on o.customer_id = c.customer_id"
				+ " where o.order_no = ?";
		
		ResultSet rs =  null;
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			rs = stmt.executeQuery();
			
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCnt = rsmd.getColumnCount(); //컬럼의 수
			
			if(rs.next()) {
				map = new HashMap<>();
				
				for(int i=1 ; i<=columnCnt; i++){
					String tmp = rsmd.getColumnLabel(i);
					
					// getInt, getString 분기
					if(tmp.equals("orderNo") || tmp.equals("goodsNo") || tmp.equals("orderQuantity") || tmp.equals("orderPrice")) {
						map.put(tmp, rs.getInt(rsmd.getColumnName(i)));
						continue;
					}
					
					map.put(tmp, rs.getString(rsmd.getColumnName(i)));
				}							
			}
			
			// System.out.println(map);
			
		} finally {
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return map;
	}
	
	// 주문 상태 수정
	public int updateOrderState(Connection conn, String orderState, int orderNo) throws SQLException {
		System.out.println("---------------- OrdersDao.updateOrderState()");

		int row = 0;
		PreparedStatement stmt = null;
		String sql = "update orders set update_date = now(), order_state = ? where order_no = ?";
		
		try {
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, orderState);
			stmt.setInt(2, orderNo);
			row = stmt.executeUpdate();
			
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return row;
	}
	
}
