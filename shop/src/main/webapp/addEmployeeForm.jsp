<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("id") != null){
	response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=already logined");
	return;
}
%>
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
<input type="text" name="inputId" id="inputId">
<button type="button" id="idckBtn">아이디 중복 검사</button>

<form id="employeeForm" action="<%=request.getContextPath()%>/addEmployeeAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>employee id</td>
				<td>
					<input type="text" name="employeeId" id="employeeId" readonly="readonly">
					<button type="button" id="idckBtn">아이디 중복 검사</button>
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
	// ajax
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
						$('#employeeId').val($('#inputId').val());
					} else {
						alert('이미 사용중인 아이디 입니다.');
						$('#employeeId').val('');
					}
				}
			});
		}
	});

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