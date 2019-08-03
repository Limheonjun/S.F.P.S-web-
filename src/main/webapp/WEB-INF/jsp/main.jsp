<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- header -->
<jsp:include page="include/header.jsp" flush="false" />
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- main_header -->
		<jsp:include page="include/main_header.jsp" flush="false" />
		<!-- left_column -->
		<jsp:include page="include/left_column.jsp" flush="false" />
		<div class="content-wrapper">
			<div id="div_right">
				<div id="div_top">
					<jsp:include page="right/top/alarm.jsp" flush="false" />
				</div>
				<div id="div_bottom">
					<jsp:include page="right/bottom/map.jsp" flush="false">
						<jsp:param name="list" value="${list}" />
					</jsp:include>
				</div>
			</div>
			<div id="div_left">
				<jsp:include page="left/status.jsp" flush="false" />
				<jsp:include page="left/status2.jsp" flush="false" />
				<jsp:include page="left/status3.jsp" flush="false" />
				<jsp:include page="left/status4.jsp" flush="false" />
				<jsp:include page="left/status5.jsp" flush="false" />
				<jsp:include page="left/status6.jsp" flush="false" />
			</div>
		</div>
		<!-- main_footer -->
		<jsp:include page="include/main_footer.jsp" flush="false" />
	</div>
	<!-- plugin_js -->
	<jsp:include page="include/plugin_js.jsp" flush="false" />
</body>
</html>