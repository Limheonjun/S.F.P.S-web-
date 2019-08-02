<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그</title>
</head>
<body>
	<table border=1px solid black>
		<tr>
			<th>위치</th>
			<th>결과</th>
			<th>url</th>
			<th>시간</th>
		</tr>
		<c:forEach var="list" items="${list}">
			<tr>
				<th><c:out value="${list.location}" /></th>
				<th><c:out value="${list.result}" /></th>
				<th><c:out value="${list.filepath}" /></th>
				<th><c:out value="${list.date}" /></th>
			</tr>
		</c:forEach>
		
	</table>
</body>
</html>