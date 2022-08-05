<%@page import="service.SignService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");

// 인스턴스
Customer customer = new Customer();
customer.setCustomerId(request.getParameter("customerId"));
customer.setCustomerPass(request.getParameter("customerPass"));
customer.setCustomerName(request.getParameter("customerName"));
customer.setCustomerAddress(request.getParameter("customerAddress"));
customer.setCustomerTelephone(request.getParameter("customerTelephone"));

System.out.println("customer: " + customer);

// insert / redirection
SignService signService = new SignService();

if(!signService.addCustomer(customer)){
	response.sendRedirect(request.getContextPath() + "/addCustomerForm.jsp?errorMsg=sign up error");
	return;
}

response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
%>