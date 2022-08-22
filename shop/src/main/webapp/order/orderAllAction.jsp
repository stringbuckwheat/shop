<%@page import="java.util.*"%>
<%@page import="service.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
System.out.println("--------------- orderAllAction.jsp");

request.setCharacterEncoding("utf-8");

String id = (String)session.getAttribute("id");
String orderAddress = request.getParameter("orderAddress");
String orderDetailAddress = request.getParameter("orderDetailAddress");

CartService cartService = new CartService();
List<Map<String, Object>> list = cartService.getCartList(id);

// map 안의 기존 데이터 확인
System.out.println("map: " + list.get(0));

/*
map 안에 이미 들어있는 것들:
String sql = "select c.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, c.cart_quantity cartQuantity"
				+ " from cart c inner join goods g on c.goods_no = g.goods_no"
				+ " where customer_id = ?"
				+ " order by c.create_date desc;";
				
주문에 필요한 것들:
	String sql = "insert into orders (goods_no, customer_id, order_quantity, order_state, order_price, order_address, order_detail_address, update_date, create_date)"
			+ " values (?, ?, ?, '주문 완료', ?, ?, ?, now(), now())";
*/


for(Map<String, Object> m : list){
	// 아이템 별 주문 금액 구하기
	int totalPrice = (int)m.get("goodsPrice") * (int)m.get("cartQuantity");
	
	// 덮어쓰기
	m.put("orderPrice", totalPrice);
	
	// 주소 폼에서 받은 파라미터
	m.put("orderAddress", orderAddress);
	m.put("orderDetailAddress", orderDetailAddress);
	m.put("customerId", id);
	
	boolean result = cartService.orderCartOne(m);
	
	if(result){
		continue;
	}
}

response.sendRedirect(request.getContextPath() + "/orderListForCustomer.jsp?customerId=" + id);

%>