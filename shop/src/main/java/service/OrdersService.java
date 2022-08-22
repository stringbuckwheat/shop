package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.NoticeDao;
import repository.OrdersDao;
import vo.Orders;

public class OrdersService {
	private OrdersDao ordersDao;
	private DBUtil dbUtil;
	
	public List<Map<String, Object>> getOrderListByPage(int rowPerPage, int currentPage){
		System.out.println("----------- OrdersService.getOrderListByPage()");
		
		List<Map<String, Object>> orderList = null;
		Connection conn = null;
		
		// beginRow 구하기
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.ordersDao = new OrdersDao();
			orderList = ordersDao.selectOrdersList(conn, rowPerPage, beginRow);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return orderList;
	}
	
	public int getLastPage(int rowPerPage) {
		System.out.println("----------- OrdersService.getLastPage()");

		Connection conn = null;
		int lastPage = 0;

		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.ordersDao = new OrdersDao();
			int cnt = ordersDao.countAllOrders(conn); // 전체 컬럼 개수 반환
			
			// lastPage 구하기
			lastPage = (int) Math.ceil(cnt / (double) rowPerPage);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return lastPage;
	}
	
	public List<Map<String, Object>> getOrderById(String customerId, int rowPerPage, int currentPage){
		System.out.println("----------- OrdersService.getOrderById()");

		Connection conn = null;
		List<Map<String, Object>> orders = null;
		
		// 시작하는 행 구하기
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.ordersDao = new OrdersDao();
			orders = ordersDao.selectOrderListByCustomer(conn, customerId, rowPerPage, beginRow);
			
			System.out.println("고객별 주문 리스트의 크기: " + orders.size());
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		return orders;
	}
	
	public Map<String, Object> getOrderDetail(int orderNo){
		System.out.println("----------- OrdersService.getOrderDetail()");

		Map<String, Object> orderDetail = null;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.ordersDao = new OrdersDao();
			orderDetail = ordersDao.selectOrderOne(conn, orderNo);
			
			if(orderDetail != null) {
				System.out.println("OrdersService.getOrderDetail() 성공!");
			}
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
		} finally {
			
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		return orderDetail;
	}
	
	// 배송상태 변경 메소드
	public void modifyOrderState(String orderState, int orderNo) {
		System.out.println("----------- OrdersService.modifyOrderState()");
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.ordersDao = new OrdersDao();
			ordersDao.updateOrderState(conn, orderState, orderNo);
			
		} catch (Exception e) {
		
			e.printStackTrace();

		} finally {
			
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
	}
	
	// 주문하기
	public int addOrder(Orders order) {
		System.out.println("----------- OrdersService.addOrder()");

		int orderNo = 0;
		Connection conn = null;
		
		try {
			
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.ordersDao = new OrdersDao();
			orderNo = ordersDao.insertOrder(conn, order);
			
			if(orderNo == 0) {
				System.out.println("주문하기 실패!");
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();

		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return orderNo;
	}
	
	
}
