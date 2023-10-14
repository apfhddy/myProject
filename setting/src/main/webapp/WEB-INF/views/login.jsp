<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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
	<script type="text/javascript">
		window.onpageshow = function(event) {
		    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
				window.location.reload()
		    }
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath}/Start",
			type:"POST"
		})
	</script>
</body>
</html>