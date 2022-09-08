<%@page import="java.text.NumberFormat"%>
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

<!-- for review -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
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
						<%
						 NumberFormat nf = NumberFormat.getCurrencyInstance( Locale.KOREA );
						%>
						<td><%=nf.format(goods.get("goodsPrice"))%></td>
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
					<!-- <div class="container text-right"> -->
						<div class="text-right"> <!-- 바로주문 -->
							<form action="<%=request.getContextPath()%>/order/addOrderForm.jsp" method="post">
								<input type="hidden" name="goodsNo" value="<%=goods.get("goodsNo")%>">
								<input type="hidden" name="goodsName" value="<%=goods.get("goodsName")%>">
								<input type="hidden" name="goodsPrice" value="<%=goods.get("goodsPrice")%>">
								<button type="button" id="plusBtn" class="btn btn-light">+</button>
								<input type="text" name="orderQuantity" id="orderQuantity" value="" readonly>
								<button type="button" id="minusBtn" class="btn btn-light">-</button>
								<button type="submit" class="btn btn-warning">바로 주문</button>
							</form>
						</div>
						<div class="text-right"><!-- 장바구니 -->
							<form action="<%=request.getContextPath()%>/cart/addCartAction.jsp" method="post">
								<input type="hidden" name="goodsNo" value="<%=goods.get("goodsNo")%>">
								<button type="button" id="cartPlusBtn" class="btn btn-light">+</button>
								<input type="text" name="goodsQuantity" id="goodsQuantity" value="" readonly>
								<button type="button" id="cartMinusBtn" class="btn btn-light">-</button>
								<button type="submit" class="btn btn-warning">장바구니</button>
							</form>
						</div>
					<!-- </div> -->
				<%
					}
				%>
			</div><!-- end for col7 -->
		</div><!-- end for row -->
		
		<!------------------------ 코멘트 --------------------->
	
		<div class="row"><!--  -->
			<div class="col-sm-5 text-center">
				<div class="rating-block">
					<h4>Average user rating</h4><!-- 평균 별점 -->
					<h2 class="bold padding-bottom-7">4.3 <small>/ 5</small></h2>
					<button type="button" class="btn btn-warning btn-sm" aria-label="Left Align">
					  <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
					</button>
					<button type="button" class="btn btn-warning btn-sm" aria-label="Left Align">
					  <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
					</button>
					<button type="button" class="btn btn-warning btn-sm" aria-label="Left Align">
					  <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
					</button>
					<button type="button" class="btn btn-default btn-grey btn-sm" aria-label="Left Align">
					  <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
					</button>
					<button type="button" class="btn btn-default btn-grey btn-sm" aria-label="Left Align">
					  <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
					</button>
				</div>
			</div>
			<div class="col-sm-5">
				<h4>Rating breakdown</h4> <!-- 별점 별 통계 -->
				<div class="pull-left">
					<div class="pull-left" style="width:35px; line-height:1;">
						<div style="height:9px; margin:5px 0;">5 <span class="glyphicon glyphicon-star"></span></div>
					</div>
					<div class="pull-left" style="width:180px;">
						<div class="progress" style="height:9px; margin:8px 0;">
						  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="5" aria-valuemin="0" aria-valuemax="5" style="width: 1000%">
							<span class="sr-only">80% Complete (danger)</span>
						  </div>
						</div>
					</div>
					<div class="pull-right" style="margin-left:10px;">1</div>
				</div>
				<div class="pull-left">
					<div class="pull-left" style="width:35px; line-height:1;">
						<div style="height:9px; margin:5px 0;">4 <span class="glyphicon glyphicon-star"></span></div>
					</div>
					<div class="pull-left" style="width:180px;">
						<div class="progress" style="height:9px; margin:8px 0;">
						  <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="5" style="width: 80%">
							<span class="sr-only">80% Complete (danger)</span>
						  </div>
						</div>
					</div>
					<div class="pull-right" style="margin-left:10px;">1</div>
				</div>
				<div class="pull-left">
					<div class="pull-left" style="width:35px; line-height:1;">
						<div style="height:9px; margin:5px 0;">3 <span class="glyphicon glyphicon-star"></span></div>
					</div>
					<div class="pull-left" style="width:180px;">
						<div class="progress" style="height:9px; margin:8px 0;">
						  <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="3" aria-valuemin="0" aria-valuemax="5" style="width: 60%">
							<span class="sr-only">80% Complete (danger)</span>
						  </div>
						</div>
					</div>
					<div class="pull-right" style="margin-left:10px;">0</div>
				</div>
				<div class="pull-left">
					<div class="pull-left" style="width:35px; line-height:1;">
						<div style="height:9px; margin:5px 0;">2 <span class="glyphicon glyphicon-star"></span></div>
					</div>
					<div class="pull-left" style="width:180px;">
						<div class="progress" style="height:9px; margin:8px 0;">
						  <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="5" style="width: 40%">
							<span class="sr-only">80% Complete (danger)</span>
						  </div>
						</div>
					</div>
					<div class="pull-right" style="margin-left:10px;">0</div>
				</div>
				<div class="pull-left">
					<div class="pull-left" style="width:35px; line-height:1;">
						<div style="height:9px; margin:5px 0;">1 <span class="glyphicon glyphicon-star"></span></div>
					</div>
					<div class="pull-left" style="width:180px;">
						<div class="progress" style="height:9px; margin:8px 0;">
						  <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="1" aria-valuemin="0" aria-valuemax="5" style="width: 20%">
							<span class="sr-only">80% Complete (danger)</span>
						  </div>
						</div>
					</div>
					<div class="pull-right" style="margin-left:10px;">0</div>
				</div>
			</div>			
		</div>			
		
		<!-- 리뷰 컨텐츠 -->
		<div class="row">
			<div class="col-sm-12">
				<hr/>
				<div class="review-block">
					<div class="row">
						<div class="col-sm-3">
							<div class="review-block-name"><a href="#">nktailor</a></div>
							<div class="review-block-date">January 29, 2016<br/>1 day ago</div>
						</div>
						<div class="col-sm-9">
							<div class="review-block-rate">
								<button type="button" class="btn btn-warning btn-xs" aria-label="Left Align">
								  <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
								</button>
								<button type="button" class="btn btn-warning btn-xs" aria-label="Left Align">
								  <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
								</button>
								<button type="button" class="btn btn-warning btn-xs" aria-label="Left Align">
								  <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
								</button>
								<button type="button" class="btn btn-default btn-grey btn-xs" aria-label="Left Align">
								  <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
								</button>
								<button type="button" class="btn btn-default btn-grey btn-xs" aria-label="Left Align">
								  <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
								</button>
							</div>
							<div class="review-block-title">this was nice in buy</div>
							<div class="review-block-description">this was nice in buy. this was nice in buy. this was nice in buy. this was nice in buy this was nice in buy this was nice in buy this was nice in buy this was nice in buy</div>
						</div>
					</div>
					<hr/>
					
					</div><!-- review block -->
				</div>
			</div>
	</div><!-- end for 1st container -->


	    <!-- Bootstrap core JavaScript
	    ================================================== -->
	    <!-- Placed at the end of the document so the pages load faster -->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	    <script>window.jQuery || document.write('<script src="assets/js/vendor/jquery.min.js"><\/script>')</script>
	    <script src="js/bootstrap.min.js"></script>
	    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	    <script src="js/ie10-viewport-bug-workaround.js"></script>
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