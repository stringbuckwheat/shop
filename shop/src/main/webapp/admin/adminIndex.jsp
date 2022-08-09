<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 세선 유효성 검정 코드 
if(session.getAttribute("id") == null || !(session.getAttribute("user").equals("Employee"))){
	// customer로 로그인한 사람은 loginForm -> index 
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=no authority");
	return;
}

// 사원관리, 상품관리, 고객관리, 주문관리, 공지관리
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>admin index</title>
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="../css/style.css">
		<link href="<%=request.getContextPath()%>/css/adminIndex.css" rel="stylesheet">
	</head>
	<body>
	<%@include file="../header.jsp"%>
	<div class="container">
	    <div class="row col-md-12 col-md-offset-1 custyle">
		<div>
			<ul>
				<li><a href="<%=request.getContextPath()%>/admin/employeeList.jsp">사원관리</a></li>
				<li><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리</a></li> <!-- 상품목록/등록/수정(품절)/삭제(장바구니, 주문이 없는 경우) -->
				<li><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리</a></li> <!-- 주문목록 / 수정 -->
				<li><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a></li> <!-- 고객목록 / 강제 탈퇴 / 비밀번호 수정(전달 구현 X) -->
				<li><a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">공지관리</a></li> <!-- 공지 CRUD -->
			</ul>
		</div>
		
		<h1>상품 관리</h1>
		
				<div id="home_quicklinks">
                    <a class="quicklink link1" href="<%=request.getContextPath()%>/admin/employeeList.jsp">
                        <span class="ql_caption">
                            <span class="outer">
                                <span class="inner">
                                    <h2>사원관리</h2>
                                </span>
                            </span>
                        </span>
                        <span class="ql_top"></span>
                        <span class="ql_bottom"></span>
                    </a>
                    <a class="quicklink link1" href="<%=request.getContextPath()%>/admin/employeeList.jsp">
                        <span class="ql_caption">
                            <span class="outer">
                                <span class="inner">
                                    <h2>사원관리</h2>
                                </span>
                            </span>
                        </span>
                        <span class="ql_top"></span>
                        <span class="ql_bottom"></span>
                    </a>
                    <a class="quicklink link1" href="<%=request.getContextPath()%>/admin/employeeList.jsp">
                        <span class="ql_caption">
                            <span class="outer">
                                <span class="inner">
                                    <h2>사원관리</h2>
                                </span>
                            </span>
                        </span>
                        <span class="ql_top"></span>
                        <span class="ql_bottom"></span>
                    </a>
                    <a class="quicklink link1" href="<%=request.getContextPath()%>/admin/employeeList.jsp">
                        <span class="ql_caption">
                            <span class="outer">
                                <span class="inner">
                                    <h2>사원관리</h2>
                                </span>
                            </span>
                        </span>
                        <span class="ql_top"></span>
                        <span class="ql_bottom"></span>
                    </a>
                    <a class="quicklink link1" href="<%=request.getContextPath()%>/admin/employeeList.jsp">
                        <span class="ql_caption">
                            <span class="outer">
                                <span class="inner">
                                    <h2>사원관리</h2>
                                </span>
                            </span>
                        </span>
                        <span class="ql_top"></span>
                        <span class="ql_bottom"></span>
                    </a>
                    
                    

                </div>
                <div class="hexagon">
  <div class="hexTop"></div>
  <div class="hexBottom"></div>
</div>
</div>
</div>
	</body>
</html>