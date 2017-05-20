<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>::::::::: FOBU 관리자페이지 입니다 :::::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script language="javascript">
</script>
</head>
<body>
<form name="productfrm" method="post" action="product_write.action" target="iframe_proc">
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 주문상세조회</td>
	</tr>
</table>
<table width="700" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
	<tr>
		<td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">제품명</td>
		<td width="35%" bgcolor="#FFFFFF">
			<span style="padding : 1 0 3 0">
	  		<c:out value="${totalOrderDetailList[0].product}"/>
			</span>
		</td>
		<td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">상태</td>
		<td width="35%" bgcolor="#FFFFFF">
			<span style="padding : 1 0 3 0">
	  		<c:out value="${totalOrderDetailList[0].orderStat}"/>
			</span>
		</td>
	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">주문자</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<c:out value="${totalOrderDetailList[0].orderer}"/>
    		</span>
   		</td>
    	<td align="center" bgcolor="e7e7e7" class="tx12B">수령자</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="receiver" name="receiver" style="width:90%;" value="<c:out value="${totalOrderDetailList[0].receiver}"/>"/>
    		</span>
   		</td>
  	</tr>
  	<tr>
	    <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">전화번호</td>
	    <td bgcolor="#FFFFFF">
	    	<span style="padding : 1 0 3 0">
	      	<input type="text" id="receiverTel" name="receiverTel" style="width:90%;" value="<c:out value="${totalOrderDetailList[0].receiverTel}"/>"/>
	    	</span>
    	</td>
	    <td align="center" bgcolor="e7e7e7" class="tx12B">핸드폰번호</td>
	    <td bgcolor="#FFFFFF">
	    	<span style="padding : 1 0 3 0">
	   		<input type="text" id="receiverHp" name="receiverHp" style="width:90%;" value="<c:out value="${totalOrderDetailList[0].receiverHp}"/>"/>
	    	</span>
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">배송주소</td>
    	<td bgcolor="#FFFFFF" colspan="3">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="receiverZipcode" name="receiverZipcode" style="width:90%;" value="[<c:out value="${totalOrderDetailList[0].receiverZipcode}"/>] <c:out value="${totalOrderDetailList[0].receiverAddress}"/>"/>
    		</span>
   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">업체명</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<c:out value="${totalOrderDetailList[0].shopId}"/>
    		</span>
   		</td>
    	<td height="23" align="center" bgcolor="e7e7e7" class="tx12B">수량</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" class="number" id="orderQy" name="orderQy" style="width:90%;" value="<c:out value="${totalOrderDetailList[0].orderQy}"/>"/>
   			</span>
 		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">원가</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<c:out value="${totalOrderDetailList[0].basePrice}"/>
    		</span>
   		</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B">판매가</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text" class="price" id="orderPrice" name="orderPrice" style="width:90%;" value="<c:out value="${totalOrderDetailList[0].orderPrice}"/>"/>
    		</span>
   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">수집</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<c:out value="${totalOrderDetailList[0].siteCode}"/>
    		</span>
   		</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B">배송</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<c:out value="${totalOrderDetailList[0].deliverType}"/>
    		</span>
   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">배송메세지</td>
    	<td bgcolor="#FFFFFF" colspan="3">
    		<span>
    		<textarea name='managerMemo' cols='60' rows='6' readOnly>
    			<c:out value="${totalOrderDetailList[0].managerMemo}"/>
    		</textarea>
      		</span>
   		</td>
  	</tr>
</table>

<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="40" align="center" class="tx14B" style="padding-left:10px">
			<a href="javascript:save();"><img src="/images/button/btn_confirm.gif"></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#"><img src="/images/button/btn_cancel.gif"></a>
		</td>
	</tr>
</table>
</form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
</body>
</html>


