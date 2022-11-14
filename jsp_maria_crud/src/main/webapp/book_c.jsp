<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서적관리 시스템 - 입력</title>
</head>
<body>

<h1>서적관리시스템 - 자료입력(C)</h1>
<hr>
<h2>book_id 값은 DB에서 결정(auto increment)</h2>
<form method= "post" action="./book_dao.jsp">
	<br>서적명 : <input type = "text" name= "title" size = 30>
	<br>출판사 : <input type = "text" name= "publisher" size = 30>
	<br>출판년도 : <input type = "text" name= "year" size = 30>
	<br>가격 : <input type = "text" name= "price" size = 30>
	<br><input type = "hidden" name= "actionType" value = "C">
	<br><input type = "submit" value ="저장">
</form>

<br><a href = "./index.jsp">홈으로 돌아가기</a>

</body>
</html>