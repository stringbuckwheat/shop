<%@page import="java.util.Map"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
System.out.println("-------------------- orderDetail.jsp");

// 세션 유효성 검사 -> 로그인 여부
if(session.getAttribute("id") == null){
	response.sendRedirect(request.getContextPath() + "/customerLoginForm.jsp?errorMsg=login needed");
	return;
}

int orderNo = Integer.parseInt(request.getParameter("orderNo"));

OrdersService ordersService = new OrdersService();
Map<String, Object> order = ordersService.getOrderDetail(orderNo);
String sessionId = (String)session.getAttribute("id");
System.out.println("session id: " + sessionId);
System.out.println(order);

// 세션에 저장된 id와 주문 정보의 id를 비교하여, 주문 당사자 일때만 주문정보 확인 가능
if(!(sessionId.equals(order.get("customerId")))){
	System.out.println("session id != order id");

	response.sendRedirect(request.getContextPath() + "/customerGoodsList.jsp?errorMsg=no authority");
	return;
}

// 디버깅
System.out.println(order);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Insert title here</title>
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
		<div class="row">
		    <div class="col-md-10 col-md-offset-1 custyle">
				<table class="table table-striped custab">
					<%for(Map.Entry<String, Object> data : order.entrySet()){%>
					<tr>
						<th><%=data.getKey()%></th>
						<td><%=data.getValue()%></td>
					</tr>
					<%}%>					
				</table>
			
				<div class="text-right">
					<a href="<%=request.getContextPath()%>/order/removeOrderAction.jsp?orderNo=<%=orderNo%>" class="btn btn-warning">주문취소</a>			
				</div>
			</div>		
		</div>
	</div>
</body>
</html>