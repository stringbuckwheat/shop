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
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/button.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	<div class="container">
	    <div class="row col-md-8 col-md-offset-1 custyle">
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
			
			<%
			if(request.getParameter("errorMsg") != null){
			%>
				<div>
					<span class="err-msg"><%=request.getParameter("errorMsg")%></span>
				</div>
			<%
			}
			%>
			
			<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
			<!-- Bootsnipp -->
			<ins class="adsbygoogle"
			     style="display:block"
			     data-ad-client="ca-pub-7749520983305929"
			     data-ad-slot="1217000491"
			     data-ad-format="auto"></ins>
			<script>
			(adsbygoogle = window.adsbygoogle || []).push({});
			</script>
			
			<div class="well text-center">
		         <button type="button" class="btn btn-sunny text-uppercase">
		         	<a href="<%=request.getContextPath()%>/member/outIdForm.jsp">회원 탈퇴</a>
		         </button>
		         <button type="button" class="btn btn-sunny text-uppercase">
		         	<a href="<%=request.getContextPath()%>/index.jsp">쇼핑하기</a>
		         </button>
		        
		 	
					<%
					if("Employee".equals(session.getAttribute("user"))){
					%>
						<button type="button" class="btn btn-sunny text-uppercase">
				         	<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">관리자 페이지</a>
				         </button>
					<%
					}
					%>
			</div>
		</div>
	</div>
</body>
</html>