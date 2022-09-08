<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
System.out.println("--------------------- addReviewForm.jsp");

// 세션 유효성 검사
if(session.getAttribute("id") == null || session.getAttribute("user").equals("Employee")){
	response.sendRedirect(request.getContextPath() + "/login/customerLoginForm.jsp?errorMsg=login needed");
	return;
}

// 파라미터 받아오기
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
System.out.println("orderNo: " + orderNo);

// review에 필요한 것: order_no, review_content, create_date, update_date, rating
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>addReviewForm</title>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	
</body>
</html>