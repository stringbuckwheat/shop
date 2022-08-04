<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String id = (String)session.getAttribute("id");
String pw = request.getParameter("pw");
String user = (String)session.getAttribute("user");
boolean result = false; // 결과 값을 받을 변수

// 세션에 저장된 user 값이 고객이면 
if("customer".equals(user)){
	// 인스턴스
	Customer customer = new Customer();
	customer.setCustomerId(id);
	customer.setCustomerPass(pw);
	
	CustomerService customerService = new CustomerService();
	// 	public void removeCustomer(Customer paramCustomer)
	result = customerService.removeCustomer(customer);
	
} else {
	// 파라미터 세팅
	Employee employee = new Employee();
	employee.setEmployeeId(id);
	employee.setEmployeePass(pw);
	
	System.out.println(employee + "<<<<<<<<<<<<<<<<<<<<<<<");
	
	EmployeeService employeeService = new EmployeeService();
	result = employeeService.removeEmployee(employee);
}

// 탈퇴 성공 시 logout으로 세션 정리한 다음 loginForm으로
// 실패 시 index로
String url = result ? "/logout.jsp" :  "/index.jsp?errorMsg=resign membership failed"; 

response.sendRedirect(request.getContextPath() + url);
%>