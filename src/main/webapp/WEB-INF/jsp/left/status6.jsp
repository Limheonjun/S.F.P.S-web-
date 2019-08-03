<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>웹소켓 테스트 페이지3</title>
</head>
<body>
	<input class="inputMsgBox" style="width: 250px;" type="text"
		onkeypress="inputMsgBox_onkeypress()">
	<input class="sendButton" value="Send" type="button"
		onclick="sendButton_onclick()">
	<input class="disconnectButton" value="Disconnect" type="button"
		onclick="disconnectButton_onclick()">
	<br />
	<textarea class="chatBoxArea" style="width: 100%;" rows="5" cols="50"
		readonly="readonly"></textarea>
</body>
</html>