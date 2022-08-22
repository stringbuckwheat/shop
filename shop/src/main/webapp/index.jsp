<%@page import="service.CounterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

if(session.getAttribute("id") == null){
	response.sendRedirect(request.getContextPath() + "/customerLoginForm.jsp?errorMsg=Login needed");
	return;
}

/* 
index.jsp -> 사원으로 로그인한 경우 관리자 페이지 링크(adminIndex.jsp)
adminIndex.jsp -> 사원관리, 상품관리, 고객관리, 주문관리, 공지 관리
1) 사원관리(리스트): employeeList.jsp -> EmployeeService.getEmployeeList(int rowPerPage, int currentPage): beginRow 구하기 -> EmployeeDao.selectEmployeeList(int rowPerPage, int beginRow)
					여기서 active 값 N을 Y로 수정할 수 있도록! (select 상자) -> EmployeeService.modifyEmployeeActive() -> EmployeeDao.updateEmployeeActive()
*/

CounterService counterService = new CounterService();

int totalCounter = counterService.getTotalCount();
int todayCounter = counterService.getTodayCount();
int currentCount = (Integer)(application.getAttribute("currentCounter"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Index</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="<%=request.getContextPath()%>/css/loginForm.css" rel="stylesheet">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	
	<%
	if(request.getParameter("errorMsg") != null){
	%>
		<div>
			<span class="err-msg"><%=request.getParameter("errorMsg")%></span>
		</div>
	<%
	}
	%>
	<div>
		<%=session.getAttribute("user")%>
		<br>
		<%=session.getAttribute("id")%>
		<br>
		<%=session.getAttribute("name")%>
		<br>
		<a href="<%=request.getContextPath()%>/outIdForm.jsp">회원 탈퇴</a>
	</div>
	
	<%
	if("Employee".equals(session.getAttribute("user"))){
	%>
		<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">관리자 페이지</a>
	<%
	}
	%>
	
<script src="js/jquery.min.js"></script>
<script src="js/popper.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>