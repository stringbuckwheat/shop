<%@page import="vo.Notice"%>
<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
int noticeNo = Integer.parseInt(request.getParameter("no"));

NoticeService noticeService = new NoticeService();
Notice notice = noticeService.getNoticeOne(noticeNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>notice one</title>
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
	    <div class="row col-md-8 col-md-offset-1 custyle">
			<table class="table table-striped custab">

				<tr>
					<th>제목</th>
					<td><%=notice.getNoticeTitle()%></td>
				</tr>				
				<tr>
					<th>번호</th>
					<td><%=notice.getNoticeNo()%></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td><%=notice.getCreateDate()%></td>
				</tr>
				<tr>
					<th>수정일자</th>
					<td><%=notice.getUpdateDate()%></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><%=notice.getNoticeContent()%></td>
				</tr>
			</table>
			<div class="container text-right">
				<%
				if((session.getAttribute("user").equals("Employee"))){
				%>
					<a href="<%=request.getContextPath()%>/notice/modifyNoticeForm.jsp?no=<%=notice.getNoticeNo()%>" class="btn btn-warning">수정</a>
					<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?no=<%=notice.getNoticeNo()%>" class="btn btn-warning">삭제</a>
				<% 
				} 
				%>
				<a href="<%=request.getContextPath()%>/notice/noticeList.jsp" class="btn btn-warning">목록으로</a>
			</div>
		</div>
	</div>

</body>
</html>