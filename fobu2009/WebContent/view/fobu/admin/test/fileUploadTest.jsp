<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>업로드 테스트</title>
</head>
<body>
<form action="/upload.action" method="post" enctype="multipart/form-data">
<p>
    <label for="file">파일1 </label>
    <input type="file" name="file">
</p>
<p>
    <input type="submit" value="전송"/>
</p>
</form>
</body>
</html>

