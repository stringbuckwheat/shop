<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>add employee form</title>
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
		<input type="hidden" name="membership" value="Employee">
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
	
<!-- 직원 가입 form -->
<%
		String inputId = ""; // 빈 문자열
		if(request.getParameter("inputId") != null){
			inputId = request.getParameter("inputId");
		}
		
	/*
	private String employeeId;
	private String employeePass;
	private String employeeName;
	private String updateDate;
	private String createDate;
	private String employeeActive;
	*/
%>
<form id="employeeForm" action="<%=request.getContextPath()%>/addEmployeeAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>employee id</td>
				<td>
					<input type="text" name="employeeId" id="employeeId" 
						readonly="readonly" value="<%=inputId%>">
				</td>
			</tr>
			<tr>
				<td>employee password</td>
				<td>
					<input type="password" name="employeePass" id="employeePass">
				</td>
			</tr>
			<tr>
				<td>employee name</td>
				<td>
					<input type="text" name="employeeName" id="employeeName">
				</td>
			</tr>
		</table>
		<button type="button" id="employeeBtn">제출</button>
	</form>
</body>
<script>
	// 빈칸검사
	$('#employeeBtn').click(function(){		
		if($('#employeeId').val() == ''){
			alert('아이디를 입력하세요');
		} else if($('#employeePass').val() == ''){
			alert('패스워드를 입력하세요');
		} else {
			$('#employeeForm').submit();
		}
	});
</script>

</body>
</html>