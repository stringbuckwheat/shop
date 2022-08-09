<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.*"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 세션 유효성 검사
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	// customer로 로그인한 사람은 loginForm -> index 
	response.sendRedirect(request.getContextPath() + "/employeeLoginForm.jsp?errorMsg=no authority");
	return;
}

int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

GoodsService goodsService = new GoodsService();
Map<String, Object> goodsAndImgOne = goodsService.getGoodsAndImgOne(goodsNo);

//수정 폼 만들어야 할 수도 있으니까 일단 저장
Set<String> theadSet = goodsAndImgOne.keySet();
//[goodsNo, originFilename, filename, goodsUpdateDate, goodsPrice, goodsName, soldOut, createDate]
System.out.println(theadSet);
System.out.println(goodsAndImgOne.values());

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>goodsAndImgOne</title>
<link rel="stylesheet" href="../css/style.css">
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
				<img src="<%=request.getContextPath()%>/upload/<%=goodsAndImgOne.get("originFilename")%>"  width="400" height="330">
			</div>
			<div class="col-md-7 custyle">
				<table class="table table-striped custab">
					
						<%
						for(Map.Entry<String, Object> e : goodsAndImgOne.entrySet()){				
						%>
							<tr>
								<th><%=e.getKey()%></th>
								<td><%=e.getValue()%></td>
							</tr>	
						<%
						}
						%>
					
				</table>
			</div>
		</div>
	</div>
</body>
</html>