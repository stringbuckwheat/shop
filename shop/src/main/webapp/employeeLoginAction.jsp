<%@page import="service.EmployeeService"%>
<%@page import="repository.EmployeeDao"%>
<%@page import="vo.Employee"%>
<%@page import="repository.EmployeeDao"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
if(session.getAttribute("id") != null){
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=alreadyLogined");
	return;
}

request.setCharacterEncoding("utf-8");
String id = request.getParameter("staffId");
String pw = request.getParameter("staffPass");

// 인스턴스 세팅
Employee employee = new Employee();
employee.setEmployeeId(id);
employee.setEmployeePass(pw);

EmployeeService employeeService = new EmployeeService();
Employee loginEmployee = employeeService.getEmployeeByIdAndPw(employee);

System.out.println("loginEmployee: " + loginEmployee);

// redirect
if(loginEmployee == null){
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=loginFail");
	return;
}

session.setAttribute("user", "Employee");
session.setAttribute("id", loginEmployee.getEmployeeId());
session.setAttribute("name", loginEmployee.getEmployeeName());

response.sendRedirect(request.getContextPath() + "/index.jsp");
%>