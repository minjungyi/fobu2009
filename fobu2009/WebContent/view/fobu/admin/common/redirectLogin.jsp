<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

    try {
        alert("사용자 세션 정보가 유효하지 않습니다.\n로그인 화면으로 이동합니다.");
        location.href = "/admin/index.html";
       
    } catch(ex) {
    	alert("사용자 세션 정보가 유효하지 않습니다.\n로그인 화면으로 이동합니다.");
        location.href = "/admin/index.html";
    }
</script>
</head>
</html>

