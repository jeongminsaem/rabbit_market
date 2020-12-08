<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Google Login 완료</h1>
<div th:text="'TOKEN : ' + ${token}"></div>
<div th:text="'Email : ' + ${email}"></div>

${email}

</body>
</html>