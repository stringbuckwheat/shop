<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

//세션 유효성 검사
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	response.sendRedirect(request.getContextPath() + "/employeeLoginForm.jsp?errorMsg=login needed");
	return;
}

int noticeNo = Integer.parseInt(request.getParameter("no"));

NoticeService noticeService = new NoticeService();
noticeService.removeNotice(noticeNo);

response.sendRedirect(request.getContextPath() + "/notice/noticeList.jsp");
%>