package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.OrdersDao;

public class OrdersService {
	private OrdersDao ordersDao;
	private DBUtil dbUtil;
	
	public OrdersService() {
		super();
		this.ordersDao = new OrdersDao();
		this.dbUtil = new DBUtil();
	}
	
	public List<Map<String, Object>> getOrderListByPage(int rowPerPage, int currentPage){
		List<Map<String, Object>> orderList = null;
		Connection conn = null;
		
		// beginRow 구하기
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			conn = dbUtil.getConnection();
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
		Connection conn = null;
		int lastPage = 0;

		try {
			conn = dbUtil.getConnection();
			int cnt = ordersDao.countAllOrders(conn);
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
		Connection conn = null;
		List<Map<String, Object>> orders = null;
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			conn = dbUtil.getConnection();
			orders = ordersDao.selectOrderListByCustomer(conn, customerId, rowPerPage, beginRow);
			System.out.println(orders);
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
		Map<String, Object> orderDetail = null;
		Connection conn = null;
		
		try {
			
			conn = dbUtil.getConnection();
			orderDetail = ordersDao.selectOrderOne(conn, orderNo);
			
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
}
