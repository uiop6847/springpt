<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>이메일 보내기</h2>
	<form method="post" action="/email/send.do">
		 발신자 이름: <input type="text" name="senderName" class="form-control" /><br />
		 발신자 이메일: <input type="text" name="senderMail" class="form-control" /><br />
		 수신자 이메일: <input type="text" name="receiveMail" class="form-control" /><br />
		 제목: <input type="text" name="subject" class="form-control" /><br />
		 내용: <textarea name="message" rows="5" cols="80"></textarea> <br /><br />
		 <input type="submit" value="전송" class="btn btn-primary" />
	</form>

	<span style="color:red;">${msg}</span>
</body>
</html>