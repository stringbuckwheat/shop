<%@page import="service.CounterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 세션 유효성 검정 코드 
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	// customer로 로그인한 사람은 loginForm -> index 
	response.sendRedirect(request.getContextPath() + "/employeeLoginForm.jsp?errorMsg=no authority");
	return;
}

// 사원관리, 상품관리, 고객관리, 주문관리, 공지관리

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
	<title>admin index</title>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
	<link href="<%=request.getContextPath()%>/css/adminIndex.css" rel="stylesheet">
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/button.css">

</head>
<body>
	<%@include file="../header.jsp"%>
	<div class="container">
	    <div class="row col-md-8 col-md-offset-1 custyle">
	    	<h2>관리자 페이지</h2>
	    	
	    	<%
			if(request.getParameter("errorMsg") != null){
			%>
				<span class="err-msg"><%=request.getParameter("errorMsg")%></span>
			<%
			}
			%>
			
			<div>
				총 방문자 수: <%=totalCounter%>
			</div>
			<div>
				오늘 방문자 수: <%=todayCounter%>
			</div>
			<div>
				동시 접속자 수: <%=currentCount%>
			</div>
	    	
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
	             	<a href="<%=request.getContextPath()%>/admin/employeeList.jsp">사원관리</a>
	             </button>
	             <button type="button" class="btn btn-sunny text-uppercase">
	             	<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리</a>
	             </button>
	             <button type="button" class="btn btn-sunny text-uppercase">
	             	<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a>
	             </button>
	             <button type="button" class="btn btn-sunny text-uppercase">
	             	<a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리</a>
	             </button>
	             <button type="button" class="btn btn-sunny text-uppercase">
	             	<a href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지관리</a>
	             </button>
			 </div>
		</div>
	</div>
</body>
</html>