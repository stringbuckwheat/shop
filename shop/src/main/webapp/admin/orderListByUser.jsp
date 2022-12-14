<%@page import="java.util.*"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 세션 유효성 검사
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){	
	// customer로 로그인한 사람은 loginForm -> index 
	response.sendRedirect(request.getContextPath() + "/login/employeeLoginForm.jsp?errorMsg=no authority");
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
	<div class="container">
	    <div class="row col-md-12 col-md-offset-1 custyle">
		    <h1><%=customerId%>님의 주문</h1>
			<table class="table table-striped custab">
			    <thead>
			    	<tr>
				    	<%for(String title : orderList.get(0).keySet()){%>
					    	<th><%=title%></th>
				    	<%}%>
			    	</tr>
			    </thead>
			    <tbody>
			    	<%for(Map<String, Object> m : orderList){%>
						<tr>
							<%for(Object data : m.values()){%>
								<td><%=data%></td>
							<%}%>
						</tr>
						<%}%>
			    </tbody>
			</table>
		</div>
	</div>	  
</body>
</html>