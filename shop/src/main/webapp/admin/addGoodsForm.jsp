<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	// customer로 로그인한 사람은 loginForm -> index 
	response.sendRedirect(request.getContextPath() + "/login/employeeLoginForm.jsp?errorMsg=no authority");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>add goods form</title>
</head>
<body>
	<%
	// errorMsg 파라미터가 존재하면 알림창으로 알려줌
	if(request.getParameter("errorMsg") != null){
	%>
		<script>alert("<%=request.getParameter("errorMsg")%>")</script>
	<%
	}
	%>
	
	<form action="<%=request.getContextPath()%>/admin/addGoodsAction.jsp" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>제품 이름</td>
				<td><input type="text" name="goodsName"></td>
			</tr>
			<tr>
				<td>제품 가격</td>
				<td><input type="text" name="goodsPrice"></td>
			</tr>
			<tr>
				<td>품절 여부</td>
				<td><input type="text" name="soldOut"></td>
			</tr>
			<tr>
				<td>이미지 파일</td>
				<td><input type="file" name="imgFile"></td>
			</tr>
		</table>
		<button type="submit" id="btn">submit</button>
	</form>
</body>
</html>