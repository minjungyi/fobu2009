<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>::::::::: 묶음상품정보 입니다 :::::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/common.js"></script>

<script language="javascript">
var frm = null;
var trIndex = 1;
$(function() {
	frm = document.all.packageInfofrm;
	if(${rtnVal} > 0){
		//parent.showMsgNClose("제품이 등록되었습니다.");
		alert("${msg}"+" 등록되었습니다.");
		opener.search(${pageNumPop}, ${trIndex});
		self.close();
	}	
});

function stockOptPackageSave(productCode, seqv, value){	
	var stockOptChange = $("input[name='stockOptChange"+seqv+"']").val();
	
	//var stockOptChange = value;
	
	if(stockOptChange=="" || stockOptChange == null){
		alert("재고옵션을 입력하신 후 저장하세요.");
		return;
	}
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"productCode": productCode,
			"stockOpt" : stockOptChange
	    },
	    dataType: "json",
	    url:"/admin/orderManage/saveStockOpt.action",
	    success:function(data, status) {
	    },
	    error:function(request, status) {
	        alert(status);
	    },
	    complete:function(xhr, textStatus) {
	    	//viewList(seqv);  
	    	window.location.reload();
	    }
	});	
	
}
function statSave(){	
	var valid = 0;
	$("[name=checkbox]").each(function(){
		if($(this).val() == "true")
			valid = 1;			
	});
	if(valid == 0){
		showMsgNClose('체크된 항목이 없습니다.');	
		return;
	}
	
	//frm.action = "/admin/orderManage/savePackageInfo.action";
	packageInfofrm.submit();
}

function chkYN(trIndex){	
	if($("[name=chk]").eq(trIndex).is(":checked")){
		$("[name=checkbox]").eq(trIndex).val("true");
	}
	else{
		$("[name=checkbox]").eq(trIndex).val("false");
	}
}

function allChk(objNm){
	var tempNm = "chk";
	
	if($("[name="+objNm+"]").is(":checked")){		
		$("[name="+tempNm+"]").each(function(){
			$(this).attr("checked","checked");
			chkYN($("[name=chk]").index(this));
		});		
	}else{		
		$("[name="+tempNm+"]").each(function(){
			$(this).removeAttr("checked");
			chkYN($("[name=chk]").index(this));
		});
	}
	
}

function changeDeliveryType(trIndex){
	$("[name=orderStat]").eq(trIndex).val("3");
	$("[name=chk]").eq(trIndex).attr("checked","checked");
	$("[name=checkbox]").eq(trIndex).val("true");
}

function onOrderInfoPopup2(seq){
    opener.onOrderInfoPopup(seq);
}


