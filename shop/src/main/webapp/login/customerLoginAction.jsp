<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
System.out.println("--------------------- customerLoginAction.jsp");

// 이미 로그인한 회원은 접근 불가
if(session.getAttribute("id") != null){
	response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=already logined");
	return;
}

request.setCharacterEncoding("utf-8");
String id = request.getParameter("customerId");
String pw = request.getParameter("customerPass");

// 인스턴스 세팅
Customer customer = new Customer();
customer.setCustomerId(id);
customer.setCustomerPass(pw);

System.out.println("customer: " + customer);

CustomerService customerService = new CustomerService();
// ID와 이름을 받아옴
Customer loginCustomer = customerService.getCustomerByIdAndPw(customer);

// redirect
if(loginCustomer == null){
	response.sendRedirect(request.getContextPath() + "/login/customerLoginForm.jsp?errMsg=loginFail");
	return;
}

session.setAttribute("user", "Customer");
session.setAttribute("id", loginCustomer.getCustomerId());
session.setAttribute("name", loginCustomer.getCustomerName());

response.sendRedirect(request.getContextPath() + "/index.jsp");
%>