<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.*"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
System.out.println("-------------------- searchGoods.jsp");
String search = request.getParameter("search");

GoodsService goodsService = new GoodsService();
List<Map<String, Object>> goodsList = goodsService.getGoodsListBySearch(search);
%>


<!-- VIEW: 태그 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>customerGoodsList</title>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<link href="<%=request.getContextPath()%>/css/loginForm.css" rel="stylesheet">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/goodsList.css">
</head>
<body>
	<%@include file="/header.jsp"%>
	
	<div class="container">
    <h3 class="h3"><%=search%>의 검색 결과</h3>
    
    <!-- 카테고리 별 인기상품이 들어갈 자리 -->
    
	<div>
		<a href="#">인기순</a> <!-- 조회수? -->
		<a href="#">판매량순</a> 
		<a href="#">낮은가격순</a>
		<a href="#">높은가격순</a>
		<a href="#">최신순</a> <!-- 기본값 -->
	</div>
	
    <div class="row">
    	<!-- 카드 -->
    	
		<%
		for(int i = 0; i < goodsList.size(); i++){
			Map<String, Object> m = goodsList.get(i);
		%>
    	
        <div class="col-md-3 col-sm-6">
            <div class="product-grid2">
                <div class="product-image2">
                    <a href="<%=request.getContextPath()%>/goods/goodsAndImgOne.jsp?goodsNo=<%=m.get("goodsNo")%>">
                        <img class="pic-1" src="<%=request.getContextPath()%>/upload/<%=m.get("filename")%>">
                        <img class="pic-2" src="<%=request.getContextPath()%>/upload/<%=m.get("filename")%>">
                    </a>
                    <% 
                    if(m.get("soldOut").equals("N")){ // 주문 가능한 경우
                    %>
	                    <a class="add-to-cart" href="<%=request.getContextPath()%>/cart/addCartAction.jsp?goodsNo=<%=m.get("goodsNo")%>">
	                    	Add to cart
	                    </a>
                    <%
                    } else { // 품절 상품인 경우
                    %>
                    	<a class="add-to-cart">
	                    	품절 상품입니다
	                    </a>
                    <%
                    }
                    
            		// 12345로 저장된 가격을 ￦12,345로 표시하기 위해
                    NumberFormat nf = NumberFormat.getCurrencyInstance( Locale.KOREA );
                    %>
                </div>
                <div class="product-content">
                    <h3 class="title"><a href="<%=request.getContextPath()%>/goods/goodsAndImgOne.jsp?goodsNo=<%=m.get("goodsNo")%>"><%=m.get("goodsName")%></a></h3>
                    <span class="price"><%=nf.format(m.get("goodsPrice"))%></span>
                </div>
            </div> <!-- for grid2 -->
        </div><!-- for col -->
       <!--end -->
       <%
       		if(i % 4 == 3) {
       			%>
       			   </div><div class="row">
       			<%
       		}
		}
       %>
       <!-- here -->
    </div>
	</div>
</body>
</html>
