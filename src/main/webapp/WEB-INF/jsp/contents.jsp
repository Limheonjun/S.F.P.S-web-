<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="div_left">
		<jsp:include page="../jsp/map.jsp" flush="false">
			<jsp:param name="list" value="${list}" />
		</jsp:include>

	</div>
	<div id="div_right">
		<jsp:include page="../jsp/status.jsp" flush="false" />
	</div>
</body>
</html>