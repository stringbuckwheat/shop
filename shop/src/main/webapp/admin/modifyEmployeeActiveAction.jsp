<%@page import="vo.Employee"%>
<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// return
//로그인 한 사람만 입장 가능
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=no authority");
	return;
}

// active 값이 바뀌지 않았을 시 리턴 
if(request.getParameter("preActiveValue").equals(request.getParameter("active"))){
	response.sendRedirect(request.getContextPath() + "/employeeList.jsp?errorMsg=not changed");
	return;
}

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