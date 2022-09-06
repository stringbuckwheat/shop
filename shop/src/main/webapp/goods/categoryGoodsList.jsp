<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.GoodsService" %>
<%
//////////////////////// 카테고리 별 goodsList

// 파라미터 받아오기
int rowPerPage = 20;

String sortBy = "new"; // default값 최신순
if(request.getParameter("sortBy") != null){
	sortBy = request.getParameter("sortBy"); // 20개씩 보기, 30개씩 보기
}

if(request.getParameter("rowPerPage") != null){
	rowPerPage = Integer.parseInt(request.getParameter("rowPerPage")); // 20개씩 보기, 30개씩 보기
}

int currentPage = 1;
if(request.getParameter("currentPage") != null){
	currentPage =  Integer.parseInt(request.getParameter("currentPage"));
}

int categoryId = 0;
if(request.getParameter("categoryId") != null){
	categoryId = Integer.parseInt(request.getParameter("categoryId"));
}

// 카테고리 이름 띄우기
// 파라미터로 받아온 categoryId를 사용해 해당 카테고리의 이름을 가져온다
CategoryService categoryService = new CategoryService();
String categoryName = categoryService.getCategoryNameOne(categoryId);

// 해당 카테고리의 모든 상품 리스트를 가져온다
GoodsService goodsService = new GoodsService();
List<Map<String, Object>> goodsList = goodsService.getCustomerGoodsListByPage(rowPerPage, currentPage, sortBy, categoryId);

System.out.println("jsp: " + goodsList);
System.out.println("goodsList.size: " + goodsList.size());

// 페이징
int lastPage = goodsService.getLastPage(rowPerPage, categoryId);
int pageBegin = ((currentPage - 1) / rowPerPage) * rowPerPage + 1; // 페이지 시작 넘버
int pageEnd = pageBegin + rowPerPage - 1; // 페이지 끝 글 구하는 공식
pageEnd = Math.min(pageEnd, lastPage); // 둘 중에 작은 값이 pageEnd
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
    <h3 class="h3"><%=categoryName%></h3>
    
    <!-- 카테고리 별 인기상품이 들어갈 자리 -->
    
	<div>
		<a href="<%=request.getContextPath()%>/goods/categoryGoodsList.jsp?sortBy=popular&categoryId=<%=categoryId%>">인기순</a> <!-- 조회수? -->
		<a href="<%=request.getContextPath()%>/goods/categoryGoodsList.jsp?sortBy=sales&categoryId=<%=categoryId%>">판매량순</a> 
		<a href="<%=request.getContextPath()%>/goods/categoryGoodsList.jsp?sortBy=lowPrice&categoryId=<%=categoryId%>">낮은가격순</a>
		<a href="<%=request.getContextPath()%>/goods/categoryGoodsList.jsp?sortBy=highPrice&categoryId=<%=categoryId%>">높은가격순</a>
		<a href="<%=request.getContextPath()%>/goods/categoryGoodsList.jsp?sortBy=new&categoryId=<%=categoryId%>">최신순</a> <!-- 기본값 -->
	</div>
	
	<form action="<%=request.getContextPath()%>/index.jsp" method="get">
		<select name="rowPerPage">
			<%
			if(rowPerPage == 40){
			%>
				<option value="20">20개 씩 보기</option>
				<option value="40" selected=“selected”>40개 씩 보기</option>
							
			<%
			} else {
			%>
				<option value="20" selected=“selected”>20개 씩 보기</option>
				<option value="40">40개 씩 보기</option>
			<%
			}
			%>
		</select>
		<button type="submit" class="btn btn-warning">확인</button>
	</form>
	
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

		<div class="container">
			<ul class="pagination">
				<%	
				// 이전 페이징
				if(pageBegin > rowPerPage){
				%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/goods/categoryGoodsList.jsp?currentPage=<%=pageBegin - rowPerPage%>&rowPerPage=<%=rowPerPage%>&sortBy=<%=sortBy%>&categoryId=<%=categoryId%>">이전</a></li>
				<%
				}
				
				// 숫자 페이징
				for(int i = pageBegin; i <= pageEnd; i++){
				%>			
				  <li class="page-item">
				  	<a class="page-link" href="<%=request.getContextPath()%>/goods/categoryGoodsList.jsp?currentPage=<%=i%>&rowPerPage=<%=rowPerPage%>&sortBy=<%=sortBy%>&categoryId=<%=categoryId%>">
				  		<%=i%>
				  	</a>
				  </li>
			  	<%
				}
				
				// 다음 페이징
				if(pageEnd < lastPage){
				%>
				  	<li class="page-item">
					  	<a class="page-link" href="<%=request.getContextPath()%>/goods/categoryGoodsList.jsp?currentPage=<%=pageBegin + rowPerPage%>&rowPerPage=<%=rowPerPage%>&sortBy=<%=sortBy%>&categoryId=<%=categoryId%>">
					  		다음
					  	</a>
				  	</li>
				<%
				}
				%>
		</ul>
	</div>
	</div>
</body>
</html>