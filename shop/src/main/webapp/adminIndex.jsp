<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 세선 유효성 검정 코드 
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	// customer로 로그인한 사람은 loginForm -> index 
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
		<div>
			<ul>
				<li><a href="<%=request.getContextPath()%>/employeeList.jsp">사원관리</a></li>
				<li><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리</a></li> <!-- 상품목록/등록/수정(품절)/삭제(장바구니, 주문이 없는 경우) -->
				<li><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">고객관리</a></li> <!-- 주문목록 / 수정 -->
				<li><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">주문관리</a></li> <!-- 고객목록 / 강제 탈퇴 / 비밀번호 수정(전달 구현 X) -->
				<li><a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리</a></li> <!-- 공지 CRUD -->
			</ul>
		</div>
		
		<!-- 메인 내용 -->
		<h1>사원관리</h1>
		<div>
			<!-- 사원 목록, active 값 수정 -->
		</div>
	</body>
</html>