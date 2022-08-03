<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div>
		<h1>고객</h1>

		<%
		if(request.getParameter("errorMsg") != null){
			%>
			<span><%=request.getParameter("errorMsg")%></span>
			<%
		}
		%>

		<form id="customerForm" method="post" action="<%=request.getContextPath()%>/customerLoginAction.jsp">
			<fieldset>
				<legend>쇼핑몰 고객 로그인</legend>
				<table border="1">
					<tr>
						<td>ID</td>
						<td><input type="text" name="customerId" id="customerId"></td>
					</tr>
					<tr>
						<td>PW</td>
						<td><input type="password" name="customerPass" id="customerPass"></td>
					</tr>
				</table>
				<button type="button" id="customerBtn">로그인</button>
			</fieldset>
		</form>
	</div>
	<div>
		<h1>staff</h1>
		<form id="employeeForm" method="post" action="<%=request.getContextPath()%>/employeeLoginAction.jsp">
			<fieldset>
				<legend>쇼핑몰 스텝 로그인</legend>
				<table border="1">
					<tr>
						<td>ID</td>
						<td><input type="text" name="staffId" id="staffId"></td>
					</tr>
					<tr>
						<td>PW</td>
						<td><input type="password" name="staffPass" id="staffPass"></td>
					</tr>
				</table>
				<button type="button" id="staffBtn">로그인</button>
			</fieldset>
		</form>
	</div>
</body>
<script>
	
	// 고객 빈칸검사
	$('#customerBtn').click(function(){		
		if($('#customerId').val() == ''){
			alert('고객 아이디를 입력하세요');
		} else if($('#customerPass').val() == ''){
			alert('고객 패스워드를 입력하세요');
		} else {
			$('#customerForm').submit();
		}
	});
	
	// 스텝 빈칸검사
	$('#staffBtn').click(function(){
		if($('#staffId').val() == ''){
			alert('고객 아이디를 입력하세요');
		} else if($('#staffPass').val() == ''){
			alert('고객 패스워드를 입력하세요');
		} else {
			$('#employeeForm').submit();
		}
	});
	
</script>
</html>

