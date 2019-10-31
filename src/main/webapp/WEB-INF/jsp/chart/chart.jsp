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

.ui-datepicker-calendar {
    display: none;
    }​
</style>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.js"></script>
<link rel="stylesheet" href="../../css/yearpicker.css">
<script type="text/javascript" src="../../js/yearpicker.js" async></script>
<title>Insert title here</title>
</head>
<body>
	<select id="list">
		<option value="-1">통계선택</option>
		<option value="0">센서통계</option>
		<option value="1">Opencv통계</option>
		<option value="2">텐서플로우통계</option>
		<option value="3">통신통계</option>
	</select>
	
	<label>기간</label>
	<select id="periodlist">
		<option value="0">전체</option>
		<option value="1">월별통계</option>
		<option value="2">연간통계</option>
	</select>
	
	<button id="search">검색</button>
	

	
	
	<label>위치 </label>
	<input type="text" id="location" placeholder="기본값 : 전체">

	<div id=chart style="height: 50%; width: 50%">
		<canvas id="myChart" width="400" height="400"></canvas>
	</div>
	<script>
	var tableData = [
		{url : "/sensordataChart.do", type : "pie"},
		{url : "/sensordetectioncheckChart.do", type : "bar"},
		{url : "/tensorflowcheckChart.do", type : "bar"},
		{url : "/telecomcheckChart.do", type : "bar"}
	];
	
		$(document).ready(
				function() {
					var listSelected;
					$("#list").change(function(){
						listSelected = $("#list option:checked").val();
						if(listSelected == -1){
							$("#periodLabel").remove("");
							$(".monthpicker").remove();
						}
					});
					
					
					var date;
					$("#periodlist").change(function(){
						var plistSelected = $("#periodlist option:checked").val();
						console.log(plistSelected);
						if(listSelected == -1) return;
						$("#periodLabel").remove("");
						$(".monthpicker").remove();
						if(plistSelected == "1"){
							$("#periodlist").after("<label id=\"periodLabel\">기간 </label><input type=\"text\" class=\"monthpicker\" value=\"\">");
							$(".monthpicker").datepicker({ 
								dateFormat: 'yy-mm',
								changeMonth: true,
							    changeYear: true,
							    showButtonPanel: true,

							    onClose: function(dateText, inst) {  
						            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val(); 
						            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
						            date = getFormatDate(new Date(year, month, 1))+"%";
						            console.log(date);
						            $(this).datepicker('setDate', new Date(year, month, 1)); 
						        }
							});
							
							$(".monthpicker").focus(function () {
								$(".ui-datepicker-calendar").hide();
								$("#ui-datepicker-div").position({
									  my: "center top",
									  at: "center bottom",
									  of: $(this)
								});
								
							});
						} else if(plistSelected == "2"){
							$("#periodlist").after("<label id=\"periodLabel\">기간 </label><input type=\"text\" class=\"monthpicker\" value=\"\">");
							$('.monthpicker').datepicker({
								changeMonth: false,
						        changeYear: true,
						        showButtonPanel: true,
						        dateFormat: 'yy',
						        onClose: function(dateText, inst) { 
						            date = $("#ui-datepicker-div .ui-datepicker-year :selected").val()+"%";
						            console.log(date);
						            $(this).datepicker('setDate', new Date(date, 1));
						        }
							});
							
							$(".monthpicker").focus(function () {
				                $(".ui-datepicker-month").hide();
				            });
						} else {
							date = "";
						}
					});
					
					var myChart = null;
					$("#search").click(function(){					
						var data = {
							location : $("#location").val(),
							date : date
						};
						$.ajax({
							type : "POST",
							url :  tableData[$("#list option:selected").val()].url,
							data : JSON.stringify(data),
							dataType : "json",
							contentType : "application/json; charset=UTF-8",
							success : function(json) {
								console.log(json);
								var labels = [];
								var datas = [];
								for(var i=0; i<json.length; i++){
									for(var j=0; j<Object.keys(json[i]).length; j++){
										labels.push(Object.keys(json[i])[j]);
										datas.push(json[i][Object.keys(json[i])[j]]);
									}
								}
								console.log("labels : "+JSON.stringify(labels) + ",  datas : "+JSON.stringify(datas));
								if(myChart) myChart.destroy();
									var ctx = document.getElementById('myChart').getContext('2d');
									var config = {
											type : tableData[$("#list option:selected").val()].type,
											data : {
												labels : labels,
												datasets : [ {
													label : "센서 통계",
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
												tooltips: {
													  callbacks: {
													    label: function(tooltipItem, data) {
													      //get the concerned dataset
													      var dataset = data.datasets[tooltipItem.datasetIndex];
													      //calculate the total of this data set
													      var total = dataset.data.reduce(function(previousValue, currentValue, currentIndex, array) {
													        return previousValue + currentValue;
													      });
													      //get the current items value
													      var currentValue = dataset.data[tooltipItem.index];
													      //calculate the precentage based on the total and current item, also this does a rough rounding to give a whole number
													      var percentage = Math.floor(((currentValue/total) * 100)+0.5);
													      return percentage + "% / "+currentValue+"건";
													    }
													  }
													} 
											}
									}
									myChart = new Chart(ctx, config);
							},
							error : function(xhr, status, error) {
								console.log("error");
							}
						});
					});
					
					
					
					
					
					
					
					

					function getFormatDate(date){
						if(date == null) return;
						var year = date.getFullYear();                                 //yyyy
						var month = (1 + date.getMonth());                     //M
						month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
						return  year + '-' + month;
					}
					
				});


	</script>
</body>
</html>