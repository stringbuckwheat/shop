<%@page import="service.SignService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

//인스턴스
Employee employee = new Employee();
employee.setEmployeeId(request.getParameter("employeeId"));
employee.setEmployeePass(request.getParameter("employeePass"));
employee.setEmployeeName(request.getParameter("employeeName"));

System.out.println("employee: " + employee);

//insert / redirection
SignService signService = new SignService();

if(!signService.addEmployee(employee)){
	response.sendRedirect(request.getContextPath() + "/addEmployeeForm.jsp?errorMsg=sign up error");
	return;
}

response.sendRedirect(request.getContextPath() + "/loginForm.jsp");

%>