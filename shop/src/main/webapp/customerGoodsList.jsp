<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.GoodsService" %>
<%
// Controller: java class <- Servlet

int rowPerPage = 20;

if(request.getParameter("rowPerPage") != null){
	rowPerPage = Integer.parseInt(request.getParameter("rowPerPage")); // 20개씩 보기, 30개씩 보기
}

int currentPage = 1;
if(request.getParameter("currentPage") != null){
	currentPage =  Integer.parseInt(request.getParameter("currentPage"));
}

GoodsService goodsService = new GoodsService();
List<Map<String, Object>> customerGoodsList = goodsService.getCustomerGoodsListByPage(rowPerPage, currentPage);

System.out.println(customerGoodsList);

// 분리하면 servlet / 연결기술 forward(request, response) - include와 비슷 / jsp
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
	<!-- for / if 대체 기술: custom tag(JSTL 라이브러리, EL) -->
	<div>
		<a href="">인기순</a> <!-- 조회수? -->
		<a href="">판매량순</a> <!-- default 메소드 값 -->
		<a href="">낮은가격순</a>
		<a href="">높은가격순</a>
		<a href="">최신순</a>
	</div>
	<table>
		<tr>
			<%
				int i = 1;
			
				for(Map<String, Object> m : customerGoodsList){
					%>
					<td>
						<div>
							<a href="#"><!-- 상세 페이지 -->
								<img src='<%=request.getContextPath()%>/upload/<%=m.get("filename")%>' width="200" height="200">
							</a>
						</div>
						<div><%=m.get("goodsName")%></div>
						<div><%=m.get("goodsPrice")%></div>
						<!-- 리뷰 개수 -->
					</td>
					<%
					if(i%4 == 0){
					%>
		                  </tr><tr>
		            <%
					}
					i++;
				}
				
				int tdCnt = 4 - (customerGoodsList.size() % 4);
				tdCnt %= 4; // 나눠 떨어질 때 처리
				
				for(int j = 0; j<tdCnt; j++){
				%>
		               <td>&nbsp;</td>
		        <%
				}
			%>
		</tr>
	</table>
	
	<div class="container">
    <h3 class="h3">shopping Demo-2 </h3>
    <div class="row">
    	<!-- 카드 -->
    	
		<%
		// int i = 1;
	
		for(Map<String, Object> m : customerGoodsList){
		%>
    	
        <div class="col-md-3 col-sm-6">
            <div class="product-grid2">
                <div class="product-image2">
                    <a href="#">
                        <img class="pic-1" src="<%=request.getContextPath()%>/upload/<%=m.get("filename")%>">
                        <img class="pic-2" src="<%=request.getContextPath()%>/upload/<%=m.get("filename")%>">
                    </a>
                    <ul class="social">
                        <li><a href="#" data-tip="Quick View"><i class="fa fa-eye"></i></a></li>
                        <li><a href="#" data-tip="Add to Wishlist"><i class="fa fa-shopping-bag"></i></a></li>
                        <li><a href="#" data-tip="Add to Cart"><i class="fa fa-shopping-cart"></i></a></li>
                    </ul>
                    <a class="add-to-cart" href="">Add to cart</a>
                </div>
                <div class="product-content">
                    <h3 class="title"><a href="#"><%=m.get("goodsName")%></a></h3>
                    <span class="price"><%=m.get("goodsPrice")%></span>
                </div>
            </div>
        </div>
       <!--end -->
       <%
		}
       %>
       <!-- here -->
       
    </div>
</div>
<hr>
	
	<!--페이징 + 상품검색 -->
</body>
</html>