<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

if(session.getAttribute("id") != null){
	response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=already logined");
	return;
}

request.setCharacterEncoding("utf-8");

//인스턴스
Employee employee = new Employee();
employee.setEmployeeId(request.getParameter("employeeId"));
employee.setEmployeePass(request.getParameter("employeePass"));
employee.setEmployeeName(request.getParameter("employeeName"));

System.out.println("employee: " + employee);

//insert / redirection
EmployeeService employeeService = new EmployeeService();

if(!employeeService.addEmployee(employee)){
	response.sendRedirect(request.getContextPath() + "/addEmployeeForm.jsp?errorMsg=sign up error");
	return;
}

response.sendRedirect(request.getContextPath() + "/loginForm.jsp");

%>