<%@page import="java.util.Map"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
int orderNo = Integer.parseInt(request.getParameter("orderNo"));

OrdersService ordersService = new OrdersService();
Map<String, Object> order = ordersService.getOrderDetail(orderNo);
String sessionId = (String)session.getAttribute("id");

// 관리자 혹은 본인만 배송 상세페이지 확인 가능
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee")) || !(sessionId.equals(order.get("customerId")))){
	response.sendRedirect(request.getContextPath() + "/login/employeeLoginForm.jsp?errorMsg=no authority");
	return;
}

System.out.println(order);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Order Detail</title>
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
			<table class="table table-striped custab">
				<%for(Map.Entry<String, Object> data : order.entrySet()){%>
				<tr>
					<th><%=data.getKey()%></th>
					<td><%=data.getValue()%></td>
				</tr>
				<%}%>					
			</table>
		</div>
	</div>
</body>
</html>