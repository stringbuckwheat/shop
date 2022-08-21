<%@page import="service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
int noticeNo = Integer.parseInt(request.getParameter("no"));

NoticeService noticeService = new NoticeService();
noticeService.removeNotice(noticeNo);

response.sendRedirect(request.getContextPath() + "/notice/noticeList.jsp");
%>