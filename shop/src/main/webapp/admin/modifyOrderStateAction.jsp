<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 세션 유효성 검사 - 로그인 한 관리자 계정만 접근 가능
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	response.sendRedirect(request.getContextPath() + "/employeeLoginForm.jsp?errorMsg=no authority");
	return;
}

request.setCharacterEncoding("utf-8");

//orderState 값이 바뀌지 않았을 시 리턴 
//TODO: 일단은 orderList로 redirection 해놓았는데 고민 필요
if(request.getParameter("preOrderState").equals(request.getParameter("orderState"))){
	response.sendRedirect(request.getContextPath() + "/orderList.jsp?errorMsg=not changed");
	return;
}

// getParameter
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
int currentPage = Integer.parseInt(request.getParameter("currentPage"));
String orderState = request.getParameter("orderState");

// service method
OrdersService ordersService = new OrdersService();
ordersService.modifyOrderState(orderState, orderNo);

// redirection
// 2 이상의 페이지에서 주문 상태를 변경했을 때, 그 페이지로 돌아갈 수 있도록
response.sendRedirect(request.getContextPath() + "/admin/adminOrdersList.jsp?currentPage=" + currentPage);

%>