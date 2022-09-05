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
employee.setEmployeeAddress(request.getParameter("employeeAddress"));
employee.setEmployeeDetailAddress(request.getParameter("employeeDetailAddress"));

System.out.println("employee: " + employee);

//insert / redirection
EmployeeService employeeService = new EmployeeService();

if(!employeeService.addEmployee(employee)){
	response.sendRedirect(request.getContextPath() + "/addEmployeeForm.jsp?errorMsg=sign up error");
	return;
}

// session에 저장해서 index.jsp로
session.setAttribute("user", "Employee");
session.setAttribute("id", request.getParameter("employeeId"));
session.setAttribute("name", request.getParameter("employeeName"));

response.sendRedirect(request.getContextPath() + "/index.jsp");
%>