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
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>customer login form</title>
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
				   <h2>Customer Login</h2>
				   <p>Please enter your id and password</p>
				   <%
					if(request.getParameter("errorMsg") != null){
					%>
						<span class="err-msg"><%=request.getParameter("errorMsg")%></span>
					<%
					}
					%>
				   
					</div>
				   <form id="customerLoginForm" method="post" action="<%=request.getContextPath()%>/customerLoginAction.jsp">
				        <div class="form-group">
				        	<input type="text" class="form-control" name="customerId" id="customerId" placeholder="enter your id...">
				        </div>
				        <div class="form-group">
				            <input type="password" class="form-control" name="customerPass" id="customerPass" placeholder="enter your password...">
				        </div>
				        <div class="forgot">
				 	       <a href="<%=request.getContextPath()%>/addCustomerForm.jsp">Sign Up</a>
						</div>
				        <button type="button" class="btn btn-primary" id="customerLoginBtn">Login</button>
				        <div class="forgot text-center">
				 	       <a href="<%=request.getContextPath()%>/employeeLoginForm.jsp">관리자 로그인</a>
						</div>
				    </form>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	// 고객 빈칸검사
	$('#customerLoginBtn').click(function(){		
		if($('#customerId').val() == ''){
			alert('고객 아이디를 입력하세요');
		} else if($('#customerPass').val() == ''){
			alert('고객 패스워드를 입력하세요');
		} else {
			$('#customerLoginForm').submit();
		}
	});
</script>
</html>