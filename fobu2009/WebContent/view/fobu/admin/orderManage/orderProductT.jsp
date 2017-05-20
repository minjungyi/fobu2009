<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>::::::::: 직송주문요청 입니다 :::::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" id="X-UA-Compatible" content="IE=edge" >
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script language="javascript"><!--
$(function() {
	$(".price").each(function(){
		$(this).toPrice();
	});
	
	$(".price").keyup(function(event){
		$(this).toPrice();	
	});
});

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

function requiredData(nameStr, msgStr){
	var nameList = nameStr.split(",");
	var msgList = msgStr.split(",");
	for(var i = 0; i<nameList.length; i++){
		if($("[name="+nameList[i]+"]").val() == null || $("[name="+nameList[i]+"]").val() == ""){
			alert(msgList[i]+'을 입력하세요.');	
			return false;
		}
	}
	return true;
}

function newOrderDirSave(){
	var nameStr = "orderer,receiver,receiverTel,receiverHp,receiverZipcode,receiverAddress,deliverType,deliverPrice";
	//var nameStr = "orderer";
	//var msgStr = "주문인";
	var msgStr = "주문인,수령자,전화번호,핸드폰번호,우편번호,배송주소,배송타입,배송비";
	if(requiredData(nameStr, msgStr) == false){
		return;
	};
	
	var valid = 0;
	var validCnt = 0;
	var valData = "";
	$("[name=checkbox]").each(function(){
		valid ++;
		valData = $("[name=checkbox]").index(this);
		if($("[name=qy]").eq(valData).val() == null || $("[name=qy]").eq(valData).val() == ""){
			alert('수량을 입력하세요.');	
			validCnt++;
			return;
		}
		if($("[name=orderPrice]").eq(valData).val() == null || $("[name=orderPrice]").eq(valData).val() == ""){
			alert('구매가격을 입력하세요.');
			validCnt++;	
			return;
		}	
	});
	
	if(valid == 0){
		alert('선택하신 물품이 없습니다.');	
		return;
	}
	if(validCnt == 0){
		document.all.newOrderDirfrm.action = "/admin/orderManage/saveNewOrderProduct.action";
		document.all.newOrderDirfrm.submit();
	}
}

function chkYN(index){
	if($("[name=chk]").eq(index).is(":checked")){
		$("[name=checkbox]").eq(index).val("true");
		$("[name=chk]").each(function(){
			if($("[name=chk]").index(this) != index){
				$(this).removeAttr("checked");
				$("[name=checkbox]").eq($("[name=chk]").index(this)).val("false");
			}
		});
	}else{
		$("[name=checkbox]").eq(index).val("false");
	}
}

function onProductDel(){
	$("[name=checkbox]").each(function(){
		if($(this).val() == "true"){
			var valData = $("[name=checkbox]").index(this);
			$("#dirOrder").find("tr").eq(valData+1).remove();
		}		
	});
	onChangeSum();
}

function onChangePrice(seq, familyPrice){
	var orderPrice = $("#orderPrice"+seq).val();
	var qy = $("#qy"+seq).val();
	if(orderPrice == null || orderPrice == ""){
		return;
	}
	if(qy == null || qy == ""){
		return;
	}
	var marginPrice = (parseInt(orderPrice)*parseInt(qy))-(parseInt(familyPrice)*parseInt(qy));
	var value = parseInt(marginPrice) / ((parseInt(orderPrice)*parseInt(qy)));
    var roundVal = Math.ceil(value*10000)/100;
	$("#changePrice"+seq).html(commify(marginPrice)+"<br>"+roundVal);
	onChangeSum();
}

function onChangeSum(){
	var productCnt = 0;
	var totalQy = 0;
	var totalPrice = 0;
	var valIndex = 0;
	var addPriceInfo = 0;
	var addPriceTmp = $("#addPrice").val();
	if(addPriceTmp != null && addPriceTmp != ""){
		addPriceInfo = addPriceTmp;
	}
	$("[name=checkbox]").each(function(){
		productCnt ++;
		valIndex = $("[name=checkbox]").index(this);
		totalQy = parseInt(totalQy) + parseInt($("[name=qy]").eq(valIndex).val());
		totalPrice = parseInt(totalPrice) + parseInt($("[name=orderPrice]").eq(valIndex).val());
	});
	
	var sumInfohtml = "품목수량 : <strong>"+commify(productCnt)+"종</strong> / 총수량 :<strong> "+commify(totalQy)+"개</strong>"
    +"/ 추가금액 :<strong> "+commify(addPriceInfo)+"원</strong> / 총구매금액 : <strong>"+commify(totalPrice)+"원</strong>";    
    $("#sumInfo").html(sumInfohtml);
}