</script>
<style type="text/css" >
<!--
.style1 {color: #CC3333}

-->
</style>
</head>
<body bgcolor="4b4b4b">
<form name="packageInfofrm" method="post" action="/admin/orderManage/savePackageInfo.action">
<input type="hidden" name="pageNumTmp" value="1">
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" valign="bottom" background="/images/title_ordermm.gif">&nbsp;</td>
  </tr>
</table>
<table width="760" border="7" align="center" cellpadding="15" cellspacing="0" bordercolor="4b4b4b">
  <tr>
    <td bgcolor="#FFFFFF">
    <table width="700" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9"  id="search_total_order">
      <tr>        
        <td colspan="9" bgcolor="#FFFFFF" align="right">총주문건수 : ${totalCnt} / 총주문수량 : ${totalSum}</td>
      </tr>
      <tr>
        <td width="18" height="23" align="center" bgcolor="e7e7e7" class="tx12B">
        	<input type="checkbox" name="checkAll" id="checkAll" onclick="allChk('checkAll');"/>
        </td>
        <td width="75" align="center" bgcolor="e7e7e7" class="tx12B">이미지</td>
        <td width="45" align="center" bgcolor="e7e7e7" class="tx12B">주문자<br>수령인</td>
        <td width="45" align="center" bgcolor="e7e7e7" class="tx12B">품번<br>배송</td>
        <td align="center" bgcolor="e7e7e7" class="tx12B">제품명<br>옵션/배송메세지</td>
        <td width="30" align="center" bgcolor="e7e7e7" class="tx12B">수량<br>재고</td>
        <td width="40" align="center" bgcolor="e7e7e7" class="tx12B">원가<br>판가</td>
        <td width="40" align="center" bgcolor="e7e7e7" class="tx12B">마진<br>%</td>
        <td width="80" align="center" bgcolor="e7e7e7" class="tx12B">상태<br>택배/송장</td>
      </tr>
      <c:forEach items="${requestScope.packageInfolList}" var="list" varStatus="status">
      <tr>
        <td height="60" align="center" bgcolor="#FFFFFF">
        	<input type='checkbox' name='chk' id='chk' onclick='chkYN(<c:out value="${status.index}"/>);'/>
        	<input type="hidden" name="checkbox" id="checkbox" value='false'/>
        </td>
        <td align="center" bgcolor="#FFFFFF">
        	<a href="#"><img src='<c:out value="${titleImgPath}"/>/<c:out value="${list.titleImageFile}"/>' width='50' height='50'></a>
        </td>
        <td align="center" bgcolor="#FFFFFF"><a href="javascript:onOrderInfoPopup2(<c:out value="${list.seq}"/>)">
        <c:if test='${list.managerMemo == "1"}'> <b> </c:if><c:out value="${list.orderer}"/>
        <c:if test='${list.managerMemo == "1"}'> </b> </c:if></a><br><c:out value="${list.receiver}"/></td>
        <td align="center" bgcolor="#FFFFFF"><c:out value="${list.seq}"/><br><c:out value="${list.deliverType}"/><br><img src='/images/${list.shopImg}.gif'></td>
        <td bgcolor="#FFFFFF">
        	<a href="javascript:onProductUpdatePop(<c:out value="${list.productCode}"/>)">[<c:out value="${list.brandNm}"/>]<c:out value="${list.product}"/></a><a href='<c:out value="${list.companyLinkUrl}"/><c:out value="${list.corpProductCode}"/>' target='_blink'> <img src="/images/button/btn_link.gif" width="37" height="21" /></a><br>
          	<span class="style1"><c:out value="${list.orderOption}"/></span> /<c:out value="${list.deliverMemo}"/>
        </td>
        <td align="center" bgcolor="#FFFFFF"><c:out value="${list.orderQy}"/><br>
        	<a href="javascript:changeRealSrock('<c:out value="${list.productCode}"/>','<c:out value="${list.product}"/>','<c:out value="${list.realStock}"/>','<c:out value="${list.stockOpt}"/>')">
        	<c:out value="${list.realStock}"/></a></td>
        <td align="center" bgcolor="#FFFFFF">
        <span id="<c:out value="F${list.seq}"/>"></span><br>
        <span id="<c:out value="O${list.seq}"/>"></span></td>
        <td align="center" bgcolor="#FFFFFF"><span id="<c:out value="M${list.seq}"/>"></span><br>
        <span id="<c:out value="${list.seq}"/>"></span>
        <script>   
        var value = parseInt(<c:out value="${list.marginPrice}"/>) / parseInt(<c:out value="${list.orderPrice}"/>);
        var roundVal = Math.ceil(value*10000)/100;
        $("#"+<c:out value="${list.seq}"/>).empty().html(roundVal);
        $("#M"+<c:out value="${list.seq}"/>).empty().html(commify(<c:out value="${list.marginPrice}"/>));
        $("#F"+<c:out value="${list.seq}"/>).empty().html(commify(<c:out value="${list.familyPrice}"/>));
        $("#O"+<c:out value="${list.seq}"/>).empty().html(commify(<c:out value="${list.orderPrice}"/>));
        </script>
        </td>
        <td align="center" bgcolor="#FFFFFF">
        	<select name="orderStat" id='orderStat'>
		        <option value='0' <c:if test='${list.orderStat == "신규주문"}'> selected </c:if>>신규주문</option>
		        <option value='1' <c:if test='${list.orderStat == "업체발주"}'> selected </c:if>>업체발주</option>
		        <option value='2' <c:if test='${list.orderStat == "업체입금"}'> selected </c:if>>업체입금</option>
		        <option value='3' <c:if test='${list.orderStat == "배송완료"}'> selected </c:if>>배송완료</option>
		        <option value='4' <c:if test='${list.orderStat == "발송보류"}'> selected </c:if>>발송보류</option>
		        <option value='5' <c:if test='${list.orderStat == "취소요청"}'> selected </c:if>>취소요청</option>
		        <option value='6' <c:if test='${list.orderStat == "취소완료"}'> selected </c:if>>취소완료</option>
		        <option value='7' <c:if test='${list.orderStat == "반품요청"}'> selected </c:if>>반품요청</option>
		        <option value='8' <c:if test='${list.orderStat == "반품완료"}'> selected </c:if>>반품완료</option>
		        <option value='9' <c:if test='${list.orderStat == "교환요청"}'> selected </c:if>>교환요청</option>
		        <option value='10' <c:if test='${list.orderStat == "교환완료"}'> selected </c:if>>교환완료</option>
	        </select><br/>
	        <select name="deliveryCompany" id='deliveryCompany'>
	            <option value='delv0004' <c:if test='${list.deliveryCompany == "delv0004"}'> selected </c:if>>CJ</option>
                <option value='delv0067' <c:if test='${list.deliveryCompany == "delv0067"}'> selected </c:if>>동부</option>
                <option value='delv0010' <c:if test='${list.deliveryCompany == "delv0010"}'> selected </c:if>>한진택배</option>
		        <option value='delv0014' <c:if test='${list.deliveryCompany == "delv0014"}'> selected </c:if>>대한통운</option>
		        <option value='delv0012' <c:if test='${list.deliveryCompany == "delv0012"}'> selected </c:if>>옐로우캡</option>
		        <option value='delv0005' <c:if test='${list.deliveryCompany == "delv0005"}'> selected </c:if>>KGB택배</option>
		        <option value='delv0005' <c:if test='${list.deliveryCompany == "delv0006"}'> selected </c:if>>로젠택배</option>
		        <option value='delv0088' <c:if test='${list.deliveryCompany == "delv0088"}'> selected </c:if>>방문수령</option>
		        <option value='delv0089' <c:if test='${list.deliveryCompany == "delv0089"}'> selected </c:if>>퀵배송</option>
            </select><br/>
          	<input name="deliveryNumber" type="text" maxlength="16" size="8" value="<c:out value='${list.deliveryNumber}'/>" onkeypress="onlyNum()" onBlur="changeDeliveryType(<c:out value="${status.index}"/>)">
          	<input name="seq" type="hidden" size="8" value="<c:out value='${list.seq}'/>">
        </td>
      </tr>
      <tr>
	      <td align="center" bgcolor="#FFFFFF" colspan='2'>관리자메세지
	      </td>
	      <td align="left" bgcolor="#FFFFFF" colspan='7'>
	      	<c:out value="${list.managerMemo}"/>
	      </td>
      </tr>
      <tr>
      	  
	      <td align="center" bgcolor="#FFFFFF" colspan='2'>재고옵션
	      </td>
	      <td align="left" bgcolor="#FFFFFF" colspan='7'>
	      	<input name='stockOptChange${list.seq}' type='text' id='textfield' size='55' onkeydown='javascript:if(event.keyCode==13){stockOptPackageSave("${list.productCode}","${list.seq}");}' value = '${list.stockOpt}'>
      	  <a href='javascript:stockOptPackageSave("${list.productCode}","${list.seq}");'><img src='/images/button/s_button_03.gif' align='absmiddle'></a>
	      </td>
      </tr>
      </c:forEach>
    </table>
      <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="40" align="center" class="tx14B" style="padding-left:10px"><a href="javascript:statSave();"><img src="/images/button/btn_ok.gif"></a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:self.close();"><img src="/images/button/btn_can.gif"></a> </td>
      </tr>
    </table></td>
  </tr>
</table>
<input type="hidden" name="orderSeqStr">
<input type="hidden" name="orderStatStr">
<input type="hidden" name="deliveryNumberStr">
<input type='hidden' name='pageNumPop' value='<c:out value="${pageNumPop}"/>'>
<input type='hidden' name='trIndex' value='<c:out value="${trIndex}"/>'>
</form>
</body>
</html>

