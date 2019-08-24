<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/tab.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<title>로그</title>
</head>
<body>
	<div id="container">
		<h2>Filter</h2>
		<ul class="tab">
			<li id="tab1" class="current" data-tab="tab1"><a href="#">센서
					로그</a></li>
			<li id="tab2" data-tab="tab2"><a href="#">통신 로그</a></li>
			<li id="tab3" data-tab="tab3"><a href="#">텐서플로우 로그</a></li>
			<li id="tab4" data-tab="tab4"><a href="#">센서 오탐 로그</a></li>
		</ul>

		<div id="tab" class="tabcontent current">
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
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$("#tab1").click(function() {
				$("#tab").empty();
				$("#tab").load("sensor_log.do");
				$('ul.tab li').removeClass('current');
				$(this).addClass('current');
				$('#' + activeTab).addClass('current');
				
			});

			$("#tab2").click(function() {
				$("#tab").empty();
				$("#tab").load("telecom_log.do");
				$('ul.tab li').removeClass('current');
				$(this).addClass('current');
				$('#' + activeTab).addClass('current');
			});

			$("#tab3").click(function() {
				$("#tab").empty();
				$("#tab").load("tensorflow_log.do");
				$('ul.tab li').removeClass('current');
				$(this).addClass('current');
				$('#' + activeTab).addClass('current');
			});

			$("#tab4").click(function() {
				$("#tab").empty();
				$("#tab").load("sensordetection_log.do");
				$('ul.tab li').removeClass('current');
				$(this).addClass('current');
				$('#' + activeTab).addClass('current');
			});
		});
	</script>

</body>
</html>