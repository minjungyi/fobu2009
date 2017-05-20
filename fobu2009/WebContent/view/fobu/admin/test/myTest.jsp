<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% Connection con = null;
try {
	String jdbcUrl = "jdbc:mysql://127.0.0.1:3306/fobu2009";
	String dbId = "fobu2009";
	String dbPw = "eoqkr1212";
	
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
	out.println("OK 연결 성공.");
}catch(Exception e){
	e.printStackTrace();
}%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title><c:out value="${SHEET_MSG}"/></title>
</head>
<body>

</body>
</html>