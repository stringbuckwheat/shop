<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//로그인 한 사람만 입장 가능
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	// customer로 로그인한 사람은 loginForm -> index 
	// TODO 에러메시지도 같이 넘기기 
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=no authority");
	return;
}

// 사원관리, 상품관리, 고객관리, 주문관리, 공지관리
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin index</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/employeeList.jsp">사원관리</a>
	<a href="#">상품관리</a>
	<a href="#">고객관리</a>
	<a href="#">주문관리</a>
	<a href="#">공지관리</a>
</body>
</html>