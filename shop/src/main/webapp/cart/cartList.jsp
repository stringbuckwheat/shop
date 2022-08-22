<%@page import="service.CartService"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

if(session.getAttribute("id") == null || session.getAttribute("user").equals("Employee")){	
	// customer로 로그인한 사람은 loginForm -> index 
	response.sendRedirect(request.getContextPath() + "/employeeLoginForm.jsp?errorMsg=no authority");
	return;
}

String id = (String)session.getAttribute("id");

CartService cartService = new CartService();
List<Map<String, Object>> cartList = cartService.getCartList(id);
System.out.println(cartList);

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>CART</title>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<link href="<%=request.getContextPath()%>/css/loginForm.css" rel="stylesheet">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	
	<div class="container">
		<h2>CART</h2>
	    <div class="row col-md-12 col-md-offset-1 custyle">
		<table class="table table-striped custab">
		    <thead>
				<tr>
					<th>상품명</th>
					<th>수량</th>
					<th>가격</th>
					<th>*</th>
				</tr>
			</thead>
			
			<%
			int totalPrice = 0; // 총 금액을 계산할 변수
			
			for(Map<String, Object> c : cartList){
				// 제품별 금액 = 상품 가격 * 주문 개수
				int itemPrice = (int)c.get("cartQuantity") * (int)c.get("goodsPrice");
				totalPrice += itemPrice;
			%>
				<tr>
					<td>
						<a href="<%=request.getContextPath()%>/goodsAndImgOne.jsp?goodsNo=<%=c.get("goodsNo")%>">
							<%=c.get("goodsName")%>
						</a>
					</td>
					<td>
						<form action="<%=request.getContextPath()%>/cart/modifyCartAction.jsp" method="post">
							<input type="hidden" name="goodsNo" value="<%=c.get("goodsNo")%>">
							<input type="number" name="cartQuantity" id="cartQuantity" value="<%=c.get("cartQuantity")%>">
							<button type="submit" class="btn btn-warning">수정</button>
						</form>
					</td>
					<td>
						<input type="number" name="goodsPrice" id="totalPrice" value="<%=itemPrice%>" readonly>
					</td>
					<td>
						<a href="<%=request.getContextPath()%>/cart/removeCartAction.jsp?goodsNo=<%=c.get("goodsNo")%>" class="btn btn-info">
							삭제
						</a>
					</td>
				</tr>
			<%
				}
			%>
		</table>
		<div class="container text-right">
			<input type="number" name="totalPrice" id="totalPrice" value="<%=totalPrice%>" readonly>			
			<a href="<%=request.getContextPath()%>/order/orderAllForm.jsp" class="btn btn-warning">전체 주문하기</a>
		</div>
	</div>
</div>

</body>
</html>