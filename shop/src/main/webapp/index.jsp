<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.*"%>
<%@page import = "service.GoodsService" %>
<%
// Controller: java class <- Servlet

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

GoodsService goodsService = new GoodsService();
List<Map<String, Object>> goodsList = null; // 상품 리스트를 받을 변수
String title = null;

// 검색어가 있는지
if(request.getParameter("search") != null){
	String search = request.getParameter("search");
	goodsList = goodsService.getGoodsListBySearch(search);
	title = "\""+ search + "\"에 대한 검색 결과";
} else {
	// 검색어가 없으면 전체 상품 리스트
	// parameter: rowPerPage, currentPage, sortBy, categoryId
	// categoryId == 0 -> 전체 상품리스트 출력
	goodsList = goodsService.getCustomerGoodsListByPage(rowPerPage, currentPage, sortBy, 0);
	System.out.println("goodsList.size: " + goodsList.size());
	title = "전체 상품";
}

//페이징
int lastPage = goodsService.getLastPage(rowPerPage, 0);
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
	<title>index</title>
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
	
	<%
	// errorMsg 파라미터가 존재하면 알림창으로 알려줌
	if(request.getParameter("errorMsg") != null){
	%>
		<script>alert("<%=request.getParameter("errorMsg")%>")</script>
	<%
	}
	%>
	
	
	<div class="container">
    <h3 class="h3"><%=title%></h3>
    <!-- for / if 대체 기술: custom tag(JSTL 라이브러리, EL) -->
    <%
    	// TODO 일단 검색어가 없을 때만 정렬, 모아보기
    	if(request.getParameter("search") == null){
    %>
	<div>
		<a href="<%=request.getContextPath()%>/index.jsp?sortBy=popular">인기순</a> <!-- 조회수? -->
		<a href="<%=request.getContextPath()%>/index.jsp?sortBy=sales">판매량순</a> 
		<a href="<%=request.getContextPath()%>/index.jsp?sortBy=lowPrice">낮은가격순</a>
		<a href="<%=request.getContextPath()%>/index.jsp?sortBy=highPrice">높은가격순</a>
		<a href="<%=request.getContextPath()%>/index.jsp?sortBy=new">최신순</a> <!-- 기본값 -->
	</div>
	
	<form action="<%=request.getContextPath()%>/index.jsp" method="get">
		<select name="rowPerPage">
			<%
			if(rowPerPage == 40){
			%>
				<option value="20">20개 씩 보기</option>
				<option value="40" selected>40개 씩 보기</option>
							
			<%
			} else {
			%>
				<option value="20" selected>20개 씩 보기</option>
				<option value="40">40개 씩 보기</option>
			<%
			}
			%>
		</select>
		<button type="submit" class="btn btn-warning">확인</button>
	</form>
	
	<%
    	}
	%>
	
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
    	<%
    	// TODO 일단 검색어가 없을 때만 페이징
    	if(request.getParameter("search") == null){
    	%>
		<div class="container">
			<ul class="pagination">
				<%
				// 이전 페이징
				if(pageBegin > rowPerPage){
				%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=pageBegin - rowPerPage%>&rowPerPage=<%=rowPerPage%>&sortBy=<%=sortBy%>">이전</a></li>
				<%
				}
				
				// 숫자 페이징
				for(int i = pageBegin; i <= pageEnd; i++){
				%>			
				  <li class="page-item">
				  	<a class="page-link" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=i%>&rowPerPage=<%=rowPerPage%>&sortBy=<%=sortBy%>">
				  		<%=i%>
				  	</a>
				  </li>
			  	<%
				}
				
				// 다음 페이징
				if(pageEnd < lastPage){
				%>
				  	<li class="page-item">
					  	<a class="page-link" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=pageBegin + rowPerPage%>&rowPerPage=<%=rowPerPage%>&sortBy=<%=sortBy%>">
					  		다음
					  	</a>
				  	</li>
				<%
				}
				%>
			</ul>
		</div>
		<%
    	}
		%>
	</div>
</body>
</html>