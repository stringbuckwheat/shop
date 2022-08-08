<%@page import="vo.Goods"%>
<%@page import="java.util.List"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

//로그인 한 사람만 입장 가능
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

GoodsService goodsService = new GoodsService();
List<Goods> goodsList = goodsService.getGoodsListByPage(rowPerPage, currentPage);

int lastPage = goodsService.getLastPage(rowPerPage);
int pageBegin = ((currentPage - 1) / rowPerPage) * rowPerPage + 1; // 페이지 시작 넘버
int pageEnd = pageBegin + rowPerPage - 1; // 페이지 끝 글 구하는 공식
pageEnd = Math.min(pageEnd, lastPage); // 둘 중에 작은 값이 pageEnd

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>admin goods list</title>
<link rel="stylesheet" href="../css/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<%@include file="../header.jsp"%>
	<div class="container">
	    <div class="row col-md-8 col-md-offset-2 custyle">

	<table class="table table-striped custab">
	    <thead>
			<tr>
				<th>goods_no</th>
				<th>goods_name</th>
				<th>goods_price</th>
				<th>create_date</th>
				<th>update_date</th>
				<th>sold_out</th>
			</tr>
		</thead>
		
		<%
		for(Goods g : goodsList){
		%>
			<tr>
				<td><%=g.getGoodsNo()%></td>
				<td><%=g.getGoodsName()%></td>
				<td><%=g.getGoodsPrice()%></td>
				<td><%=g.getCreateDate()%></td>
				<td><%=g.getUpdateDate()%></td>
				<td><%=g.getSoldOut()%></td>
				<td>
					<form action="<%=request.getContextPath()%>/modifySoldOutActiveAction.jsp" method="post">
						<input type="hidden" name="goodsNo" value="<%=g.getGoodsNo()%>">
						<input type="hidden" name="preSoldOutValue" value="<%=g.getSoldOut()%>">
				        <select name="active">
							<%
								if(g.getSoldOut().equals("N")){
							%>
								<option value="Y">Y</option>
								<option selected=“selected” value="N">N</option>
							<%
							} else {
							%>
								<option value="N">N</option>
								<option selected=“selected” value="Y">Y</option>
							<%
							}
							%>
						</select>
						<button type="submit" class='btn btn-info btn-xs'>수정</button>
					</form>
				</td>
			</tr>
		<%
			}
		%>
	</table>
	<div class="container">
		<ul class="pagination">
			<%	
			// 이전 페이징
			if(pageBegin > rowPerPage){
			%>
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminGoodsList.jsp?currentPage=<%=pageBegin - rowPerPage%>">이전</a></li>
			<%
			}
			// 숫자 페이징
			for(int i = pageBegin; i <= pageEnd; i++){
			%>			
			  <li class="page-item">
			  	<a class="page-link" href="<%=request.getContextPath()%>/adminGoodsList.jsp?currentPage=<%=i%>">
			  		<%=i%>
			  	</a>
			  </li>
		  <%
			}
			
			// 다음 페이징
			if(pageEnd < lastPage){
			%>
			  	<li class="page-item">
				  	<a class="page-link" href="<%=request.getContextPath()%>/adminGoodsList.jsp?currentPage=<%=pageBegin + rowPerPage%>">
				  		다음
				  	</a>
			  	</li>
			<%
			}
			%>
		</ul>
	</div>
	</div>
</div>
</body>
</html>