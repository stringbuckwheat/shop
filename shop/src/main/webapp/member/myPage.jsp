<%@page import="service.CounterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

if(session.getAttribute("id") == null){
	response.sendRedirect(request.getContextPath() + "/login/customerLoginForm.jsp?errorMsg=Login needed");
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
	<title>index</title>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
	<link href="<%=request.getContextPath()%>/css/adminIndex.css" rel="stylesheet">
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<div class="container">
	    	
			<%
			if(request.getParameter("errorMsg") != null){
			%>
				<div>
					<span class="err-msg"><%=request.getParameter("errorMsg")%></span>
				</div>
			<%
			}
			%>
	    	
	    	<h2>MYPAGE</h2>
	
				<div>
					총 방문자 수: <%=totalCounter%>
				</div>
				<div>
					오늘 방문자 수: <%=todayCounter%>
				</div>
				<div>
					동시 접속자 수: <%=currentCount%>
				</div>
				<div>
					<a href="<%=request.getContextPath()%>/order/orderListForCustomer.jsp?customerId=<%=session.getAttribute("id")%>">주문 내역 조회</a>
				</div>
				<div>
					<a href="<%=request.getContextPath()%>/member/outIdForm.jsp">회원 탈퇴</a>
				</div>
		    
				<%
				if("Employee".equals(session.getAttribute("user"))){
				%>
					<div>
			         	<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">관리자 페이지</a>
			        </div>
				<%
				}
				%>
		</div>
</body>
</html>