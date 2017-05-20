<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>샵링커 연동 페이지(로그인)</title>

<script language="javascript">

</script>
</head>
<body marginheight=0 marginwidth=0 topmargin=0 leftmargin=0 onLoad="javascript:nemo.submit();">
<form name='nemo' method='post' action='http://admin.shoplinker.co.kr/index.html'>
	<input type='hidden' name='mode' value='login'/> 
	<input type='hidden' name='return_url' value='<c:out value="${return_url}"/>' />
	<input type='hidden' name='user_id' value='<c:out value="${user_id}"/>'/> 
	<input type='hidden' name='passwords' value='<c:out value="${password}"/>'/>
	</form>
</body>
</html>
