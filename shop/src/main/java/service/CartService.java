package service;

import java.sql.*;
import java.util.*;

import repository.CartDao;
import repository.OrdersDao;
import vo.Cart;

public class CartService {
	private DBUtil dbUtil;
	private CartDao cartDao;
	private OrdersDao ordersDao;
	
	// int/boolean addCart(Cart cart)
	public boolean addCart(Cart cart) {
		System.out.println("---------------- CartService.addCart()");
		Connection conn = null;
		boolean result = true; // 메소드 실행 결과값을 담을 변수
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			this.cartDao = new CartDao();
			if(cartDao.insertCart(conn, cart) != 1) {
				throw new Exception();
			}
			
			conn.commit();
		} catch(Exception e) {
			System.out.println("cartService.addCart() 실패");
			e.printStackTrace();
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			result = false;
			
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}

	// List<Cart> getCartList(String id)
	public List<Map<String, Object>> getCartList(String id){
		System.out.println("---------------- CartService.getCartList()");

		List<Map<String, Object>> cartList = null;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.cartDao = new CartDao();
			cartList = cartDao.selectCartList(conn, id);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cartList;
	}
	
	// int/boolean modifyCart(Cart cart) - goodsNo, cartQuantity
	public void modifyCart(Cart cart) {
		System.out.println("---------------- CartService.modifyCart()");

		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.cartDao = new CartDao();
			int row = cartDao.updateCart(conn, cart);
			
			if(row != 1) {
				System.out.println("카트 수량변경 실패");
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
	}
	
	// int/boolean removeCart(Cart cart) - goodsNo, customerId
	public int removeCart(Cart cart) {
		System.out.println("---------------- CartService.removeCart()");

		int row = 0;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.cartDao = new CartDao();
			row = cartDao.deleteCart(conn, cart);
			
			if(row == 0) {
				System.out.println("카트 삭제 성공");
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
		return row;
	}
	
	// 장바구니에 든 아이템 하나를 주문하는 메소드 -> action에서 반복문을 돌려 전체 주문하기
	// 트랜잭션: order 테이블에 insert하고 cart 테이블에서 지우기
	public boolean orderCartOne(Map<String, Object> map) {
		System.out.println("----------------CartService.orderCartOne()");
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋 해제
			
			this.cartDao = new CartDao();
			if(cartDao.deleteCart(conn, map) != 1) {
				throw new Exception(); // 오류는 발생하지 않았지만 삭제는 안 된 경우
			}
			
			this.ordersDao = new OrdersDao();
			if(ordersDao.insertOrder(conn, map) != 1) {
				throw new Exception(); // 오류는 발생하지 않았지만 삭제는 안 된 경우
			}
			
			conn.commit(); // exception 발생 시 내려오지 않음
			
		} catch(Exception e) {
			e.printStackTrace(); // *****
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			return false;
			
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return true;
	} 
}
