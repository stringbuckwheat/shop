<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.*"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

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
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<style>
.center{
width: 150px;
  margin: 40px auto;
  
}
</style>
</head>
<body>
	<%@include file="/header.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-5 custyle">
				<img src="<%=request.getContextPath()%>/upload/<%=goods.get("originFilename")%>" width="300" height="330">
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
					if(goods.get("soldOut").equals("N") && session.getAttribute("id") != null && session.getAttribute("user").equals("Customer")){
				%>
					<div class="container text-right">
						<div>
							<form action="<%=request.getContextPath()%>/order/addOrderForm.jsp" method="post">
								<input type="hidden" name="goodsNo" value="<%=goods.get("goodsNo")%>">
								<input type="hidden" name="goodsName" value="<%=goods.get("goodsName")%>">
								<input type="hidden" name="goodsPrice" value="<%=goods.get("goodsPrice")%>">
								<div>
									<button type="button" id="plusBtn" class="btn btn-light">+</button>
									<input type="text" name="orderQuantity" id="orderQuantity" value="" readonly>
									<button type="button" id="minusBtn" class="btn btn-light">-</button>
								</div>
								<button type="submit" class="btn btn-warning">바로 주문</button>
							</form>
						</div>
						<div>
							<form action="<%=request.getContextPath()%>/cart/addCartAction.jsp" method="post">
								<input type="hidden" name="goodsNo" value="<%=goods.get("goodsNo")%>">
								<div>
									<button type="button" id="cartPlusBtn" class="btn btn-light">+</button>
									<input type="text" name="goodsQuantity" id="goodsQuantity" value="" readonly>
									<button type="button" id="cartMinusBtn" class="btn btn-light">-</button>
								</div>
								<button type="submit" class="btn btn-warning">장바구니</button>
							</form>
						</div>
					</div>
				<%
					}
				%>
			</div>
		</div>
	</div>
</body>
<script>
$(function(){
	$('#orderQuantity').val(1);
	
	$('#plusBtn').click(function(){
		$('#orderQuantity').val(parseInt($('#orderQuantity').val())+1);
	});
	$('#minusBtn').click(function(){
		if ($('#orderQuantity').val() == 1){
			$('#orderQuantity').val($('#orderQuantity').val());
			return;
		}
		$('#orderQuantity').val($('#orderQuantity').val()-1);
	});
});

$(function(){
	$('#goodsQuantity').val(1);
	
	$('#cartPlusBtn').click(function(){
		$('#goodsQuantity').val(parseInt($('#goodsQuantity').val())+1);
	});
	
	$('#cartMinusBtn').click(function(){
		if ($('#goodsQuantity').val() == 1){
			$('#goodsQuantity').val($('#goodsQuantity').val());
			return;
		}
		$('#goodsQuantity').val($('#goodsQuantity').val()-1);
	});
});
</script>

</html>