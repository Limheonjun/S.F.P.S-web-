<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
/*datepicker에서 사용한 이미지 버튼 style적용*/
img.ui-datepicker-trigger {
	margin-left: 5px;
	vertical-align: middle;
	cursor: pointer;
}
</style>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<title>Insert title here</title>
</head>
<body>
	<select id="list">
		<option value="">통계선택</option>
		<option value="/chart.do">센서통계</option>
		<option value="/test.do">오탐통계</option>
		<option value="TensorflowCheck">텐서플로우통계</option>
		<option value="TelecomCheck">통신통계</option>
	</select>

	<label for="fromDate">시작일</label>
	<input type="text" name="fromDate" id="fromDate"> ~
	<label for="toDate">종료일</label>
	<input type="text" name="toDate" id="toDate">
	<button id="search">검색</button>

	<div id=chart style="height: 30%; width: 100%">
		<canvas id="myChart" width="400" height="400"></canvas>
	</div>
	<script>
		$(document).ready(
				function() {	
					var myChart;
					$("#search").click(function(){					
						var selected = $("#list option:checked").text();
						var startDate = getFormatDate($("#fromDate").datepicker("getDate"));
						var endDate = getFormatDate($("#toDate").datepicker("getDate"));
						var data = {
							table : $("#list option:checked").val(),
							startDate : startDate,
							endDate : endDate
						};
						$.ajax({
							type : "POST",
							url :  $("#list option:checked").val(),
							data : JSON.stringify(data),
							dataType : "json",
							contentType : "application/json; charset=UTF-8",
							success : function(json) {
								var labels = [];
								var datas = [];
								for(var i=0; i<json.length; i++){
									labels.push(json[i].value);
									datas.push(json[i].count);
								}
								console.log("datas : "+JSON.stringify(datas));
								console.log("labels : "+labels);
								console.log(JSON.stringify(json))
								
								if(!myChart){
									var ctx = document.getElementById('myChart').getContext('2d');
									var config = {
											type : 'bar',
											data : {
												labels : labels,
												datasets : [ {
													label : $("#list option:checked").text(),
													data : datas,
													backgroundColor : [
															'rgba(255, 99, 132, 0.2)',
															'rgba(54, 162, 235, 0.2)',
															'rgba(255, 206, 86, 0.2)',
															'rgba(75, 192, 192, 0.2)',
															'rgba(153, 102, 255, 0.2)',
															'rgba(255, 159, 64, 0.2)' ],
													borderColor : [
															'rgba(255, 99, 132, 1)',
															'rgba(54, 162, 235, 1)',
															'rgba(255, 206, 86, 1)',
															'rgba(75, 192, 192, 1)',
															'rgba(153, 102, 255, 1)',
															'rgba(255, 159, 64, 1)' ],
													borderWidth : 1
												} ]
											},
											options : {
												maintainAspectRatio : false,
												layout : {
													padding : {
														left : 50,
														right : 0,
														top : 0,
														bottom : 0
													}
												},
												scales : {
													yAxes : [ {
														ticks : {
															beginAtZero : true
														}
													} ]
												}
											}
											
										};
									myChart = new Chart(ctx, config);
								} else {
									console.log("1");
									myChart.config.data.datasets[0].label = $("#list option:checked").text();
									myChart.config.data.labels = labels;
									myChart.config.data.datasets[0].data = datas;
									myChart.update();
								}
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
					
				});
		
		function getFormatDate(date){
			var year = date.getFullYear();                                 //yyyy
			var month = (1 + date.getMonth());                     //M
			month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
			var day = date.getDate();                                        //d
			day = day >= 10 ? day : '0' + day;                            //day 두자리로 저장
			return  year + '-' + month + '-' + day;
		}

	</script>
</body>
</html>