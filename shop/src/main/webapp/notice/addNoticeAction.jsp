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

String noticeTitle = request.getParameter("noticeTitle");
String noticeContent = request.getParameter("noticeContent");

Notice notice = new Notice();
notice.setNoticeTitle(noticeTitle);
notice.setNoticeContent(noticeContent);
System.out.println(notice);

NoticeService noticeService = new NoticeService();
int noticeNo = noticeService.addNotice(notice);

if(noticeNo == 0){
	System.out.println("공지 삽입 실패");
	response.sendRedirect(request.getContextPath() + "/notice/noticeList.jsp?errorMsg=insert error");
	return;
}

System.out.println("공지 삽입 성공");
response.sendRedirect(request.getContextPath() + "/notice/noticeOne.jsp?no=" + noticeNo);
%>