<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// 로그인 되어 있는 사람
if(session.getAttribute("id") != null){
	response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=already logined");
	return;
}

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
CustomerService customerService = new CustomerService();

if(!customerService.addCustomer(customer)){
	response.sendRedirect(request.getContextPath() + "/addCustomerForm.jsp?errorMsg=sign up error");
	return;
}

// 세션에 저장해서 index로
session.setAttribute("user", "Customer");
session.setAttribute("loginid", request.getParameter("customerId"));
session.setAttribute("name", request.getParameter("customerName"));

response.sendRedirect(request.getContextPath() + "/index.jsp");
%>