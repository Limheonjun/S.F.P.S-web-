<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>

<!-- header -->
<%@include file="../include/header.jsp"%>
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- main_header -->
		<%@include file="../include/main_header.jsp"%>
		<!-- left_column -->
		<%@include file="../include/left_column.jsp"%>

		<div class="content-wrapper">
			<div id="div_top">top</div>
			<div id="div_contents">
				<jsp:include page="../jsp/contents.jsp" flush="false" />
			</div>
		</div>

		<!-- main_footer -->
		<%@include file="../include/main_footer.jsp"%>
	</div>

	<!-- plugin_js -->
	<%@include file="../include/plugin_js.jsp"%>
</body>
</html>