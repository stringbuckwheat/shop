<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <meta charset="utf-8">

	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-between">
				<div class="col">
					<a class="navbar-brand" href="index.html">stringbuckwheat<span>shop</span></a>
				</div>
				<div class="col d-flex justify-content-end">
					<div class="social-media">
			    		<p class="mb-0 d-flex">
			    		
			    		<%
			    		if(session.getAttribute("id") != null){
			    		%>
			    			<a href="<%=request.getContextPath()%>/logout.jsp" class="d-flex align-items-center justify-content-center">
			    				<span class="fa fa-unlock">
			    					<i class="sr-only">logout</i>
			    				</span>
			    			</a>
		    			<%
		    			} else {
		    			%>
			    			<a href="<%=request.getContextPath()%>/customerLoginForm.jsp" class="d-flex align-items-center justify-content-center">
			    				<span class="fa fa-lock">
			    					<i class="sr-only">login</i>
			    				</span>
			    			</a>
			    			<a href="#" class="d-flex align-items-center justify-content-center">
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
	        	<li class="nav-item active"><a href="#" class="nav-link">Home</a></li>
	        	<li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Page</a>
              <div class="dropdown-menu" aria-labelledby="dropdown04">
              	<a class="dropdown-item" href="#">Page 1</a>
                <a class="dropdown-item" href="#">Page 2</a>
                <a class="dropdown-item" href="#">Page 3</a>
                <a class="dropdown-item" href="#">Page 4</a>
              </div>
            </li>
	        	<li class="nav-item"><a href="#" class="nav-link">Catalog</a></li>
	        	<li class="nav-item"><a href="#" class="nav-link">Blog</a></li>
	          <li class="nav-item"><a href="#" class="nav-link">Contact</a></li>
	        </ul>
	      </div>
	    </div>
	  </nav>
    <!-- END nav -->

	</section>
