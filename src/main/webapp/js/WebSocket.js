var g_webSocket = null;
var hash;
var audio = null;
var wo="";
window.onload = function() {
	g_webSocket = new WebSocket("ws://58.127.197.205:7647/websocket");
	audio = new Audio('../audio/alarm.mp3');
	hash = [];
	var mData;
	
	
	/**
	 * 웹소켓 사용자 연결 성립하는 경우 호출
	 */
	g_webSocket.onopen = function(message) {
		// addLineToChatBox("Server is connected.");
	};

	/**
	 * 웹소켓 메시지(From Server) 수신하는 경우 호출
	 */
	g_webSocket.onmessage = function(message) {
		mData = message;
		addLineToChatBox(message.data);
	};

	/**
	 * 웹소켓 사용자 연결 해제하는 경우 호출
	 */
	g_webSocket.onclose = function(message) {
		// addLineToChatBox("Server is disconnected.");
	};

	/**
	 * 웹소켓 에러 발생하는 경우 호출
	 */
	g_webSocket.onerror = function(message) {
		addLineToChatBox("Error!");
	};
	
	$("div").on('click', 'button', function(){
		var json = JSON.parse(mData.data);
		var data = json.data;
		removeData(data.location);
		$( 'div' ).remove('.alarm_content');
		
	});
	
}



/**
 * 채팅 박스영역에 내용 한 줄 추가
 */
function addLineToChatBox(_line) {
	if (_line == null) {
		_line = "";
	}
	var json = JSON.parse(_line);
	var data = json.data;
	
	divideChatBox(json.id, data);
	manage(json.id, data);
	updateData(json.id, data.location, data);
	
	if(checkSensorData(data) && (findIndex(data.location) == -1)){
		insertData(data.location, json, data);
		zoomMap(json.lat, json.lng);
		$(".alarm_container").append(
			`
			<div class="alarm_content">
				<div class="alarm">
					<img src="../images/fire.png" alt="My Image" width="50" height="70">
				</div>
				<div class="alarm" id="test">
					<h1>`+data.location+` 화재발생</h1>
				</div>
			</div>
			`);
		var blink = setInterval(function() { 
			 $(".alarm_content").fadeOut('slow', 'linear').fadeIn('slow', 'linear'); 
		},1500);
		// 알림메시지 점멸
		
		
		// 오디오 재생
		audio.play();
			
	}

}



function manage(id, data){
	var url = ["/sensordata.do","/sensordetectioncheck.do","/tensorflowcheck.do"];
	
	$.ajax({
		type : "POST",
		url : url[id],
		data : JSON.stringify(data),
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success : function(xml) {
			console.log("success");
		},
		error : function(xhr, status, error) {
			console.log("error");
		}
	});
}

/**
 * Send 버튼 클릭하는 경우 호출 (서버로 메시지 전송)
 */
function sendButton_onclick() {
	var inputMsgBox = document.getElementsByClassName("inputMsgBox");
	for (var i = 0; i < inputMsgBox.length; i++) {
		if (inputMsgBox[i] == null || inputMsgBox[i].value == null
				|| inputMsgBox[i].value.length == 0) {
			continue;
			// return false;
		}
	}

	var chatBoxArea = document.getElementsByClassName("chatBoxArea");

	for (var i = 0; i < chatBoxArea.length; i++) {
		if (g_webSocket == null || g_webSocket.readyState == 3) {
			chatBoxArea[i].value += "Server is disconnected.\n";
			continue;
			// return false;
		}
	}

	// 서버로 메시지 전송
	for (var i = 0; i < inputMsgBox.length; i++) {
		g_webSocket.send(inputMsgBox[i].value);
		inputMsgBox[i].value = "";
		inputMsgBox[i].focus();
	}

	return true;
}

/**
 * Disconnect 버튼 클릭하는 경우 호출
 */
function disconnectButton_onclick() {
	if (g_webSocket != null) {
		g_webSocket.close();
	}
}

/**
 * inputMsgBox 키입력하는 경우 호출
 */
