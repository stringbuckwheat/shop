<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("id") != null){
	response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=already logined");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>add employee form</title>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<link href="<%=request.getContextPath()%>/css/loginForm.css" rel="stylesheet">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<div id="LoginForm">
		<div class="container">
			<div class="login-form">
				<div class="main-div">
				   <div class="panel">
					   <h2>관리자 회원 가입</h2>
					   <div class="forgot text-center">
				 	       <a href="<%=request.getContextPath()%>/addCustomerForm.jsp">일반 회원으로 가입하시겠습니까?</a>
						</div>
					   
						<%
							if(request.getParameter("errorMsg") != null){
								%>
								<span class="err-msg"><%=request.getParameter("errorMsg")%></span>
								<%
							}
						%>
						<div>
							<form>
								<div class="form-group">
									<input type="text" class="form-control" name="inputId" id="inputId" placeholder="아이디를 입력하세요">
								</div>
								<button type="button" class="btn btn-primary" id="idckBtn">아이디 중복 검사</button>
							</form>
						</div>
						
						<br>
						
						<form id="employeeForm" action="<%=request.getContextPath()%>/addEmployeeAction.jsp" method="post">
							<div class="form-group">
				        		<input type="text" class="form-control" name="employeeId" id="employeeId" readonly="readonly">
					        </div>
					        <div class="form-group">
					            <input type="password" class="form-control" name="employeePass" id="employeePass" placeholder="비밀번호를 입력하세요">
					        </div>
					        <div class="form-group">
					            <input type="text" class="form-control" name="employeeName" id="employeeName" placeholder="이름을 입력하세요">
					        </div>
   					        <div class="form-group">
				        		<input type="text" class="form-control" name="employeeAddress" id="employeeAddress" readonly="readonly" placeholder="주소를 검색하세요">
   								<button type="button" class="btn btn-primary" id="addressBtn">주소 검색</button>
					        </div>
					        <div class="form-group">
				        		<input type="text" class="form-control" name="employeeDetailAddress" id="employeeDetailAddress" placeholder="상세 주소를 입력하세요">
					        </div>
					        <button type="button" class="btn btn-primary" id="employeeBtn">가입</button>
						 </form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script>
$('#addressBtn').click(function(){
	sample2_execDaumPostcode();
});


function sample2_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
               //  document.getElementById("sample2_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample2_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            // document.getElementById('sample2_postcode').value = data.zonecode;
            // document.getElementById("sample2_address").value = addr;
            
            /////////////////////////////////
            // $('#addr').val(data.zonecode + ' ' + addr)
            document.getElementById('employeeAddress').value = data.zonecode + ' ' + addr;
        
            
            // 커서를 상세주소 필드로 이동한다.
            // document.getElementById("sample2_detailAddress").focus();

            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            element_layer.style.display = 'none';
        },
        width : '100%',
        height : '100%',
        maxSuggestItems : 5
    }).embed(element_layer);

    // iframe을 넣은 element를 보이게 한다.
    element_layer.style.display = 'block';

    // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
    initLayerPosition();
}

</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>

<script>
	// ajax
	$('#idckBtn').click(function() {
		if($('#inputId').val().length < 4) {
			alert('id는 4자이상!');
			return;
		}
		
		// 비동기 호출	
		$.ajax({
			url : '/ajax-test/idckController',
			type : 'post',
			data : {idck : $('#inputId').val()},
			success : function(json) {
				// alert(json);
				if(json == 'y') {
					$('#employeeId').val($('#inputId').val());
					return;
				}
				
				alert('이미 사용중인 아이디 입니다.');
				$('#employeeId').val('');
			} // end for success
		}); // end for ajax
	});

	// 빈칸검사
	$('#employeeBtn').click(function(){		
		if($('#employeeId').val() == ''){
			alert('아이디를 입력하세요');
		} else if($('#employeePass').val() == ''){
			alert('패스워드를 입력하세요');
		} else if($('#employeeName').val() == ''){
			alert('이름을 입력하세요');
		} else if($('#employeeAddress').val() == ''){
			alert('주소를 검색하세요');
		} else if($('#employeeDetailAddress').val() == ''){
			alert('상세 주소를 입력하세요');
		} else {
			$('#employeeForm').submit();
		}
	});
</script>

</body>
</html>