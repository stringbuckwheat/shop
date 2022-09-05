<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("id") != null){
	response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=alreadyLogined");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>employee login form</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="<%=request.getContextPath()%>/css/loginForm.css" rel="stylesheet">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	<div id="LoginForm">
		<div class="container">
			<div class="login-form">
				<div class="main-div">
				   <div class="panel">
					   <h2>Admin Login</h2>
					   <p>Please enter your id and password</p>
					   
					   <%
						if(request.getParameter("errorMsg") != null){
						%>
							<span class="err-msg"><%=request.getParameter("errorMsg")%></span>
						<%
						}
						%>
				   </div>
				   <form id="employeeLoginForm" method="post" action="<%=request.getContextPath()%>/login/employeeLoginAction.jsp">
				        <div class="form-group">
				        	<input type="text" class="form-control" name="employeeId" id="employeeId" placeholder="enter your id...">
				        </div>
				        <div class="form-group">
				            <input type="password" class="form-control" name="employeePass" id="employeePass" placeholder="enter your password...">
				        </div>
				        <div class="forgot">
				 	       <a href="<%=request.getContextPath()%>/member/addEmployeeForm.jsp">Sign Up</a>
						</div>
				        <button type="button" class="btn btn-primary" id="employeeLoginBtn">Login</button>
				        <div class="forgot text-center">
				 	       <a href="<%=request.getContextPath()%>/login/customerLoginForm.jsp">일반 회원 로그인</a>
						</div>
				    </form>
				</div>
			</div>
		</div>
	</div>
</body>
<script>	
	// 직원 빈칸검사
	$('#employeeLoginBtn').click(function(){
		if($('#employeeId').val() == ''){
			alert('고객 아이디를 입력하세요');
		} else if($('#employeePass').val() == ''){
			alert('고객 패스워드를 입력하세요');
		} else {
			$('#employeeLoginForm').submit();
		}
	});
</script>
</html>