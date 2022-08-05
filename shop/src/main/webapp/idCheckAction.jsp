<%@page import="service.SignService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String inputId = request.getParameter("inputId");
String membership = request.getParameter("membership"); // redirect을 처리할 변수
System.out.println(inputId);
System.out.println(membership);

SignService signService = new SignService();
boolean result = signService.checkId(inputId); // public boolean checkId(String id)

if(!result){ // return false
	// membership 변수를 사용해 직원 회원가입 혹은 일반 회원가입 폼으로 이동 
	response.sendRedirect(request.getContextPath() + "/add" + membership + "Form.jsp?errorMsg=invalidId");
	return;
}

response.sendRedirect(request.getContextPath() + "/add" + membership + "Form.jsp?inputId=" + inputId);
%>