<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("id") == null){
	response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=Login needed");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="<%=request.getContextPath()%>/outIdAction.jsp">
		<fieldset>
			<legend>비밀번호를 다시 한 번 입력하세요 </legend>
			<input type="password" name="pw">				
			<button type="submit">입력</button>
		</fieldset>
	</form>
</body>
</html>