<%@page import="service.CartService"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//세션 유효성 검사
if(session.getAttribute("id") == null){	
	response.sendRedirect(request.getContextPath() + "/login/customerLoginForm.jsp?errorMsg=login needed");
	return;
}

int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
String id = (String)session.getAttribute("id");

Cart cart = new Cart();
cart.setGoodsNo(goodsNo);
cart.setCustomerId(id);

CartService cartService = new CartService();
cartService.removeCart(cart);

response.sendRedirect(request.getContextPath() + "/cart/cartList.jsp?id=" + id);
%>