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
var openPop = Array();
	function onDataSubmit(){
		openWindow();
		nemo.start.value		= 0;
		nemo.mode.value			= 'join_modify';
		nemo.target				= 'Window_j20080123144649b58ad6';
		nemo.action				= 'http://linkage.shoplinker.co.kr/Product/join_database_job_join_modify_complex.html';
		nemo.submit();
		return false;
	}
	function openWindow(){
		   openPop[openPop.length] = window.open("http://linkage.shoplinker.co.kr/pub/null.html", "Window_j20080123144649b58ad6", "width=540,height=300,left=150,top=250,scrollbars=yes");
		   document.attachEvent("onmousedown", ieznInit);
		}
	function ieznInit(){
		if(openPop.length>0){
			for(var i=0; i<openPop.length; i++) {
				if( openPop[i] && !openPop[i].closed ){
					openPop[i].focus();
				}
			}
		}	else	{
			document.detachEvent("onmousedown", ieznInit);
		}
	}
	function onSelectedTable(){
		var val = nemo.val.value;
		nemo.action = '/admin/shoplinker/shoplinker_statusLink.html?val='+val;
		nemo.target = '_self';
		nemo.submit();	
		
	}
	function onToFobuDataSubmit(){
		var val = nemo.val.value;
		nemo.action = '/admin/shoplinker/shoplinker_statusLink.html?val='+val+'&mode=update';
		nemo.target = '_self';
		nemo.submit();
	}
</script>
</head>
<body marginheight=0 marginwidth=0 topmargin=0 leftmargin=0 >
<form name='nemo' method='post' >
	<input type='hidden' name='val' id='val' value='<c:out value="${val}"/>'/>
	<input type='hidden' name='start' value=''>
	<input type='hidden' name='mode' value=''>
	<c:forEach var='linkProductList' items='${listOpenMarketMargin}'>
		<input type='hidden' name=No[] value='<c:out value="${linkProductList.shopCode}"/>'>
		<input type='hidden' name='market_price_<c:out value="${linkProductList.shopCode}"/>' value='<c:out value="${linkProductList.mallPrice}"/>'>
		<input type='hidden' name='sale_price_<c:out value="${linkProductList.shopCode}"/>' value='<c:out value="${linkProductList.mallPrice}"/>'>
		<input type='hidden' name='supply_price_<c:out value="${linkProductList.shopCode}"/>' value='<c:out value="${linkProductList.familyPrice}"/>'>
		<input type='hidden' name='start_price_<c:out value="${linkProductList.shopCode}"/>' value='<c:out value="${linkProductList.startPrice}"/>'>
		<input type='hidden' name='sale_status_<c:out value="${linkProductList.shopCode}"/>' value='<c:out value="${statusVal}"/>'>
		<input type='hidden' name='old_sale_status_<c:out value="${linkProductList.shopCode}"/>' value='<c:out value="${statusVal}"/>'>
	</c:forEach>
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="100%" height="50px" style="text-align: center;">샵링커 데이터베이스 연동</td>
	</tr>
	<tr>
		<td width="100%" height="50px" style="text-align: center;"><c:out value="${listOpenMarketMarginCount}"/>건의 데이터가 있습니다.</td>
	</tr>
	<tr>
		<td width="100%" height="50px" style="text-align: center;">
			<select name="selectedTable" id="selectedTable" onchange="onSelectedTable()">            	
            	<option value="fb_openmarket_margin_fobu" <c:if test="${selectedTable == 'fb_openmarket_margin_fobu'}">selected</c:if>>포부</option>
            	<option value="fb_openmarket_margin_choco" <c:if test="${selectedTable == 'fb_openmarket_margin_choco'}">selected</c:if>>초코</option>
            	<option value="fb_openmarket_margin_good" <c:if test="${selectedTable == 'fb_openmarket_margin_good'}">selected</c:if>>굿파더</option>
            	<option value="fb_openmarket_margin_min" <c:if test="${selectedTable == 'fb_openmarket_margin_min'}">selected</c:if>>민트윈</option>
            	<option value="fb_openmarket_margin_tmin" <c:if test="${selectedTable == 'fb_openmarket_margin_tmin'}">selected</c:if>>트윈몰</option>                
          	</select>
			<input type="button" value="데이터 전송(관리자->샵링커)" onclick="onDataSubmit();"/></td>
	</tr>
	<tr>
		<td width="100%" height="50px" style="text-align: center;"><input type="button" value="데이터 전송(샵링커->관리자)" onclick="onToFobuDataSubmit();"/></td>
	</tr>
	</table>
</form>
</body>
</html>
