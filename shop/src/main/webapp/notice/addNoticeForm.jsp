<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// 세션 유효성 검사
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	response.sendRedirect(request.getContextPath() + "/employeeLoginForm.jsp?errorMsg=login needed");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>add notice form</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<%@include file="/header.jsp"%>
	<div class="container">
		<div class="text-center">
			<h2>공지 수정</h2>
		</div>
		<div class="row">
		    <div class="col-md-8 col-md-offset-2 custyle">
			    <form action="<%=request.getContextPath()%>/notice/addNoticeAction.jsp" method="post">
					<table class="table table-striped custab">
						<tr>
							<th>제목</th>
							<td>
								<input type="text" class="form-control" name="noticeTitle">
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea name="noticeContent" class="form-control"></textarea>
							</td>
						</tr>
					</table>
					<div class="text-right">
						<button type="submit" class="btn btn-warning">수정</button>				
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>