function inputMsgBox_onkeypress() {
	if (event == null) {
		return false;
	}

	// 엔터키 누를 경우 서버로 메시지 전송
	var keyCode = event.keyCode || event.which;
	if (keyCode == 13) {
		sendButton_onclick();
	}
}

//
function insertData(location, json, data){
	if(findIndex(location) == -1){
		hash.push({"location" : location,
				   "gps" : {
					   "lat" : json.lat,
					   "lng" : json.lng
				   },
				   "data" : {
						"sensor" : {
									"temperature" : data.temperature,
									"smoke" : data.smoke,
									"flame" : data.flame,
									"flame_num" : data.flame_number,
									"date" : data.date,
									"time" : data.time
									},
						"opencv" : 
									{
										"check" : 0,
										"data" : ""
									},
						"tensor" :  {
										"check" : 0,
										"data" : ""
									}
						}
				  });
	}
	
}

function findIndex(location){
	for(var i=0; i<hash.length; i++){
		if(hash[i].location == location){
			return i;
		}
	}
	return -1;
}

function removeData(key){
	var index = findIndex(key);
	hash.splice(index, 1);
}

function updateData(id, location, data){
	var index = findIndex(location);
	if(index == -1) {
		console.log("findindex : "+findIndex(location));
		return;
	}
	console.log("index : "+index);
	console.log("hash[index] : "+JSON.stringify(hash[index]));
	if(id == '1' && hash[index].data.opencv.check == 0){
		popupImage(data);
		hash[index].data.opencv.check = 1;
		hash[index].data.opencv.data = data;
		var specs = "width=100, height=100, top="+((window.screen.height / 2) - (400 / 2))+",left="+((window.screen.width / 2) - (500 / 2));
		$(".alarm_content").append(`
				<div class="alarm">
					<h5>오탐여부</h5>
					<h5>`+data.result+`</h5>
					<a href=`+data.filepath+` onclick="window.open(this.href, `+specs+`);return false;">링크</a>
				</div>`);
	} else if(id == '2' && hash[index].data.tensor.check == 0){
		hash[index].data.tensor.check = 1;
		hash[index].data.tensor = data;
		$(".alarm_content").append(`
				<div class="alarm">
					<h5>인공지능 판단결과</h5>
					<h5>`+data.result+`</h5>
				</div>
				<div class="alarm">
					<button>확인</button>
				</div>
				`);
	}
	
}

function popupImage(data){
	var popupX = (window.screen.width / 2) - (500 / 2);
	// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	
	var popupY= (window.screen.height / 2) - (400 / 2);
	// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	window.open(data.filepath, data.location+"사진", 'status=no, height=400, width=500, left='+ popupX + ', top='+ popupY);
}

function divideChatBox(id, data){
	var chatBoxArea = document.getElementsByClassName("chatBoxArea");
	
	if(id == '0'){
		chatBoxArea[0].value = "시간 : " + data.date + " 위치 : " + data.location
		+ " 온도 : " + data.temperature + " 불꽃 : " + data.flame
		+ " 연기 : " + data.smoke + "\n";
	chatBoxArea[0].scrollTop = chatBoxArea[0].scrollHeight;
	} else if(id == '1'){
		chatBoxArea[1].value = "시간 : " + data.date + " 위치 : " + data.location
		+ " 결과 : " + data.result + " url : " + data.filepath + "\n";
		chatBoxArea[1].scrollTop = chatBoxArea[1].scrollHeight;
	} else if(id == '2'){
		chatBoxArea[2].value = " 위치 : " + data.location + " 결과 : " + data.result + 
		" 추론시간 : " + data.inferencetime + "날짜 : " + data.date + "시간 : " + data.time 
				+ "\n";
		chatBoxArea[2].scrollTop = chatBoxArea[2].scrollHeight;
	}

}

function zoomMap(lat, lng){
	var center = new naver.maps.LatLng(lat, lng);
	map.setCenter(center);
	map.setZoom(11, true);
}

function checkSensorData(data){
	if((data.temperature >= 50 || data.flame <= 300 || data.smoke >= 210)){
		return 1;
	} else return 0;
}
