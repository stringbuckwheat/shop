<%@page import="service.ReviewService"%>
<%@page import="java.util.*"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// review 디렉토리의 jsp들과 짝꿍

// 세션 유효성 검사
if(session.getAttribute("id") == null){	
	response.sendRedirect(request.getContextPath() + "/login/customerLoginForm.jsp?errorMsg=no authority");
	return;
}

if(session.getAttribute("user").equals("Employee")){
	response.sendRedirect(request.getContextPath() + "/admin/adminOrdersList.jsp");
	return;
}

//List<Map<String, Object>> getOrderById(String customerId, int rowPerPage, int currentPage)
String customerId = request.getParameter("customerId");
System.out.println(customerId);
int currentPage = 1;

if(request.getParameter("currentPage") != null){
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

final int rowPerPage = 10; // 페이지 당 출력할 글 개수

OrdersService ordersService = new OrdersService();
List<Map<String, Object>> orderList = ordersService.getOrderById(customerId, rowPerPage, currentPage);
System.out.println(orderList);

// 리뷰 작성 여부를 검사하기 위해 서비스 객체 생성
ReviewService reviewService = new ReviewService();

int lastPage = ordersService.getLastPage(rowPerPage);
int pageBegin = ((currentPage - 1) / rowPerPage) * rowPerPage + 1; // 페이지 시작 넘버
int pageEnd = pageBegin + rowPerPage - 1; // 페이지 끝 글 구하는 공식
pageEnd = Math.min(pageEnd, lastPage); // 둘 중에 작은 값이 pageEnd

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>orderlist by user</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	
	<%
	// errorMsg 파라미터가 존재하면 알림창으로 알려줌
	if(request.getParameter("errorMsg") != null){
	%>
		<script>alert("<%=request.getParameter("errorMsg")%>")</script>
	<%
	}
	%>
	
	<div class="container">
	    <div class="row col-md-12 col-md-offset-1 custyle">
		    <h1><%=customerId%>님의 주문</h1>
			<table class="table table-striped custab">
			    <thead>
			    	<tr>
				    	<%
				    	for(String title : orderList.get(0).keySet()){
							//TODO 키셋말고 한글로 만들어서 뽑기
				    	%>
					    	<th><%=title%></th>
				    	<%
				    	}
				    	%>
				    	<th>리뷰</th>
			    	</tr>
			    </thead>
			    <tbody>
			    	<%
			    	for(Map<String, Object> m : orderList){
			    	%>
						<tr>
							<%
							for(Object data : m.values()){
							%>
								<td><%=data%></td>
							<%
							}
							
							// 해당 주문번호로 작성된 리뷰가 없으면
							if(!reviewService.getOneReview((Integer)m.get("orderNo"))){
							// review에 필요한 것: order_no, review_content, create_date, update_date, rating
							%>
								<td>
									<a href="<%=request.getContextPath()%>/review/addReviewForm.jsp?orderNo=<%=m.get("orderNo")%>" class='btn btn-info btn-xs'>리뷰 작성</a>
								</td>
							<%
							} else {
							%>
								<td>
									<a href="<%=request.getContextPath()%>/review/modifyReviewForm.jsp?orderNo=<%=m.get("orderNo")%>" class='btn btn-info btn-xs'>수정</a>
									<a href="<%=request.getContextPath()%>/review/deleteReviewAction.jsp?orderNo=<%=m.get("orderNo")%>" class='btn btn-danger btn-xs'>삭제</a>
								</td>
							<%
							}
							%>
						</tr>
						<%
						}
						%>
			    </tbody>
			</table>
		</div>
	</div>	  
</body>
</html>