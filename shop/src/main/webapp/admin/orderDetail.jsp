<%@page import="java.util.Map"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	// customer로 로그인한 사람은 loginForm -> index 
	response.sendRedirect(request.getContextPath() + "/employeeLoginForm.jsp?errorMsg=no authority");
	return;
}

int orderNo = Integer.parseInt(request.getParameter("orderNo"));

//public Map<String, Object> getOrderDetail(String customerId, int orderNo){
OrdersService ordersService = new OrdersService();
Map<String, Object> order = ordersService.getOrderDetail(orderNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
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
		    <h1><%=customerId%>님의 주문</h1>
			<table class="table table-striped custab">
			    <thead>
			    	<tr>
				    	<%
				    	for(String title : order.keySet()){
				    	%>
					    	<th><%=title%></th>
				    	<%
				    	}
				    	%>
			    	</tr>
			    </thead>
			    <tbody>
			    <tr>
			    	<%
					for(Object data : order.values()){
						%>
								<td><%=data%></td>
								<%
							}
							%>
						</tr>
			    </tbody>
			</table>
		</div>
	</div>
</body>
</html>