<%@page import="service.NoticeService"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//세션 유효성 검사
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	response.sendRedirect(request.getContextPath() + "/employeeLoginForm.jsp?errorMsg=login needed");
	return;
}

request.setCharacterEncoding("utf-8");

int noticeNo = Integer.parseInt(request.getParameter("no"));
String noticeTitle = request.getParameter("noticeTitle");
String noticeContent = request.getParameter("noticeContent");

Notice notice = new Notice();
notice.setNoticeNo(noticeNo);
notice.setNoticeTitle(noticeTitle);
notice.setNoticeContent(noticeContent);

NoticeService noticeService = new NoticeService();
int result = noticeService.modifyNotice(notice);

if(result == 0){
	System.out.println("공지 수정 실패!");
}

response.sendRedirect(request.getContextPath() + "/notice/noticeOne.jsp?no=" + noticeNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>