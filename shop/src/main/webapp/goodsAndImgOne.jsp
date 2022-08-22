<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.*"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 세션 유효성 검사
/* if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	// customer로 로그인한 사람은 loginForm -> index 
	response.sendRedirect(request.getContextPath() + "/employeeLoginForm.jsp?errorMsg=no authority");
	return;
} */

int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

GoodsService goodsService = new GoodsService();
Map<String, Object> goods = goodsService.getGoodsAndImgOne(goodsNo);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>goodsAndImgOne</title>
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
			<div class="col-md-5 custyle">
				<img src="<%=request.getContextPath()%>/upload/<%=goods.get("originFilename")%>"  width="300" height="330">
			</div>
			<div class="col-md-7 custyle">
				<table class="table table-striped custab">
					<tr>
						<th>상품명</th>
						<td><%=goods.get("goodsName")%></td>
					</tr>
					<tr>
						<th>가격</th>
						<td><%=goods.get("goodsPrice")%></td>
					</tr>
					
					<%
					if(goods.get("soldOut").equals("Y")){
					%>
						<tr>
							<th></th>
							<td>품절 상품입니다</td>
						</tr>
					<%
					}
					%>
						
				</table>
				
				<%
					// 품절 X, 일반 회원으로 로그인한 경우에만 구매, 카트에 넣기 가능
					if(goods.get("soldOut").equals("N") || session.getAttribute("id") != null || session.getAttribute("user").equals("Customer")){
				%>
					<div class="container text-right">
						<div>
							<form action="<%=request.getContextPath()%>/order/addOrderForm.jsp" method="post">
								<input type="hidden" name="goodsNo" value="<%=goods.get("goodsNo")%>">
								<input type="hidden" name="goodsName" value="<%=goods.get("goodsName")%>">
								<input type="hidden" name="goodsPrice" value="<%=goods.get("goodsPrice")%>">
								수량: <input type="text" name="orderQuantity">
								<button type="submit">바로 구매</button>
							</form>
						</div>
						<a href="<%=request.getContextPath()%>/cart/addCartAction.jsp" class="btn btn-warning">카트에 담기</a>
					</div>
				<%
					}
				%>
			</div>
		</div>
	</div>
</body>
</html>