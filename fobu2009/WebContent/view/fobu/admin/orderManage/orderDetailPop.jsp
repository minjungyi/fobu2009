<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>::::::::: 주문상세조회 입니다 :::::::::</title>
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
$(function() {
	$(".price").each(function(){
		$(this).toPrice();
	});
	
	$(".price").keyup(function(event){
		$(this).toPrice();	
	});
});
function onLoad(){
	frm = document.all.orderDePopfrm;
	var deliverTypeStr= "<c:out value='${totalOrderDetailList[0].deliverType}'/>";
	var deliveryCompanyStr= "<c:out value='${totalOrderDetailList[0].deliveryCompany}'/>";
	var orderStatCodeStr= "<c:out value='${totalOrderDetailList[0].orderStatCode}'/>";
	var accidentYnStr= "<c:out value='${totalOrderDetailList[0].accidentYn}'/>";
	var accidentCompleteYnStr= "<c:out value='${totalOrderDetailList[0].accidentCompleteYn}'/>";
	if(accidentYnStr == "Y"){
		frm.accidentYn.checked = true;
	}else{
		frm.accidentYn.checked = false;
	}

	if(accidentCompleteYnStr == "Y"){
		frm.accidentCompleteYn.checked = true;
	}else{
		frm.accidentCompleteYn.checked = false;
	}
	
	$("#deliverType > option[value="+deliverTypeStr+"]").attr("selected", "true");
	$("#deliveryCompany > option[value="+deliveryCompanyStr+"]").attr("selected", "true");
	$("#orderStat > option[value="+orderStatCodeStr+"]").attr("selected", "true");
	
	var orderPrice = "<c:out value='${totalOrderDetailList[0].orderPrice}'/>";
	var marketPrice = "<c:out value='${totalOrderDetailList[0].marketPrice}'/>";
	var marginPrice = "<c:out value='${totalOrderDetailList[0].marginPrice}'/>";
	var familyPrice = "<c:out value='${totalOrderDetailList[0].familyPrice}'/>";
	var deliverPrice = "<c:out value='${totalOrderDetailList[0].deliverPrice}'/>";
	var addDeliverPrice = "<c:out value='${totalOrderDetailList[0].addDeliverPrice}'/>";
	var addPrice = "<c:out value='${totalOrderDetailList[0].addPrice}'/>";
	var couponPrice = "<c:out value='${totalOrderDetailList[0].couponPrice}'/>";
	var useSavePrice = "<c:out value='${totalOrderDetailList[0].useSavePrice}'/>";
	
	var value = parseInt(marginPrice) / (parseInt(orderPrice));
	var roundVal = Math.ceil(value*10000)/100;
	var jungsan = parseInt(orderPrice) - (parseInt(marketPrice));
	
	var cContents = "<tr><td><STRONG>정산금액</STRONG> ="
    	+"판매가("+commify(orderPrice)+" 원) - "
    	+"마켓수수료("+commify(marketPrice)+" 원) = "
    	+"<strong>"+commify(jungsan)+" 원 / <strong>"
    	+"마진("+commify(marginPrice)+" 원) /"
    	+"마진율 ("+roundVal+")</strong><br>"
    	+"판매마진 </strong>="
    	+"원판매가("+commify(orderPrice)+" 원) +"
    	+"선불배송료("+commify(deliverPrice)+" 원) -"
    	+"원가("+commify(familyPrice)+" 원) - "
    	+"마켓수수료("+commify(marketPrice)+" 원) - "
    	+"배송료("+commify(deliverPrice)+" 원) - "
    	+"추가배송료("+commify(addDeliverPrice)+" 원) - "
    	+"추가금("+commify(addPrice)+" 원) -" 
    	+"적립금("+commify(useSavePrice)+" 원) -" 
    	+"쿠폰할인("+commify(couponPrice)+" 원)"
    	+"</td></tr>";
    	$("#view_detail").html(cContents);

}

