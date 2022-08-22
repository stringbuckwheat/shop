<%@page import="java.util.Map"%>
<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
System.out.println("------------------------- addOrderAction.jsp");

//TODO 세션 유효성 검사 코드 추가

request.setCharacterEncoding("utf-8");
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

// form에서 계산한 총 금액을 goodsPrice에 대입
int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
String orderAddress = request.getParameter("orderAddress");
String orderDetailAddress = request.getParameter("orderDetailAddress");
String customerId = (String)session.getAttribute("id");

// vo 세팅
Orders order = new Orders();
order.setGoodsNo(goodsNo);
order.setOrderPrice(orderPrice);
order.setOrderQuantity(orderQuantity);
order.setOrderAddress(orderAddress);
order.setOrderDetailAddress(orderDetailAddress);
order.setCustomerId(customerId);

// 디버깅
System.out.println(order);

OrdersService ordersService = new OrdersService();
int orderNo = ordersService.addOrder(order);

if(orderNo == 1){
	System.out.println("주문 실패!");
	response.sendRedirect(request.getContextPath() + "/goodsAndImgOne.jsp?goodsNo=" + goodsNo);
	return;
}

response.sendRedirect(request.getContextPath() + "/order/orderDetail.jsp?orderNo=" + orderNo);

%>