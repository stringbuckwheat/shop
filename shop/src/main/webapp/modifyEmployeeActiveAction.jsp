<%@page import="vo.Employee"%>
<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// return
		
// getParameter + 인스턴스 세팅
Employee employee = new Employee();
employee.setEmployeeId(request.getParameter("employeeId"));
employee.setEmployeeActive(request.getParameter("active"));
System.out.println("modifyEmployeeActiveAction.jsp: " + employee);

// 메소드 호출
EmployeeService employeeService = new EmployeeService();
employeeService.modifyEmployeeActive(employee);

response.sendRedirect(request.getContextPath() + "/employeeList.jsp");
%>