function PhonNumStr( str ){ 
    var RegNotNum  = /[^0-9]/g; 
    var RegPhonNum = ""; 
    var DataForm   = ""; 

    // return blank
    if( str == "" || str == null ) return ""; 
     
    // delete not number
    str = str.replace(RegNotNum,''); 
    if( str.length < 3 ) return str; 
	
	if( str.length > 2 && str.substr(0,2) == "02" ) {
		if( str.length < 5 ) {
			DataForm = "$1-$2"; 
			RegPhonNum = /([0-9]{2})([0-9]+)/; 
		} else if( str.length == 5 ) { 
			DataForm = "$1-$2"; 
			RegPhonNum = /([0-9]{2})([0-9]{3})/; 
		} else if( str.length > 5 && str.length < 10 ) { 
			DataForm = "$1-$2-$3"; 
			RegPhonNum = /([0-9]{2})([0-9]{3})([0-9]+)/; 
		} else {
			DataForm = "$1-$2-$3"; 
			RegPhonNum = /([0-9]{2})([0-9]{4})([0-9]+)/; 
		}
	} else {
		if( str.length > 3 && str.length < 7 ) { 
			DataForm = "$1-$2"; 
			RegPhonNum = /([0-9]{3})([0-9]+)/; 
		} else if( str.length == 6 ) { 
			DataForm = "$1-$2"; 
			RegPhonNum = /([0-9]{3})([0-9]{3})/; 
		} else if( str.length > 6 && str.length < 11 ){ 
			DataForm = "$1-$2-$3"; 
			RegPhonNum = /([0-9]{3})([0-9]{3})([0-9]+)/; 
		} else { 
			DataForm = "$1-$2-$3"; 
			RegPhonNum = /([0-9]{3})([0-9]{4})([0-9]+)/; 
		} 
	}

    while( RegPhonNum.test(str) ) {  
        str = str.replace(RegPhonNum, DataForm);  
    } 
    return str; 
} 

function onlyNum() {
	if((event.keyCode != 45) && (event.keyCode < 45) || (event.keyCode > 57)) {
		event.returnValue = false;
	}
}

function phoneNoMake(phoneStr, frmTmp){
	frmTmp.value = PhonNumStr(phoneStr);
}

function memoSave(seq){ 
    //var memoTmp = frm.memoChange.value +"\n"+frm.memo.value;
    var memoChange = document.orderDePopfrm.memoChange.value;
    var memo = document.orderDePopfrm.memo.value;
    if(memoChange=="" || memoChange == null){
        alert("관리자메모를 입력하신 후 저장하세요.");
        return;
    }
    $.ajax({
        type:"POST",
        cache: false,
        data:{
            "seq": seq,
            "memoChange" : memoChange,
            "memo": memo
        },
        dataType: "json",
        url:"/admin/orderManage/saveMemo.action",
        success:function(data, status) {
        },
        error:function(request, status) {
            alert(status);
        },
        complete:function(xhr, textStatus) {
        	self.location.reload(); 
        }
    }); 
    
}

function orderDeSave(seq){		
	var deliverTypeTmp = frm.deliverType.value;
	var orderQyTmp = frm.orderQy.value;
	var familyPriceTmp = frm.familyPrice.value;
	var addPriceTmp = frm.addPrice.value;
	var orderStatTmp = frm.orderStat.value;
	var orderStatCodeTmp = frm.orderStatCodeTmp.value;
    var orderStatChange = "";
    if(orderStatTmp == orderStatCodeTmp){
    	orderStatChange = "N";
    }else{
    	orderStatChange = "Y";
    }
	var receiverTmp = frm.receiver.value;
	var receiverTelTmp = frm.receiverTel.value;
	var receiverHpTmp = frm.receiverHp.value;
	var receiverEmailTmp = frm.receiverEmail.value;
	var receiverZipcodeTmp = frm.receiverZipcode.value;
	var receiverAddressTmp = frm.receiverAddress.value;
	var deliveryCompanyTmp = frm.deliveryCompany.value;
	var deliveryNumberTmp = frm.deliveryNumber.value;
	var companyCategoryTmp = frm.companyCategory.value;
	var deliverPriceTmp = frm.deliverPrice.value;
	var addDeliverPriceTmp = frm.addDeliverPrice.value;
	var useSavePriceTmp = frm.useSavePrice.value;
	var accidentYnTmp = "N";
	if(frm.accidentYn.checked == true){
		accidentYnTmp = "Y";
	}
	var accidentCompleteYnTmp = "N";
	if(frm.accidentCompleteYn.checked == true){
		accidentCompleteYnTmp = "Y";
	}
	
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"seq": seq,
			"deliverType": deliverTypeTmp,
			"orderQyStr": orderQyTmp,
			"familyPriceStr": familyPriceTmp,
			"addPriceStr": addPriceTmp,
			"orderStat": orderStatTmp,
			"orderOriginStat": orderStatCodeTmp,
			"orderStatChange": orderStatChange,
			"receiver": receiverTmp,
			"receiverTel": receiverTelTmp,
			"receiverHp": receiverHpTmp,
			"receiverZipcode": receiverZipcodeTmp,
			"receiverAddress": receiverAddressTmp,
			"deliveryCompany": deliveryCompanyTmp,
			"deliveryNumber": deliveryNumberTmp,
			"receiverEmail": receiverEmailTmp,
			"deliverPrice": deliverPriceTmp,
			"addDeliverPrice": addDeliverPriceTmp,
			"companyCategory":companyCategoryTmp,
			"accidentYn":accidentYnTmp,
			"accidentCompleteYn":accidentCompleteYnTmp,
			"useSavePrice":useSavePriceTmp
	    },
	    dataType: "json",
	    url:"/admin/orderManage/orderDeSave.action",
	    success:function(data, status) {
	    },
	    error:function(request, status) {
	        alert(status);
	    },
	    complete:function(xhr, textStatus) {
	    	var pp = document.orderDePopfrm.pageNumPop.value;
	    	var aa = document.orderDePopfrm.trIndex.value;
	    	opener.search(pp, aa);
	    	self.close();
	    }
	});	
	
}

