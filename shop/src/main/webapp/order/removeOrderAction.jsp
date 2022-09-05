<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// TODO 미완성 jsp
System.out.println("--------- removeOrderAction.jsp");

int orderNo = Integer.parseInt(request.getParameter("orderNo"));

OrdersService ordersService = new OrdersService();


%>