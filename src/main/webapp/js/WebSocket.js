var g_webSocket = null;
window.onload = function() {
	g_webSocket = new WebSocket("ws://localhost:7647/websocket");

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
		$("h1").text(message.data);
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
	console.log(JSON.stringify(data));
	var chatBoxArea = document.getElementsByClassName("chatBoxArea");
	if (json.id == '1') {
		// 센서 데이터
		$.ajax({
			type : "POST",
			url : "/sensordata.do",
			data : data,
			dataType : "json",
			success : function(xml) {
				console.log("success");
			},
			error : function(xhr, status, error) {
				console.log("error");
			}
		});
		chatBoxArea[0].value = "시간 : " + data.date + " 위치 : " + data.location
				+ " 온도 : " + data.temperature + " 불꽃 : " + data.flame
				+ " 연기 : " + data.smoke + "\n";
		chatBoxArea[0].scrollTop = chatBoxArea[0].scrollHeight;
	} else if (json.id == '2') {
		// 오탐 데이터
		$.ajax({
			type : "POST",
			url : "/sensordectioncheck.do",
			data : data,
			dataType : "json",
			success : function(xml) {
				console.log("success");
			},
			error : function(xhr, status, error) {
				console.log("error");
			}
		});
		chatBoxArea[1].value = "시간 : " + data.date + " 위치 : " + data.location
				+ " 결과 : " + data.result + " url : " + data.filepath + "\n";
		chatBoxArea[1].scrollTop = chatBoxArea[1].scrollHeight;
	} else if (json.id == '3') {
		// 텐서플로우 데이터
		$.ajax({
			type : "POST",
			url : "/tensorflowcheck.do",
			data : data,
			dataType : "json",
			success : function(xml) {
				console.log("success");
			},
			error : function(xhr, status, error) {
				console.log("error");
			}
		});
		chatBoxArea[2].value = "시간 : " + data.date + " 위치 : " + data.location
				+ " 결과 : " + data.result + " url : " + data.inferencetime
				+ "\n";
		chatBoxArea[2].scrollTop = chatBoxArea[2].scrollHeight;
	}
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