function orderDePopClose(seq){
	var pageNumPop = frm.pageNumPop.value;
	var trIndex = frm.trIndex.value;
	//opener.search(pageNumPop, trIndex);
	self.close();
}

function search(){
	var pageNumPop = frm.pageNumPop.value;
	var seq = frm.seq.value;
	var trIndex = frm.trIndex.value;
	window.open('/admin/orderManage/orderDetailPop.html?seq=' + seq+'&trIndex='+trIndex+'&pageNumPop='+pageNumPop, 'orderDetailPop', 'width=780, height=730, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}

function onOrderChangePopup(seq){
	//window.open('/admin/orderManage/orderDetailP.html?seq=' + seq, 'orderDetailP', 'width=780, height=920, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');

	var pageNumPop = frm.pageNumPop.value;
	var seq = frm.seq.value;
	var trIndex = frm.trIndex.value;
	window.open('/admin/orderManage/orderProductC.html?seq=' + seq+'&trIndex='+trIndex+'&pageNumPop='+pageNumPop, 'changeProductPop', 'width=780, height=750, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}

function onEnterSave(){
	if(event.keyCode==13){
		orderDeSave('<c:out value="${totalOrderDetailList[0].seq}"/>');
	}
}

</script>
</head>
<body bgcolor="4b4b4b" onLoad="onLoad();">
<form name="orderDePopfrm" method="post">
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" valign="bottom" background="/images/title_orderview.gif">&nbsp;</td>
  </tr>
</table>
<table width="760" border="7" align="center" cellpadding="15" cellspacing="0" bordercolor="4b4b4b">
  <tr>
    <td bgcolor="#FFFFFF"><table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="110" height="110"><img src='<c:out value="${titleImgPath}"/>/<c:out value="${totalOrderDetailList[0].titleImageFile}"/>' width='100' height='100'></td>
    <td align="right"><table width="580" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
      <tr>
        <td width="15%" height="21" align="center" bgcolor="e7e7e7" class="tx12B">제품명</td>
        <td colspan="3" bgcolor="#FFFFFF" align="left"><span style="padding : 1 0 3 0">
        <c:out value="${totalOrderDetailList[0].product}"/>
        &nbsp;<a href="#"><img src="/images/button/btn_link.gif" width="37" height="21" align="absmiddle"></a>
        </span></td>
      </tr>
      <tr>
        <td height="21" align="center" bgcolor="e7e7e7" class="tx12B">주문번호</td>
        <td width="30%" bgcolor="#FFFFFF" align="left"><strong>
          <c:out value="${totalOrderDetailList[0].seq}"/></strong></td>
        <td width="16%" align="center" bgcolor="e7e7e7" class="tx12B">배송방법</td>
        <td bgcolor="#FFFFFF" align="left">
        <select name='deliverType' id='deliverType'>
          <option value="선불">선불</option>
          <option value="무료">무료</option>
          <option value="착불">착불</option>
        </select>
        </td>
      </tr>
      <tr>
        <td height="21" align="center" bgcolor="e7e7e7" class="tx12B">수량</td>
        <td bgcolor="#FFFFFF" align="left">
        	<input type='text' size='4' maxLength="6" class="price" name='orderQy' value='<c:out value="${totalOrderDetailList[0].orderQy}"/>' style="text-align:right" onkeydown="javascript:onEnterSave()">
          	<a href='javascript:onOrderChangePopup(<c:out value="${totalOrderDetailList[0].seq}"/>);'><img src="/images/button/btn_chor.gif"></a></td>
        <td align="center" bgcolor="e7e7e7" class="tx12B">옵션/거래처</td>
        <td bgcolor="#FFFFFF" align="left">
          <span style="padding : 5 300 0 0">
          <c:out value="${totalOrderDetailList[0].orderOption}"/>
          <c:set var="comName" value="${totalOrderDetailList[0].companyCategory}"></c:set>
          <STRONG>/</STRONG><select name='companyCategory' readOnly>
	          <c:forEach items="${requestScope.listCompany}" var="listCompanyList">
	        	<option value="${listCompanyList.seq}"
	        	<c:if test="${listCompanyList.seq == comName }"> selected </c:if>
	        	>
	        	${listCompanyList.company }</option>
	          </c:forEach>
          </select>
          </span>
        </td>
      </tr>
      <tr>
        <td height="21" align="center" bgcolor="e7e7e7" class="tx12B">원가/단가</td>
        <td align="left" bgcolor="#FFFFFF">
        	<input type='text' name='familyPrice' maxLength="10" class="price" size='7' value='<c:out value="${totalOrderDetailList[0].familyPrice}"/>' style='text-align:right' onkeydown="javascript:onEnterSave()">
        	<STRONG>/</STRONG>
        	<c:out value="${totalOrderDetailList[0].orderPrice}"/>
        </td>
        <td align="center" bgcolor="e7e7e7" class="tx12B">추가금/적립금</td>
        <td bgcolor="#FFFFFF" align="left">
        	<input type='text' size='10' name='addPrice' maxLength="10" class="price" value='<c:out value="${totalOrderDetailList[0].addPrice}"/>' style="text-align:right" onkeydown="javascript:onEnterSave()">원
        	<input type='text' size='10' name='useSavePrice' maxLength="10" class="price" value='<c:out value="${totalOrderDetailList[0].useSavePrice}"/>' style="text-align:right" onkeydown="javascript:onEnterSave()">원
        </td>
      </tr>
      <tr>
        <td height="21" align="center" bgcolor="e7e7e7" class="tx12B">배송사고여부</td>
        <td align="left" bgcolor="#FFFFFF">
        	<input type="checkbox" name="accidentYn">배송사고<input type="checkbox" name="accidentCompleteYn">사고처리완료
        </td>
        <td align="center" bgcolor="e7e7e7" class="tx12B">배송비/추가비</td>
        <td bgcolor="#FFFFFF" align="left">
        <input type='text' size='7' name='deliverPrice' maxLength="10" class="price" value='<c:out value="${totalOrderDetailList[0].deliverPrice}"/>' style="text-align:right" onkeydown="javascript:onEnterSave()">원 <STRONG>/</STRONG>
        <input type='text' size='7' name='addDeliverPrice' maxLength="10" class="price" value='<c:out value="${totalOrderDetailList[0].addDeliverPrice}"/>' style="text-align:right" onkeydown="javascript:onEnterSave()">원
        </td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="5" valign="bottom"></td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
  <tr>
    <td width="15%" height="21" align="center" bgcolor="e7e7e7" class="tx12B">주문수집</td>
    <td width="35%" bgcolor="#FFFFFF"><span style="padding : 1 0 3 0">
    	<c:if test="${totalOrderDetailList[0].siteCode == 'gmk'}">
	         지마켓
	    </c:if>
	    <c:if test="${totalOrderDetailList[0].siteCode == 'aut'}">
	    (주)옥션
	    </c:if>
	    <c:if test="${totalOrderDetailList[0].siteCode == 'itp'}">
	    (주)인터파크
	    </c:if>
	    <c:if test="${totalOrderDetailList[0].siteCode == 'cyw'}">
	    11번가
	    </c:if>
	    <c:if test="${totalOrderDetailList[0].siteCode == 'shn'}">
	           샵N	
	    </c:if>
    </span></td>
    <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">결제수단</td>
    <td width="35%" bgcolor="#FFFFFF"></td>
  </tr>
  <tr>
    <td width="15%" height="21" align="center" bgcolor="e7e7e7" class="tx12B">결제정보</td>
    <td bgcolor="#FFFFFF"></td>
    <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">입금자</td>
    <td bgcolor="#FFFFFF"></td>
  </tr>
  <tr>
    <td width="15%" height="21" align="center" bgcolor="e7e7e7" class="tx12B">주문진행상태</td>
    <td bgcolor="#FFFFFF"><span style="padding : 1 0 3 0">
      <c:out value="${totalOrderDetailList[0].orderStat}"/>
      </span>
      </td>
    <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">주문처리상태</td>
    <td bgcolor="#FFFFFF"><span style="padding : 1 0 3 0">
      <c:out value="${totalOrderDetailList[0].orderStat}"/>
      </span>
      </td>
  </tr>
  <tr>
    <td width="15%" height="21" align="center" bgcolor="e7e7e7" class="tx12B">관리자메모</td>
    <td bgcolor="#FFFFFF" colspan="3">
    	<textarea name="memo" cols="35" rows="5" style="width:95%;" readOnly><c:out value="${totalOrderDetailList[0].managerMemo}"/></textarea>
        <input name="memoChange" type="text" id="textfield" size="66" style="width:80%;" onkeydown="javascript:if(event.keyCode==13){memoSave('<c:out value="${totalOrderDetailList[0].seq}"/>');}">
      <a href="javascript:memoSave('<c:out value="${totalOrderDetailList[0].seq}"/>');"><img src="/images/button/s_button_03.gif" width="30" height="18" align="absmiddle"></a> </td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="5" valign="bottom"></td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
  <tr>
    <td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">주문상태</td>
    <td width="20%" bgcolor="#FFFFFF">
        <select name='orderStat' style='font-size:12px;' id='orderStat' onkeydown="javascript:onEnterSave()">
          <c:if test="${totalOrderDetailList[0].deliveryCompleteYn != 'Y'}">
          <option value='0'selected>신규주문</option>
          <option value='1'>업체발주</option>
          <option value='2'>업체입금</option>
          </c:if>
          <option value='3'>배송완료</option>
          <option value='4'>발송보류</option>
          <option value='5'>취소요청</option>
          <option value='6'>취소완료</option>
          <option value='7'>반품요청</option>
          <option value='8'>반품완료</option>
          <option value='9'>교환요청</option>
          <option value='10'>교환완료</option>			    
      	</select></td>
    <td bgcolor="#FFFFFF">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="18" align="center" bgcolor="e7e7e7" class="tx12B">변경자(변경시간)</td>
            <td align="center" bgcolor="e7e7e7" class="tx12B">변경내용</td>
          </tr>
          <tr>
            <td height="18" align="center"><c:out value="${totalOrderDetailList[0].modifiers}"/>(<c:out value="${totalOrderDetailList[0].modifyDt}"/>)</td>
            <td align="center"><c:out value="${totalOrderDetailList[0].deliveryCompleteStat}"/><c:out value="${totalOrderDetailList[0].orderStat}"/></td>
          </tr>
      </table></td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="5" valign="bottom"></td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
  <tr>
    <td width="15%" height="21" align="center" bgcolor="e7e7e7" class="tx12B"><strong>주문자</strong></td>
    <td width="35%" bgcolor="#FFFFFF"><span style="padding : 1 0 3 0"><c:out value="${totalOrderDetailList[0].orderer}"/></span></td>
    <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">E-mail</td>
    <td width="35%" bgcolor="#FFFFFF"><c:out value="${totalOrderDetailList[0].ordererEmail}"/></td>
  </tr>
  <tr>
    <td height="21" align="center" bgcolor="e7e7e7" class="tx12B">전화번호</td>
    <td bgcolor="#FFFFFF"><span style="padding : 1 0 3 0"><c:out value="${totalOrderDetailList[0].ordererTel}"/></span></td>
    <td align="center" bgcolor="e7e7e7" class="tx12B">휴대폰</td>
    <td bgcolor="#FFFFFF"><c:out value="${totalOrderDetailList[0].ordererHp}"/></td>
  </tr>
  <tr>
    <td height="21" align="center" bgcolor="e7e7e7" class="tx12B">주소</td>
    <td bgcolor="#FFFFFF" colspan="3"><c:out value="${totalOrderDetailList[0].ordererZipcode}"/> <c:out value="${totalOrderDetailList[0].ordererAddress}"/></td>
  </tr>
  <tr>
    <td height="21" align="center" bgcolor="e7e7e7" class="tx12B">주문자메모</td>
    <td bgcolor="#FFFFFF" colspan="3"><c:out value="${totalOrderDetailList[0].deliverMemo}"/></td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="5" valign="bottom"></td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
  <tr>
    <td width="15%" height="21" align="center" bgcolor="e7e7e7" class="tx12B"><strong>수령인</strong></td>
    <td width="35%" bgcolor="#FFFFFF">
      <input type='text' size='20' name='receiver' value='<c:out value="${totalOrderDetailList[0].receiver}"/>' style="text-align:left" onkeydown="javascript:onEnterSave()">
    </td>
    <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">E-mail</td>
    <td width="35%" bgcolor="#FFFFFF"><input type='text' size='35' name='receiverEmail' value='<c:out value="${totalOrderDetailList[0].receiverEmail}"/>' style="text-align:left" onkeydown="javascript:onEnterSave()">
    </td>
  </tr>
  <tr>
    <td height="21" align="center" bgcolor="e7e7e7" class="tx12B">전화번호</td>
    <td bgcolor="#FFFFFF">
       <input type='text' size='20' name='receiverTel' maxlength='13' value='<c:out value="${totalOrderDetailList[0].receiverTel}"/>' style="text-align:left" onkeyUp="phoneNoMake(this.value, this);" onkeydown="javascript:onEnterSave()">
    </td>
    <td align="center" bgcolor="e7e7e7" class="tx12B">핸드폰번호</td>
    <td bgcolor="#FFFFFF">
        <input type='text' size='20' name='receiverHp' maxlength='13' value='<c:out value="${totalOrderDetailList[0].receiverHp}"/>' style="text-align:left" onkeyUp="phoneNoMake(this .value, this);" onkeydown="javascript:onEnterSave()">
    </td>
  </tr>
  <tr>
    <td height="21" align="center" bgcolor="e7e7e7" class="tx12B">배송주소</td>
    <td bgcolor="#FFFFFF" colspan="3">
      <input type='text' size='7' name='receiverZipcode' value='<c:out value="${totalOrderDetailList[0].receiverZipcode}"/>' style="text-align:center" onkeypress="onlyNum()" maxlength="7">
      <input type='text' size='70' name='receiverAddress' value='<c:out value="${totalOrderDetailList[0].receiverAddress}"/>' style="text-align:left" onkeydown="javascript:onEnterSave()">
      <a href="http://www.koreapost.go.kr/kpost/sub/subpage.jsp?contId=010101060000" target="_blank"><img src="/images/button/btn_post.gif" align="absmiddle"></a></td>
  </tr>
  <tr>
    <td width="15%" height="21" align="center" bgcolor="e7e7e7" class="tx12B">택배사</td>
    <td width="35%" bgcolor="#FFFFFF"><!-- span style="padding : 1 0 3 0">
      		<input type="text" id="receiver3" name="receiver3" style="width:90%;" value="김미량"/>
    	</span-->
        <select name='deliveryCompany' id='deliveryCompany'>
          <option value="0"></option>
          <option value="delv0004">CJ</option>
          <option value="delv0067">동부</option>
          <option value="delv0010">한진택배</option>
          <option value="delv0014">대한통운</option>
          <option value="delv0012">옐로우캡</option>
          <option value="delv0005">KGB택배</option>
          <option value="delv0006">로젠택배</option>
          <option value="delv0088">방문수령</option>
          <option value="delv0089">퀵배송</option>
      </select></td>
    <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">송장번호</td>
    <td width="35%" bgcolor="#FFFFFF"><input type='text' size='20' name='deliveryNumber' value='<c:out value="${totalOrderDetailList[0].deliveryNumber}"/>' style="text-align:left" onkeydown="javascript:onEnterSave()">    </td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28">
	    <table id="view_detail">
    	</table>
      </td>
  </tr>
</table>

    <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="40" align="center" class="tx14B" style="padding-left:10px">
        <a href="javascript:orderDeSave('<c:out value="${totalOrderDetailList[0].seq}"/>');"><img src="/images/button/btn_ok.gif"></a>&nbsp;&nbsp;&nbsp;&nbsp; 
        <a href="javascript:orderDePopClose('<c:out value="${totalOrderDetailList[0].seq}"/>');"><img src="/images/button/btn_can.gif"></a> </td>
      </tr>
    </table></td>
  </tr>
</table>
<input type='hidden' name='seq' value='<c:out value="${totalOrderDetailList[0].seq}"/>'>
<input type='hidden' name='trIndex' value='<c:out value="${trIndex}"/>'>
<input type='hidden' name='pageNumPop' value='<c:out value="${pageNumPop}"/>'>
<input type='hidden' name='orderStatCodeTmp' value='<c:out value='${totalOrderDetailList[0].orderStatCode}'/>'>
</form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
</body>
</html>


