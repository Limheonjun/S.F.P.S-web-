<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>마커 클러스터</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"
	integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=<spring:eval expression="@config.getProperty('clientkey')" />"></script>
<script type="text/javascript" src="../../js/accidentdeath.js"></script>
<script type="text/javascript" src="../../js/MarkerClustering.js"></script>
<style type="text/css">
html, body {
	width: 100%;
	height: 100%;
	padding: 0;
	margin: 0;
}
</style>
</head>
<!-- //new naver.maps.LatLng(37.451358, 126.633288) -->
<body>
	<div id="map" style="width: 100%; height: 100%; padding: 0; margin: 0;"></div>
	<script>
	var map = new naver.maps.Map("map", {
        zoom: 3,
        center: new naver.maps.LatLng(36.2253017, 127.6460516),
        zoomControl: true,
        zoomControlOptions: {
            position: naver.maps.Position.TOP_LEFT,
            style: naver.maps.ZoomControlStyle.SMALL
        }
    });
    var markers = [];
    
    // 용현 스타벅스
    var marker1 = new naver.maps.Marker({
        position: new naver.maps.LatLng(37.452370, 126.632605),
        draggable: true
    });
    
    // 인천대 정보대
    var marker2 = new naver.maps.Marker({
        position: new naver.maps.LatLng(37.374759, 126.633499),
        draggable: true
    });
    
    // 인천대 공대
    var marker3 = new naver.maps.Marker({
        position: new naver.maps.LatLng(37.373582, 126.632735),
        draggable: true
    });
    
    // 홍대 토즈
    var marker4 = new naver.maps.Marker({
        position: new naver.maps.LatLng(37.561289, 126.922648),
        draggable: true
    });
    
    // 부평역
    var marker5 = new naver.maps.Marker({
        position: new naver.maps.LatLng(37.490624, 126.723674),
        draggable: true
    });


    markers.push(marker1);
    markers.push(marker2);
    markers.push(marker3);
    markers.push(marker4);
    markers.push(marker5);
    
    
    var htmlMarker1 = {
            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-1.png);background-size:contain;"></div>',
            size: N.Size(40, 40),
            anchor: N.Point(20, 20)
        },
        htmlMarker2 = {
            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-2.png);background-size:contain;"></div>',
            size: N.Size(40, 40),
            anchor: N.Point(20, 20)
        },
        htmlMarker3 = {
            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-3.png);background-size:contain;"></div>',
            size: N.Size(40, 40),
            anchor: N.Point(20, 20)
        },
        htmlMarker4 = {
            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-4.png);background-size:contain;"></div>',
            size: N.Size(40, 40),
            anchor: N.Point(20, 20)
        },
        htmlMarker5 = {
            content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-5.png);background-size:contain;"></div>',
            size: N.Size(40, 40),
            anchor: N.Point(20, 20)
        };
    var markerClustering = new MarkerClustering({
        minClusterSize: 2,
        maxZoom: 8,
        map: map,
        markers: markers,
        disableClickZoom: false,
        gridSize: 120,
        icons: [htmlMarker1, htmlMarker2, htmlMarker3, htmlMarker4, htmlMarker5],
        indexGenerator: [10, 100, 200, 500, 1000],
        stylingFunction: function(clusterMarker, count) {
            $(clusterMarker.getElement()).find('div:first-child').text(count);
        }
    });
	</script>
</body>
</html>