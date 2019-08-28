<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<title>로그</title>
</head>
<body>
	<div class="container text-center">
		<h2>Filter</h2>
		<select id="list">
			<option value="-1">로그선택</option>
			<option value="0">센서로그</option>
			<option value="1">Opencv로그</option>
			<option value="2">텐서플로우로그</option>
			<option value="3">통신로그</option>
		</select> 
		<label for="fromDate">시작일</label>
		<input type="text" name="fromDate" id="fromDate"> ~
		<label for="toDate">종료일</label>
		<input type="text" name="toDate" id="toDate">
		<br>
		<label>위치 </label>
		<input type="text" id="location" placeholder="기본값 : 전체">
		<button id="search">검색</button>


		<table id="table" class="table table-striped" border=1px solid black>
		<!--  
			<thead>
			<tr>
				<th>위치</th>
				<th>온도</th>
				<th>연기</th>
				<th>불꽃</th>
				<th>불꽃감지 위치</th>
				<th>시간</th>
			</tr>
			</thead>
			
			-->
	
		</table>
	</div>
	<script>
	var tableData = [
		{url : "/sensorLog.do", thead : "<thead><th>위치</th><th>온도</th><th>연기</th><th>불꽃</th><th>불꽃감지 위치</th><th>날짜</th><th>시간</th></thead>"},
		{url : "/sensordetectionLog.do", thead : "<thead><th>위치</th><th>결과</th><th>사진url</th><th>날짜</th><th>시간</th></thead>"},
		{url : "/tensorflowLog.do", thead : "<thead><th>위치</th><th>결과</th><th>추론시간</th><th>날짜</th><th>시간</th></thead>"},
		{url : "/telecomLog.do", thead : "<thead><th>위치</th><th>결과</th><th>날짜</th><th>시간</th></thead>"}
	];
		$(document).ready(function() {
			var selected;
			$("#list").change(function(){
				$("#label").remove();
				$("#result").remove();
				selected = $("#list option:checked").val();
				if(selected == "1" || selected == "2" || selected == "3"){
					$("#location").after("<label id=\"label\">결과 </label><select id=\"result\"><option value=\"\">전체</option><option value=\"Y\">Y</option><option value=\"N\">N</option></select>");
				}
			});
			if(selected == "1" || selected == "2" || selected == "3") console.log(selected);
			$("#search").click(function(){	
				var startDate = getFormatDate($("#fromDate").datepicker("getDate"));
				var endDate = getFormatDate($("#toDate").datepicker("getDate"));
				var result = $("#result option:checked").val();
				if(selected == "-1" || startDate == null || startDate == undefined || endDate == null || endDate == undefined ) return;
				var data = {
					table : tableData[selected].url,
					startDate : startDate,
					endDate : endDate,
					location : $("#location").val(),
					result : result
				};
				$.ajax({
					type : "POST",
					url :  data.table,
					data : JSON.stringify(data),
					dataType : "json",
					contentType : "application/json; charset=UTF-8",
					success : function(json) {
						var temp = "<tbody>";
						for(var i=0; i<json.length; i++){
							temp += "<tr>";
							for(var j=0; j<Object.keys(json[i]).length; j++){
								temp += "<th>"+json[i][Object.keys(json[i])[j]]+"</th>"
							}
							temp += "</tr>";
						}
						temp += "<tbody>";
						console.log(tableData[selected].thead+temp);
						$("#table").empty();
						$("#table").append(tableData[selected].thead+temp);
						
					},
					error : function(xhr, status, error) {
						console.log("error");
					}
				});
			});
			//오늘 날짜를 출력
			$("#today").text(new Date().toLocaleDateString());

			//datepicker 한국어로 사용하기 위한 언어설정
			$.datepicker.setDefaults($.datepicker.regional['ko']);

			// 시작일(fromDate)은 종료일(toDate) 이후 날짜 선택 불가
			// 종료일(toDate)은 시작일(fromDate) 이전 날짜 선택 불가

			//시작일.
			$('#fromDate').datepicker(
					{
						showOn : "both", // 달력을 표시할 타이밍 (both: focus or button)
						buttonImage : "images/calendar.png", // 버튼 이미지
						buttonImageOnly : true, // 버튼 이미지만 표시할지 여부
						buttonText : "날짜선택", // 버튼의 대체 텍스트
						dateFormat : "yy-mm-dd", // 날짜의 형식
						changeMonth : true, // 월을 이동하기 위한 선택상자 표시여부
						changeYear : true,
						//minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
						onClose : function(selectedDate) {
							// 시작일(fromDate) datepicker가 닫힐때
							// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
							$("#toDate").datepicker("option",
									"minDate", selectedDate);
						}
					});

			//종료일
			$('#toDate').datepicker(
					{
						showOn : "both",
						buttonImage : "images/calendar.png",
						buttonImageOnly : true,
						buttonText : "날짜선택",
						dateFormat : "yy-mm-dd",
						changeMonth : true,
						changeYear : true,
						//minDate: 0, // 오늘 이전 날짜 선택 불가
						onClose : function(selectedDate) {
							// 종료일(toDate) datepicker가 닫힐때
							// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
							$("#fromDate").datepicker("option",
									"maxDate", selectedDate);
						}
					});
				
				
		
			
			function getFormatDate(date){
				if(date == null) return;
				var year = date.getFullYear();                                 //yyyy
				var month = (1 + date.getMonth());                     //M
				month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
				var day = date.getDate();                                        //d
				day = day >= 10 ? day : '0' + day;                            //day 두자리로 저장
				return  year + '-' + month + '-' + day;
			}
		});
	</script>
</body>
</html>