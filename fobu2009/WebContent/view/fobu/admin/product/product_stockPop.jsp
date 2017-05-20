<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<title>카테고리 상세</title>

<script language="javascript">
$(function() {

	if(${rtnVal} < 0){
		showMsgNClose("수정중 오류가 발생했습니다.");
	}
	else if(${rtnVal} > 0){
		
		opener.afterInit();
		window.close();
		
	}
});
function save(){
	
	var frm = document.stockPopFrm;
	
	frm.submit();
}

function add(){
	var c = "";
	c = "<tr height='35px'>"			
	   +"	<td align='center' bgcolor='#FFFFFF'>"
	   +"		<input type='hidden' id='seq' name='seq' value='0'/>"
	   +"		<input type='text' class='number' id='sizeOpt' name='sizeOpt' style='text-align: right;'/>"
	   +"	</td>"
	   +"	<td align='center' bgcolor='#FFFFFF'>"
	   +"		<input type='text' class='number' id='sizeOptStock' name='sizeOptStock' style='text-align: right;'/>"
	   +"	</td>"
	   +"</tr>";
	
	$("#sizeOptStockList").append(c);

	$("[name=sizeOptStock]").keyup(function(event){
		$(this).val($(this).getOnlyNumeric());	
		calStock();	
	});
}
function calStock(){
	var tempStock = 0;
	$("[name=sizeOptStock]").each(function(){
		tempStock += parseInt($(this).val());
	});
	
	$("#realStock").val(tempStock);
}
</script>
</head>
<body>
<form name="stockPopFrm" method="post" action="/admin/product/product_stockPop_save.action" >
<input type="hidden" id="uSeq" name="uSeq" value="<c:out value="${uSeq}"/>"/>
<table width="400" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣재고량 수정</td>
	</tr>
</table>
<table id="sizeOptStockList" width="400" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
	<tr>
		<td height='23' align='center' bgcolor='e7e7e7' class='tx12B' width='200'>사이즈 옵션</td>
		<td height='23' align='center' bgcolor='e7e7e7' class='tx12B'>수량</td>
	</tr>
	<c:forEach var="stockList" items="${listStock}">
		<tr height="35px">			
			<td align='center' bgcolor='#FFFFFF'>
				<input type="hidden" id="seq" name="seq" value="<c:out value="${stockList.seq}"/>"/>
				<input type="text" class='number' id="sizeOpt" name="sizeOpt" value="<c:out value="${stockList.sizeOpt}"/>" style="text-align: right;"/>
			</td>
			<td align='center' bgcolor='#FFFFFF'>
				<input type="text" class='number' id="sizeOptStock" name="sizeOptStock" value="<c:out value="${stockList.sizeOptStock}"/>" style="text-align: right;"/>
			</td>
		</tr>
	</c:forEach>
</table>
<div style="height:5px;"></div>
<table width="400" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
<tr height="35px">
	<td align='center' bgcolor='#FFFFFF' width='200'>총</td>
	<td align='center' bgcolor='#FFFFFF'>
		<input type="text" class='number' id="realStock" name="realStock" value="<c:out value="${realStock}"/>" style="text-align: right;"/>
	</td>
</tr>
</table>
<table border="0" align="center">
 	<tr height="35px">
	 	<td bgcolor='#FFFFFF' style="text-align:center;">
	 		<input type="button" value="추가" onclick="add();">
	 		<input type="button" value="수정" onclick="save();">
	 		<input type="button" value="닫기" onclick="window.close();">
	 	</td>
 	</tr>
</table>
<div class="div_space"></div>
</form>
</body>
</html>