function onOrderChangePopup(){
	window.open('/admin/orderManage/orderProductC2.html', 'changeProductPop', 'width=780, height=750, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}
--></script>
</head>
<body bgcolor="4b4b4b">
<form name="newOrderDirfrm" method="post" action="saveNewOrderProduct">
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" valign="bottom" background="/images/title_orderpt.gif">&nbsp;</td>
  </tr>
</table>
<table width="760" border="7" align="center" cellpadding="15" cellspacing="0" bordercolor="4b4b4b">
  <tr>
    <td align="center" bgcolor="#FFFFFF"><table width="700" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
      <tr>
        <td width="15%" height="21" align="center" bgcolor="e7e7e7" class="tx12B"><strong>주문인</strong>/<strong>수령인</strong></td>
        <td width="35%" bgcolor="#FFFFFF" align="left">
        	<input type='text' size='10' name='orderer' value='' style="text-align:left">/
        	<input type='text' size='10' name='receiver' value='' style="text-align:left">
        </td>
        <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">E-mail</td>
        <td width="35%" bgcolor="#FFFFFF" align="left"><input type='text' size='30' name='receiverEmail' value='' style="text-align:left">
        </td>
      </tr>
      <tr>
        <td height="21" align="center" bgcolor="e7e7e7" class="tx12B">전화번호</td>
        <td bgcolor="#FFFFFF" align="left"><input type='text' size='30' name='receiverTel' maxlength='13' value='' style="text-align:left" onkeyUp="phoneNoMake(this.value, this);">
        </td>
        <td align="center" bgcolor="e7e7e7" class="tx12B">핸드폰번호</td>
        <td bgcolor="#FFFFFF" align="left"><input type='text' size='30' name='receiverHp' maxlength='13' value='' style="text-align:left" onkeyUp="phoneNoMake(this.value, this);">
        </td>
      </tr>
      <tr>
        <td height="21" align="center" bgcolor="e7e7e7" class="tx12B">배송주소</td>
        <td bgcolor="#FFFFFF" colspan="3" align="left"><input type='text' size='7' name='receiverZipcode' value='' style="text-align:center" onKeyPress="onlyNum()" maxlength="7">
            <input type='text' size='75' name='receiverAddress' value='' style="text-align:left">
          <a href="http://www.koreapost.go.kr/kpost/sub/subpage.jsp?contId=010101060000" target="_blank"><img src="/images/button/btn_post.gif" align="absmiddle"></a></td>
      </tr>
      <tr>
        <td width="15%" height="21" align="center" bgcolor="e7e7e7" class="tx12B">배송비</td>
        <td width="35%" bgcolor="#FFFFFF" align="left"><!-- span style="padding : 1 0 3 0">
      		<input type="text" id="receiver3" name="receiver3" style="width:90%;" value="김미량"/>
    	</span-->
          <select name='deliverType' id='deliverType'>
            <option value="선불">선불</option>
            <option value="무료">무료</option>
            <option value="착불">착불</option>
          </select>
          <span style="padding-top:5px">
          <input name="deliverPrice" maxlength='10' type="text" class="price" size="20">
          </span></td>
        <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">추가금액</td>
        <td width="35%" bgcolor="#FFFFFF" align="left"><span style="padding-top:5px">
          <input name="addPrice" id="addPrice" maxlength='10' type="text" class="price" size="30">
        </span></td>
        </tr> <tr>
        <td width="15%" height="21" align="center" bgcolor="e7e7e7" class="tx12B">관리자메모</td>
        <td bgcolor="#FFFFFF" colspan="3" align="left">
            <input name="memo" type="text" id="textfield" size="50" style="width:89%;">          
        </td>
      </tr>
    </table>
      <br>
      <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td align="left"><strong>주문상품검색</strong></td>
        <td height="25" align="right">
        	<a href="javascript:onOrderChangePopup();"><img src="/images/button/btn_search.gif"  align="absmiddle"></a>
        </td>
      </tr>
    </table>
      <table id="dirOrder" width="700" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
        <tr class="item1">
          <td width="30" height="23" align="center" bgcolor="e7e7e7" class="tx12B">선택</td>
          <td width="50" align="center" bgcolor="e7e7e7" class="tx12B">이미지</td>
          <td width="45" align="center" bgcolor="e7e7e7" class="tx12B">품번</td>
          <td align="center" bgcolor="e7e7e7" class="tx12B">제품명</td>
          <td width="40" align="center" bgcolor="e7e7e7" class="tx12B">수량<br>재고</td>
          <td width="60" align="center" bgcolor="e7e7e7" class="tx12B">원가<br>구매가</td>
          <td width="50" align="center" bgcolor="e7e7e7" class="tx12B">마진<br>%</td>
          <td width="40" align="center" bgcolor="e7e7e7" class="tx12B">상태</td>
        </tr>
      </table>
      <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" align="right">
          	<span id="sumInfo"></span>
          </td>
        </tr>
      </table>
      <br>   
      <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="40" align="center" class="tx14B" style="padding-left:10px">
        	<a href="javascript:newOrderDirSave();"><img src="/images/button/btn_ok.gif"></a>&nbsp; <a href="javascript:onProductDel();"><img src="/images/button/btn_del.gif"></a>&nbsp;
        	<a href="javascript:self.close();"><img src="/images/button/btn_can.gif"></a> </td>
      </tr>
    </table></td>
  </tr>
</table>

</form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
</body>
</html>


