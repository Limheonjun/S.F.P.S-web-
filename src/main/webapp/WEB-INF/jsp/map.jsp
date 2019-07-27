<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta http-equiv="X-UA-Compatible" content="IE=edge">

<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">

<title>간단한 지도 표시하기</title>

<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId="클라이언트ID"></script>

</head>

<body>
	<div id="map" style="width: 500px; height: 400px;"></div>
	<script>
		var mapOptions = {
			center : new naver.maps.LatLng(37.451358, 126.633288),
			zoom : 10
		};
		var map = new naver.maps.Map('map', mapOptions);
		var markerOptions = {
			position : new naver.maps.LatLng(37.451358, 126.633288),
			map : map
		};
		var marker = new naver.maps.Marker(markerOptions);
	</script>
</body>
</html>