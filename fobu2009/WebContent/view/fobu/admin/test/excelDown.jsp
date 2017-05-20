<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="/css/yong.css" rel="stylesheet" type="text/css">
<title>엑셀다운</title>

<script language="javascript">

function selected(){
	location.href("/util/download.action?key=&fileName=myExcelTest.xls&orgFileName=myExcelTest.xls");
	//window.close();
}

</script>
</head>
<body onload="selected();">
<form name="selFrm" method="post" onsubmit="return false">
<table width="669" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
	</tr>	
</table>	
</form>
</body>
</html>
