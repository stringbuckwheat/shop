<%@page import="service.CartService"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"));
String id = (String)session.getAttribute("id");

Cart cart = new Cart();
cart.setGoodsNo(goodsNo);
cart.setCustomerId(id);
cart.setCartQuantity(cartQuantity);
System.out.println(cart);

CartService cartService = new CartService();
cartService.modifyCart(cart);

response.sendRedirect(request.getContextPath() + "/cart/cartList.jsp?id=" + id);
%>
