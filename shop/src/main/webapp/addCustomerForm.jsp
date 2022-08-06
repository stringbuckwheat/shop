<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Sign up - Customer</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">
    <div class="container">
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                    <div class="text-center">
                        <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                    </div>
                    
                    <%
					if(request.getParameter("errorMsg") != null){
						%>
						<div>
							<span><%=request.getParameter("errorMsg")%></span>
						</div>
						<%
					}
					%>
					
					<!-- id check form -->
					<div>
						<form class="user" action="<%=request.getContextPath()%>/idCheckAction.jsp" method="post">
							<input type="hidden" name="membership" value="Customer">
							<div class="form-group">
	                             <input type="text" class="form-control form-control-user" id="inputId"
	                                 name="inputId" placeholder="customer id">
	                         </div>
							<button type="submit" class="btn btn-primary btn-user btn-block">아이디 중복 확인</button>
						</form>
					</div>
					
					<%
					String inputId = ""; // 빈 문자열
					if(request.getParameter("inputId") != null){
						inputId = request.getParameter("inputId");
					}
					%>
                    
                    <!-- SIGN UP FORM -->
                    <form class="user" id="customerForm" action="<%=request.getContextPath()%>/addCustomerAction.jsp" method="post">
                     	<input type="hidden" name="customerId" value="<%=inputId%>">
                     	<div class="form-group"> 
                            <input type="text" class="form-control form-control-user" 
                                readonly="readonly" value="<%=inputId%>는 사용 가능한 ID입니다.">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control form-control-user" id="customerPass"
                                name="customerPass" placeholder="customer password">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control form-control-user" id="customerName"
                                name="customerName" placeholder="customer name">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control form-control-user" id="customerAddress"
                                name="customerAddress" placeholder="customer address">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control form-control-user" id="customerTelephone"
                                name="customerTelephone" placeholder="customer telephone">
                        </div>
                        <button type="button" id="customerBtn" class="btn btn-primary btn-user btn-block">
                            Register Account
                        </button>
                    </form>
                    <hr>
                    <div class="text-center">
                        <a class="small" href="login.html">Already have an account? Login!</a>
                    </div>
                </div>
            </div>
        </div>
            
    </body>
    

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
    <script>
		// 고객 빈칸검사
		$('#customerBtn').click(function(){		
			if($('#customerId').val() == ''){
				alert('고객 아이디를 입력하세요');
			} else if($('#customerPass').val() == ''){
				alert('고객 패스워드를 입력하세요');
			} else if($('#customerName').val() == ''){
				alert('성함을 입력하세요');
			} else if($('#customerAddress').val() == ''){
				alert('주소를 입력하세요');
			} else if($('#customerTelephone').val() == ''){
				alert('전화번호를 입력하세요');
			} else {
				$('#customerForm').submit();
			}
		});
	</script>


</html>