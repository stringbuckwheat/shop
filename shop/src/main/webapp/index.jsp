<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 로그인 한 사람만 입장 가능
if(session.getAttribute("id") == null){
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}

/* 
index.jsp -> 사원으로 로그인한 경우 관리자 페이지 링크(adminIndex.jsp)
adminIndex.jsp -> 사원관리, 상품관리, 고객관리, 주문관리, 공지 관리
1) 사원관리(리스트): employeeList.jsp -> EmployeeService.getEmployeeList(int rowPerPage, int currentPage): beginRow 구하기 -> EmployeeDao.selectEmployeeList(int rowPerPage, int beginRow)
					여기서 active 값 N을 Y로 수정할 수 있도록! (select 상자) -> EmployeeService.modifyEmployeeActive() -> EmployeeDao.updateEmployeeActive()
*/

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%=session.getAttribute("user")%>
	<br>
	<%=session.getAttribute("id") %>
	<br>
	<%=session.getAttribute("name") %>
	<br>
	<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	<a href="<%=request.getContextPath()%>/outIdForm.jsp">회원 탈퇴</a>
	<%
	if("Employee".equals(session.getAttribute("user"))){
	%>
		<a href="<%=request.getContextPath()%>/adminIndex.jsp">관리자 페이지</a>
	<%
	}
	%>
</body>
</html>