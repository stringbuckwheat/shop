<%@page import="service.ReviewService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
System.out.println("------------------------- addReviewAction.jsp");

// 인코딩
request.setCharacterEncoding("utf-8");


//세션 유효성 검사
if(session.getAttribute("id") == null || (session.getAttribute("user").equals("Employee"))){
	response.sendRedirect(request.getContextPath() + "/login/customerLoginForm.jsp?errorMsg=login needed");
	return;
}

// 파라미터 받아오기
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
int rating = Integer.parseInt(request.getParameter("rating"));
String reviewContent = request.getParameter("reviewContent");


// vo 세팅
Review review = new Review();
review.setOrderNo(orderNo);
review.setRating(rating);
review.setReviewContent(reviewContent);

System.out.println(review);

// 메소드 호출
ReviewService reviewService = new ReviewService();
// 삽입 메소드의 리턴값에 무관하게 주문리스
String url = request.getContextPath() + "/order/orderListForCustomer.jsp?customerId=" + session.getAttribute("id");

// return boolean
if(!reviewService.addReview(review)){ 
	// 삽입 실패 시 에러메시지 띄움
	response.sendRedirect(url + "&errorMsg=review insert fail");
}

// redirect
response.sendRedirect(url);

%>