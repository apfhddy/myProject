<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center" style="margin-top: 20%;">
		<form action="${pageContext.request.contextPath }/login" method="post">
			<table border="1" style="margin-bottom: 2%;">
				<tr>
					<th>아이디</th>
					<td><input type = "text" name = "id"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type = "password" name = "pw"></td>
				</tr>
			</table>
			<input type = "button" value="로그인" onclick="let id = this.form.id.value; let pw = this.form.pw.value;   if(id == '' || pw == '' ){alert('나가라')}else{this.form.submit()}     ">
		</form>		
	</div>
</body>
</html>