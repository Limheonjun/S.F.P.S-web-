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
			<th>온도</th>
			<th>연기</th>
			<th>불꽃</th>
			<th>불꽃감지 위치</th>
			<th>시간</th>
		</tr>
		<c:forEach var="list" items="${list}">
			<tr>
				<th><c:out value="${list.location}" /></th>
				<th><c:out value="${list.temperature}" /></th>
				<th><c:out value="${list.smoke}" /></th>
				<th><c:out value="${list.flame}" /></th>
				<th><c:out value="${list.flame_number}" /></th>
				<th><c:out value="${list.date}" /></th>
			</tr>
		</c:forEach>
		
	</table>
</body>
</html>