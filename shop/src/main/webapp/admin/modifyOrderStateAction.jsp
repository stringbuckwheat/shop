<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//return
//로그인 한 사람만 입장 가능
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	response.sendRedirect(request.getContextPath() + "/customerLoginForm.jsp?errorMsg=no authority");
	return;
}

//orderState 값이 바뀌지 않았을 시 리턴 
//TODO: 일단은 orderList로 redirection 해놓았는데 고민 필요
if(request.getParameter("preOrderState").equals(request.getParameter("orderState"))){
	response.sendRedirect(request.getContextPath() + "/orderList.jsp?errorMsg=not changed");
	return;
}

// getParameter
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
String orderState = request.getParameter("orderState");

// service method
OrdersService ordersService = new OrdersService();
ordersService.modifyOrderState(orderState, orderNo);

// redirection
// TODO: 데이터가 커지면 그 페이지로 돌아갈 수 있도록
response.sendRedirect(request.getContextPath() + "/orderList.jsp");

%>