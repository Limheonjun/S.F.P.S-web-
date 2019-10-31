<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>현황</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"
	integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=<spring:eval expression="@config.getProperty('clientkey')" />"></script>
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
<body>
	<div id="map" style="width: 100%; height: 100%; padding: 0; margin: 0;"></div>
	<script>
		//console.log("param.map : "+'${param.list}'+" // map : "+'${map}'+" // param : "+'${param}');
		var list = JSON.parse('${param.list}');
		var map = new naver.maps.Map("map", {
			zoom : 3,
			center : new naver.maps.LatLng(36.2253017, 127.6460516),
			zoomControl : true,
			zoomControlOptions : {
				position : naver.maps.Position.TOP_LEFT,
				style : naver.maps.ZoomControlStyle.SMALL
			}
		});
		var markers = [];
		var infowindows = [];
		
		for (var i = 0; i < list.length; i++) {
			var marker = new naver.maps.Marker({
				position : new naver.maps.LatLng(list[i].lat, list[i].lng),
				draggable : true
			});
			var infowindow = new naver.maps.InfoWindow({
				content : '<h3>정보</h3><br>' + '<h5>위치 : ' + list[i].location
						+ '</h5><br>' + '<h5>위도 : ' + list[i].lat + '</h5><br>'
						+ '<h5>경도 : ' + list[i].lng + '</h5><br>'
						+ '<h5>설치날짜 : ' + list[i].installdate + '</h5><br>'
						+ '<h5>전화번호 : ' + list[i].phone + '</h5><br>'
			});
			markers.push(marker);
			infowindows.push(infowindow);
		}



		var htmlMarker1 = {
			content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-1.png);background-size:contain;"></div>',
			size : N.Size(40, 40),
			anchor : N.Point(20, 20)
		}, htmlMarker2 = {
			content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-2.png);background-size:contain;"></div>',
			size : N.Size(40, 40),
			anchor : N.Point(20, 20)
		}, htmlMarker3 = {
			content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-3.png);background-size:contain;"></div>',
			size : N.Size(40, 40),
			anchor : N.Point(20, 20)
		}, htmlMarker4 = {
			content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-4.png);background-size:contain;"></div>',
			size : N.Size(40, 40),
			anchor : N.Point(20, 20)
		}, htmlMarker5 = {
			content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../images/cluster-marker-5.png);background-size:contain;"></div>',
			size : N.Size(40, 40),
			anchor : N.Point(20, 20)
		};
		var markerClustering = new MarkerClustering({
			minClusterSize : 2,
			maxZoom : 8,
			map : map,
			markers : markers,
			disableClickZoom : false,
			gridSize : 120,
			icons : [ htmlMarker1, htmlMarker2, htmlMarker3, htmlMarker4,
					htmlMarker5 ],
			indexGenerator : [ 10, 100, 200, 500, 1000 ],
			stylingFunction : function(clusterMarker, count) {
				$(clusterMarker.getElement()).find('div:first-child').text(
						count);
			}
		});
		
		for (var i=0; i<markers.length; i++) {
	        naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
	    }
		
		//map.setCenter(new naver.maps.LatLng(37.5612890, 126.9226480));
        //map.setZoom(11)
	    
	    function getClickHandler(seq) {
	        return function(e) {
	        	
	            var marker = markers[seq],
	                infoWindow = infowindows[seq];

	            if (infowindow.getMap()) {
	                infowindow.close();
	            } else {
	                infoWindow.open(map, marker);
	            }
	        }
	    }
	</script>
</body>
</html>