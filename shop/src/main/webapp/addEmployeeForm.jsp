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
	<title>add employee form</title>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<link href="css/loginForm.css" rel="stylesheet">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<div id="LoginForm">
		<div class="container">
			<div class="login-form">
				<div class="main-div">
				   <div class="panel">
					   <h2>관리자 회원 가입</h2>
						<%
							if(request.getParameter("errorMsg") != null){
								%>
								<span class="err-msg"><%=request.getParameter("errorMsg")%></span>
								<%
							}
						%>
						<div>
							<form>
								<div class="form-group">
									<input type="text" class="form-control" name="inputId" id="inputId" placeholder="아이디를 입력하세요">
								</div>
								<button type="button" class="btn btn-primary" id="idckBtn">아이디 중복 검사</button>
							</form>
						</div>
						
						<br>
						
						<form id="employeeForm" action="<%=request.getContextPath()%>/addEmployeeAction.jsp" method="post">
							<div class="form-group">
				        		<input type="text" class="form-control" name="employeeId" id="employeeId" readonly="readonly">
					        </div>
					        <div class="form-group">
					            <input type="password" class="form-control" name="employeePass" id="employeePass" placeholder="비밀번호를 입력하세요">
					        </div>
					        <div class="form-group">
					            <input type="text" class="form-control" name="employeeName" id="employeeName" placeholder="이름을 입력하세요">
					        </div>
					        <button type="button" class="btn btn-primary" id="employeeBtn">가입</button>
						 </form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
	// ajax
	$('#idckBtn').click(function() {
		if($('#inputId').val().length < 4) {
			alert('id는 4자이상!');
			return;
		}
		
		// 비동기 호출	
		$.ajax({
			url : '/ajax-test/idckController',
			type : 'post',
			data : {idck : $('#inputId').val()},
			success : function(json) {
				// alert(json);
				if(json == 'y') {
					$('#employeeId').val($('#inputId').val());
					return;
				}
				
				alert('이미 사용중인 아이디 입니다.');
				$('#employeeId').val('');
			} // end for success
		}); // end for ajax
	});

	// 빈칸검사
	$('#employeeBtn').click(function(){		
		if($('#employeeId').val() == ''){
			alert('아이디를 입력하세요');
		} else if($('#employeePass').val() == ''){
			alert('패스워드를 입력하세요');
		} else if($('#employeeName').val() == ''){
			alert('이름을 입력하세요');
		} else {
			$('#employeeForm').submit();
		}
	});
</script>

</body>
</html>