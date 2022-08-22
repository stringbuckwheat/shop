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

/* Set<String> titleSet = orderList.get(0).keySet();
System.out.println(titleSet); */
// [orderAddress, updateDate, orderNo, customerId, orderPrice, goodsName, customerName, orderQuantity, orderState, createDate]

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>orders list</title>
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
				<thead>
			    	<tr>
			    		<th>주문 번호</th>
			    		<th>이름(ID)</th>
			    		<th>상품명</th>
			    		<th>수량</th>
			    		<th>가격</th>
			    		<th>배송상태</th>
			    		<th>배송상태 수정</th>
					    <th>수정 일자</th>
					    <th>주문 일자</th>
			    	</tr>
			    </thead>
			    <tbody>
			    	<% 
			    	for(Map<String, Object> m : orderList){
			    	%>
					<tr>
						<td><%=m.get("orderNo")%></td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/orderListByUser.jsp?customerId=<%=m.get("customerId")%>">
								<%=m.get("customerName")%>(<%=m.get("customerId")%>)
							</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/admin/orderDetail.jsp?orderNo=<%=m.get("orderNo")%>">
								<%=m.get("goodsName")%>
							</a>
						</td>
						<td><%=m.get("orderQuantity")%></td>
						<td><%=m.get("orderPrice")%></td>
						<td><%=m.get("orderState")%></td>
						<td>
						
							<form action="<%=request.getContextPath()%>/admin/modifyOrderStateAction.jsp" method="post">
								<input type="hidden" name="orderNo" value="<%=m.get("orderNo")%>">
								<input type="hidden" name="preOrderState" value="<%=m.get("orderState")%>">
								<input type="hidden" name="currentPage" value="<%=currentPage%>">
						        <select name="orderState">
									<!--  DB에 저장된 값은 selected, 맨 위로 올림 -->
									<option value="<%=m.get("orderState")%>" selected=“selected”><%=m.get("orderState")%></option>
									
									<%
									// 주문 단계를 저장해놓은 배열	
									String[] orderState = {"주문완료", "상품준비중", "배송중", "배송완료", "취소"};
									
									for(String s : orderState){
										// DB에 저장된 값을 위에서 selected로 처리했으니
										// 실제 주문 단계와 같은 값이면 continue
										if(s.equals(m.get("orderState"))){
											continue;
										}
										%>
										
										<option value="<%=s%>"><%=s%></option>
										
									<%
									}
									%>
										
								</select>
								<button type="submit" class='btn btn-info btn-xs'>수정</button>
							</form>
						</td>
						<td><%=m.get("updateDate")%></td>
						<td><%=m.get("createDate")%></td>
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