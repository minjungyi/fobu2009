<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>::::::::: 묶음 상품정보 입니다 :::::::::</title>
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
<form name="totalOrderFrm" method="post" onsubmit="return false">
<input type="hidden" name="orderSeqStr">
<input type="hidden" name="pageNumTmp" value="1">
<table width="900" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 묶음 상품정보</td>
  </tr>
</table>
<table width="900" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_total_order">
<tr>
<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>이미지</td>
<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>거래처</td>
<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>수집</td>
<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>주문자</td>
<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>수령자</td>
<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>업체명</td>
<td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>
<td width='28' align='center' bgcolor='e7e7e7' class='tx12B'>수량</td>
<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>재고</td>
<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>원가</td>
<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>판매가</td>
<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>마진</td>
<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>%</td>
<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>배송</td>
</tr> 
<c:forEach items="${requestScope.packageInfolList}" var="list" varStatus="status">
<tr bgcolor='#FFFFFF' style=cursor:hand;>
<td align='center' ><img src='/images/sdata/Bimg/<c:out value="${list.titleImageFile}"/>' width='100' height='100'></td>
<td align='center' ></td>
<td align='center' ><img src='/images/<c:out value="${list.siteImg}"/>.gif'></td>				  
<td align='center' ><c:out value="${list.orderer}"/></td>
<td align='center' ><c:out value="${list.receiver}"/></td>
<td align='center' ><img src='/images/<c:out value="${list.shopImg}"/>.gif'></td>
<td align='center' ><c:out value="${list.product}"/></td>
<td align='center' ><c:out value="${list.orderQy}"/></td>
<td align='center' ></td>
<td align='center' ><c:out value="${list.originalPrice}"/></td>
<td align='center' ><c:out value="${list.orderPrice}"/></td>
<td align='center' ></td>
<td align='center' ></td>
<td align='center' ><c:out value="${list.deliverType}"/></td>
</tr>
</c:forEach>
</table>

<div class="page_wrap">
	<div class="page" id="page" >
	</div>
</div><!-- page_wrap -->
</form>
</body>
</html>

