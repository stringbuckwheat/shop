<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// 로그인 한 사람
if(session.getAttribute("id") != null){
	response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=already logined");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>add Customer</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<%
		if(request.getParameter("errorMsg") != null){
			%>
			<span><%=request.getParameter("errorMsg")%></span>
			<%
		}
	%>
	
	<input type="text" name="inputId" id="inputId">
	<button type="button" id="idckBtn">아이디 중복 검사</button>
	
	<form id="customerForm" action="<%=request.getContextPath()%>/addCustomerAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>customer id</td>
				<td>
					<input type="text" name="customerId" id="customerId" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>customer password</td>
				<td>
					<input type="password" name="customerPass" id="customerPass">
				</td>
			</tr>
			<tr>
				<td>customer name</td>
				<td>
					<input type="text" name="customerName" id="customerName">
				</td>
			</tr>
			<tr>
				<td>customer address</td>
				<td>
					<input type="text" name="customerAddress" id="customerAddress">
				</td>
			</tr>
			<tr>
				<td>customer telephone</td>
				<td>
					<input type="text" name="customerTelephone" id="customerTelephone">
				</td>
			</tr>
		</table>
		<button type="button" id="customerBtn">제출</button>
	</form>
</body>
<script>
	$('#idckBtn').click(function() {
		if($('#inputId').val().length < 4) {
			alert('id는 4자이상!');
		} else {
			// 비동기 호출	
			$.ajax({
				url : '/ajax-test/idckController',
				type : 'post',
				data : {idck : $('#inputId').val()},
				success : function(json) {
					// alert(json);
					if(json == 'y') {
						$('#customerId').val($('#inputId').val());
					} else {
						alert('이미 사용중인 아이디 입니다.');
						$('#customerId').val('');
					}
				}
			});
		}
	});

	// 고객 빈칸검사
	$('#customerBtn').click(function(){		
		if($('#customerId').val() == ''){
			alert('고객 아이디를 입력하세요');
		} else if($('#customerPass').val() == ''){
			alert('고객 패스워드를 입력하세요');
		} else if($('#customerName').val() == ''){
			alert('성함을 입력하세요');
		} else if($('#customerAddress').val() == ''){
			alert('주소를 입력하세요');
		} else if($('#customerTelephone').val() == ''){
			alert('전화번호를 입력하세요');
		} else {
			$('#customerForm').submit();
		}
	});
</script>

</html>