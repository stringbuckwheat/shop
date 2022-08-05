<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCustomer</title>
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
	<!-- id check form -->
	<form action="<%=request.getContextPath()%>/idCheckAction.jsp" method="post">
		<input type="hidden" name="membership" value="Customer">
		<table border="1">
			<tr>
				<td>id 중복 체크</td>
				<td>
					<input type="text" name="inputId" id="inputId">
				</td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
	
	<!-- 고객가입 form -->
	<%
		String inputId = ""; // 빈 문자열
		if(request.getParameter("inputId") != null){
			inputId = request.getParameter("inputId");
		}
		
		/*
		private String customerId;
		private String customerPass;
		private String customerName;
		private String customerAddress;
		private String customerTelephone; //// 여기까지
		private String customerUpdateDate;
		private String customerCreateDate;
	*/
	%>
	
	<form id="customerForm" action="<%=request.getContextPath()%>/addCustomerAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>customer id</td>
				<td>
					<input type="text" name="customerId" id="customerId" 
						readonly="readonly" value="<%=inputId%>">
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