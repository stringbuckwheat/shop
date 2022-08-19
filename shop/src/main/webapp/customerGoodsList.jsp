<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.GoodsService" %>
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
List<Map<String, Object>> customerGoodsList = goodsService.getCustomerGoodsListByPage(rowPerPage, currentPage, sortBy);

System.out.println("jsp: " + customerGoodsList);
System.out.println("customerGoodsList.size: " + customerGoodsList.size());
// 분리하면 servlet / 연결기술 forward(request, response) - include와 비슷 / jsp

int lastPage = goodsService.getLastPage(rowPerPage);
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
	<!-- for / if 대체 기술: custom tag(JSTL 라이브러리, EL) -->
	<div>
		<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?sortBy=popular">인기순</a> <!-- 조회수? -->
		<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?sortBy=sales">판매량순</a> 
		<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?sortBy=lowPrice">낮은가격순</a>
		<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?sortBy=highPrice">높은가격순</a>
		<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?sortBy=new">최신순</a> <!-- 기본값 -->
	</div>
	
	<form action="<%=request.getContextPath()%>/customerGoodsList.jsp" method="get">
		<select name="rowPerPage">
			<option value="20">20개 씩 보기</option>
			<option value="40">40개 씩 보기</option>
		</select>
		<button type="submit">확인</button>
	</form>
	
	<div class="container">
    <h3 class="h3">shopping Demo-2 </h3>
    <div class="row">
    	<!-- 카드 -->
    	
		<%	
		for(Map<String, Object> m : customerGoodsList){
		%>
    	
        <div class="col-md-3 col-sm-6">
            <div class="product-grid2">
                <div class="product-image2">
                    <a href="#">
                        <img class="pic-1" src="<%=request.getContextPath()%>/upload/<%=m.get("filename")%>">
                        <img class="pic-2" src="<%=request.getContextPath()%>/upload/<%=m.get("filename")%>">
                    </a>
                    <a class="add-to-cart" href="#">Add to cart</a>
                </div>
                <div class="product-content">
                    <h3 class="title"><a href="#"><%=m.get("goodsName")%></a></h3>
                    <span class="price"><%=m.get("goodsPrice")%></span>
                </div>
            </div> <!-- for grid2 -->
        </div><!-- for col -->
       <!--end -->
       <%
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
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/customerGoodsList.jsp?currentPage=<%=pageBegin - rowPerPage%>&rowPerPage=<%=rowPerPage%>&sortBy=<%=sortBy%>">이전</a></li>
				<%
				}
				
				// 숫자 페이징
				for(int i = pageBegin; i <= pageEnd; i++){
				%>			
				  <li class="page-item">
				  	<a class="page-link" href="<%=request.getContextPath()%>/customerGoodsList.jsp?currentPage=<%=i%>&rowPerPage=<%=rowPerPage%>&sortBy=<%=sortBy%>">
				  		<%=i%>
				  	</a>
				  </li>
			  	<%
				}
				
				// 다음 페이징
				if(pageEnd < lastPage){
				%>
				  	<li class="page-item">
					  	<a class="page-link" href="<%=request.getContextPath()%>/customerGoodsList.jsp?currentPage=<%=pageBegin + rowPerPage%>&rowPerPage=<%=rowPerPage%>&sortBy=<%=sortBy%>">
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