<%@page import="vo.Employee"%>
<%@page import="java.util.List"%>
<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
int currentPage = 1;

if(request.getParameter("currentPage") != null){
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

final int rowPerPage = 10; // 페이지 당 출력할 글 개수

EmployeeService employeeService = new EmployeeService();
List<Employee> employeeList = employeeService.getEmployeeList(rowPerPage, currentPage);

int lastPage = employeeService.getLastPage(rowPerPage);
int pageBegin = ((currentPage - 1) / rowPerPage) * rowPerPage + 1; // 페이지 시작 넘버
int pageEnd = pageBegin + rowPerPage - 1; // 페이지 끝 글 구하는 공식
pageEnd = Math.min(pageEnd, lastPage); // 둘 중에 작은 값이 pageEnd
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 목록</title>
</head>
<body>
	<table border="1">
		<th>id</th>
		<th>name</th>
		<th>updateDate</th>
		<th>createDate</th>
		<th>active</th>
		<%
		for(Employee e : employeeList){
		%>
			<tr>
				<td><%=e.getEmployeeId()%></td>
				<td><%=e.getEmployeeName()%></td>
				<td><%=e.getUpdateDate()%></td>
				<td><%=e.getCreateDate()%></td>
				<td>
					<form action="<%=request.getContextPath()%>/modifyEmployeeActiveAction.jsp" method="post">
						<input type="hidden" name="employeeId" value="<%=e.getEmployeeId()%>">
				        <select name="active">
							<%
								if(e.getEmployeeActive().equals("N")){
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
						<button type="submit">수정</button>
					</form>
				</td>
			</tr>
		<%
			}
		%>
	</table>
	
	<%	
	// 이전 페이징
	if(pageBegin > rowPerPage){
	%>
		<a href="<%=request.getContextPath()%>/employeeList.jsp?currentPage=<%=pageBegin - rowPerPage%>">이전</a>
	<%
	}
	
	// 숫자 페이징
	for(int i = pageBegin; i <= pageEnd; i++){
	%>
		<a href="<%=request.getContextPath()%>/employeeList.jsp?currentPage=<%=i%>"><%=i%></a>
	<%
	}
	
	// 다음 페이징
	if(pageEnd < lastPage){
	%>
		<a href="<%=request.getContextPath()%>/employeeList.jsp?currentPage=<%=pageBegin + rowPerPage%>">다음</a>
	<%
	}
	%>
</body>
</html>