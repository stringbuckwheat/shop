<%@page import="service.CounterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <meta charset="utf-8">
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col">
					<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">stringbuckwheat<span>shop</span></a>
				</div>
				<div class="col d-flex justify-content-end">
					<div class="social-media">
			    		<p class="mb-0 d-flex">
			    		
			    		<%
			    		if(session.getAttribute("id") != null){
			    		%>
			    			<span>
			    				<a href="<%=request.getContextPath()%>/member/myPage.jsp">
				    				<%=session.getAttribute("name")%>(<%=session.getAttribute("user")%>, <%=session.getAttribute("id")%>)님 반갑습니다. 
			    				</a>
			    			</span>
			    			<a href="<%=request.getContextPath()%>/login/logout.jsp" class="d-flex align-items-center justify-content-center">
			    				<span class="fa fa-unlock">
			    					<i class="sr-only">logout</i>
			    				</span>
			    			</a>
		    			<%
		    			} else {
		    			%>
		    				<span>
			    				로그인이 필요합니다. 
			    			</span>
			    			<a href="<%=request.getContextPath()%>/login/customerLoginForm.jsp" class="d-flex align-items-center justify-content-center">
			    				<span class="fa fa-lock">
			    					<i class="sr-only">login</i>
			    				</span>
			    			</a>
			    			<a href="<%=request.getContextPath()%>/member/addCustomerForm.jsp" class="d-flex align-items-center justify-content-center">
			    				<span class="fa fa-plus">
			    					<i class="sr-only">sign up</i>
			    				</span>
			    			</a>
			    		<%
		    			}
			    		%>
			    		</p>
	       			</div>
				</div>
			</div>
		</div>
		<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	    
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="fa fa-bars"></span> Menu
	      </button>
				<form action="#" class="searchform order-lg-last">
          <div class="form-group d-flex">
            <input type="text" class="form-control pl-3" placeholder="Search">
            <button type="submit" placeholder="" class="form-control search"><span class="fa fa-search"></span></button>
          </div>
        </form>
	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav mr-auto">
	        	<li class="nav-item active"><a href="<%=request.getContextPath()%>/index.jsp" class="nav-link">Home</a></li>
	        	<li class="nav-item dropdown">
			        <%
			       	 // 세션에 저장된 유저 타입이 '직원'이면 admin 메뉴를 보여줌
		       		 if("Employee".equals(session.getAttribute("user"))){
		       		%>
		              <a class="nav-link dropdown-toggle" href="<%=request.getContextPath()%>/admin/adminIndex.jsp" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">ADMIN</a>
		              <div class="dropdown-menu" aria-labelledby="dropdown04">
		              	<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/employeeList.jsp">사원관리</a>
		                <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">상품관리</a>
		                <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">고객관리</a>
		                <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp">주문관리</a>
		                <a class="dropdown-item" href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지관리</a>
		              </div>
	              <%
	              }
	              %>
            	</li>
            	
            	<!-- 카테고리 -->
            	<!-- TODO 카테고리 받아와서 반복문으로 돌리기 -->
            	<li class="nav-item dropdown">
            		<a class="nav-link dropdown-toggle" href="<%=request.getContextPath()%>/index.jsp" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">CATEGORY</a>
						<div class="dropdown-menu" aria-labelledby="dropdown04">
							<a class="dropdown-item" href="<%=request.getContextPath()%>/categoryGoodsList.jsp">사원관리</a>
							<a class="dropdown-item" href="<%=request.getContextPath()%>/index.jsp">상품관리</a>
							<a class="dropdown-item" href="<%=request.getContextPath()%>/index.jsp">고객관리</a>
							<a class="dropdown-item" href="<%=request.getContextPath()%>/index.jsp">주문관리</a>
							<a class="dropdown-item" href="<%=request.getContextPath()%>/index.jsp">공지관리</a>
						</div>
            	</li>
            
	        	<li class="nav-item"><a href="<%=request.getContextPath()%>/order/orderListForCustomer.jsp?customerId=<%=(String)session.getAttribute("id")%>" class="nav-link">ORDER</a></li>
	        	<li class="nav-item"><a href="<%=request.getContextPath()%>/cart/cartList.jsp" class="nav-link">CART</a></li>
	          	<li class="nav-item"><a href="<%=request.getContextPath()%>/notice/noticeList.jsp" class="nav-link">NOTICE</a></li>
	          	<li class="nav-item"><a href="<%=request.getContextPath()%>/member/myPage.jsp" class="nav-link">MYPAGE</a></li>
	        </ul>
	      </div>
	    </div>
	  </nav>
    <!-- END nav -->

	</section>
