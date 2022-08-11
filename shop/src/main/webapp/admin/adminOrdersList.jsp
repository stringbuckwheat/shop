<%@page import="java.util.*"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 세션 유효성 검사
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){	
	// customer로 로그인한 사람은 loginForm -> index 
	response.sendRedirect(request.getContextPath() + "/employeeLoginForm.jsp?errorMsg=no authority");
	return;
}

int currentPage = 1;

if(request.getParameter("currentPage") != null){
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

final int rowPerPage = 10; // 페이지 당 출력할 글 개수

OrdersService ordersService = new OrdersService();
List<Map<String, Object>> orderList = ordersService.getOrderListByPage(rowPerPage, currentPage);

int lastPage = ordersService.getLastPage(rowPerPage);
int pageBegin = ((currentPage - 1) / rowPerPage) * rowPerPage + 1; // 페이지 시작 넘버
int pageEnd = pageBegin + rowPerPage - 1; // 페이지 끝 글 구하는 공식
pageEnd = Math.min(pageEnd, lastPage); // 둘 중에 작은 값이 pageEnd

Set<String> titleSet = orderList.get(0).keySet();
System.out.println(titleSet);
// [order_no, goods_no, order_quantity, order_address, order_price, customer_id, create_date, order_state, update_date]

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>orders list</title>
	<link rel="stylesheet" href="../css/style.css">
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
			<table class="table table-striped custab">
				<thead>
			    	<tr>
				    	<%for(String title : titleSet){%>	
					    <th><%=title%></th><!-- 나중에 <a> 붙여서 정렬 -->
				    	<%}%>
			    	</tr>
			    </thead>
			    <tbody>
			    	<%
					// list 안 에 들어있는 Map의 value를 순회...
					for(Map<String, Object> m : orderList){
					%>
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