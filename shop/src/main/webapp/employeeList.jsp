<%@page import="vo.Employee"%>
<%@page import="java.util.List"%>
<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

int currentPage = 1;

if(request.getParameter("currentPage") != null){
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

final int rowPerPage = 10; // 페이지 당 출력할 글 개수

EmployeeService employeeService = new EmployeeService();
List<Employee> employeeList = employeeService.getEmployeeList(rowPerPage, currentPage);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 목록</title>
</head>
<body>
	<!-- 사원 목록 -->
</body>
</html>