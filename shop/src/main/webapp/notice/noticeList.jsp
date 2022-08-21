<%@page import="vo.Notice"%>
<%@page import="java.util.List"%>
<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 세션 유효성 검사X -> 비회원도 열람 가능
int currentPage = 1;

if(request.getParameter("currentPage") != null){
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

final int rowPerPage = 10; // 페이지 당 출력할 글 개수

NoticeService noticeService = new NoticeService();
List<Notice> noticeList = noticeService.getNoticeList(rowPerPage, currentPage);

int lastPage = noticeService.getLastPage(rowPerPage);
int pageBegin = ((currentPage - 1) / rowPerPage) * rowPerPage + 1; // 페이지 시작 넘버
int pageEnd = pageBegin + rowPerPage - 1; // 페이지 끝 글 구하는 공식
pageEnd = Math.min(pageEnd, lastPage); // 둘 중에 작은 값이 pageEnd
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
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
	    <div class="row col-md-8 col-md-offset-2 custyle">
	    
		<table class="table table-striped custab">
		    <thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
			</thead>
			
			<%
			for(Notice n : noticeList){
			%>
				<tr>
					<td><%=n.getNoticeNo()%></td>
					<td><a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?no=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
					<td>관리자</td>
					<td><%=n.getCreateDate()%></td>
				</tr>
			<%
				}
			%>
		</table>
		
		<%
		// 관리자 회원에게만 글쓰기 버튼 노출
		if((session.getAttribute("user").equals("Employee"))){
		%>
			<div class="container text-right">
				<a href="<%=request.getContextPath()%>/notice/addNoticeForm.jsp" class="btn btn-warning">글쓰기</a>
			</div>
		<%
		}
		%>
		
		<div class="container">
			<ul class="pagination">
				<%	
				// 이전 페이징
				if(pageBegin > rowPerPage){
				%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=pageBegin - rowPerPage%>">이전</a></li>
				<%
				}
				// 숫자 페이징
				for(int i = pageBegin; i <= pageEnd; i++){
				%>			
				  <li class="page-item">
				  	<a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=i%>">
				  		<%=i%>
				  	</a>
				  </li>
			  <%
				}
				
				// 다음 페이징
				if(pageEnd < lastPage){
				%>
				  	<li class="page-item">
					  	<a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=pageBegin + rowPerPage%>">
					  		다음
					  	</a>
				  	</li>
				<%
				}
				%>
			</ul>
		</div>
	</div>
</div>
	
</body>
</html>