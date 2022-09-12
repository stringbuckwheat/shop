<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
System.out.println("--------------------- addReviewForm.jsp");

// 세션 유효성 검사
if(session.getAttribute("id") == null || session.getAttribute("user").equals("Employee")){
	response.sendRedirect(request.getContextPath() + "/login/customerLoginForm.jsp?errorMsg=login needed");
	return;
}

// 파라미터 받아오기
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
System.out.println("orderNo: " + orderNo);

// review에 필요한 것: order_no, review_content, create_date, update_date, rating
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>addReviewForm</title>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
</head>
<body>
	<%@include file="/header.jsp"%>
	<div class="container">
		<div class="card" style="margin-top:15px;">
			<div class="card-body">
				<h5 class="text-dark">리뷰 쓰기</h5>
				<p class="text-secondary">리뷰리뷰</p>
				<div class="star-area">
					<h1>
						<i class="fa fa-star-o" aria-hidden="true" id="star_review" data-number="1"></i>
						<i class="fa fa-star-o" aria-hidden="true" id="star_review" data-number="2"></i>
						<i class="fa fa-star-o" aria-hidden="true" id="star_review" data-number="3"></i>
						<i class="fa fa-star-o" aria-hidden="true" id="star_review" data-number="4"></i>
						<i class="fa fa-star-o" aria-hidden="true" id="star_review" data-number="5"></i>
					</h1>
				</div>
				<div class="review-area" style="display:none;">
					<form method="post" action="<%=request.getContextPath()%>/review/addReviewAction.jsp">
						<input type="hidden" name="orderNo" value="<%=orderNo%>">
						<input type="hidden" name="rating" id="star_input" value="0">
						<textarea class="form-control" rows="3" style="resize: none" name="reviewContent"></textarea>
						<span class="float-right" style="margin-top:15px;line-height:35px;">
							<span id="stars_confirm">
							</span>
							<button class="btn btn-success float-right" type="submit" style="margin-left:20px;">Submit</button>
						</span>
					</form>
				</div>
			</div>
		</div>
	</div>

<script>
$( document ).ready(function() {
	document.querySelectorAll('#star_review').forEach(function(element) {
		element.addEventListener("mouseenter", function(event) {
			$('#stars_confirm').html('');
			var stars = event.target.dataset.number;
			$('#star_input').val(stars);
			var count = 0;
			document.querySelectorAll('#star_review').forEach(function(el) {
				if (count < stars) {
					$(el).removeClass('fa-star-o');
					$(el).addClass('fa-star');
					$('#stars_confirm').append('<i class="fa fa-star" aria-hidden="true" style="color:#212529 !important"></i>');
				} else {
					$(el).removeClass('fa-star');
					$(el).addClass('fa-star-o');
				}
				count = count+1;
			});
		});
		element.addEventListener("click", function(event) {
			console.log('clicked')
			$('.star-area').hide();
			$('.review-area').fadeIn();
		});
		element.addEventListener("mouseleave", function(event) {
			document.querySelectorAll('#star_review').forEach(function(el) {
				$(el).removeClass('fa-star');
				$(el).addClass('fa-star-o');
			});
		});
	});
});
</script>
</body>
</html>