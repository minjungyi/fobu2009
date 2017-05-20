<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>

<script language="javascript">

var frm = null;
var trIndex = 1;
//로딩
function noEvent() {
	//document.openMarketAccountFrm.action = "";  
	//alert(document.openMarketAccountFrm.action);
    if (event.keyCode == 116) {
        event.keyCode= 2;
        return false;
    }
    else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))
    {
        return false;
    }
}
document.onkeydown = noEvent;

$(function() {
frm = document.all.totalOrderFrm;
	
	$('#datepicker').datepicker({
		changeMonth: true,
		changeYear: true,
		yearRange: '2008:2020'
	});		

	$('#datepicker2').datepicker({
		changeMonth: true,
		changeYear: true,
		yearRange: '2008:2020'
	});		

	var now = new Date();
    var year= now.getFullYear();
    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
    
	$('#datepicker2').val(year+"-"+mon+"-"+day);
	
	var now2 = new Date();
	now2.setMonth(now.getMonth() - 2, now.getDate());
    var year2= now2.getFullYear();
    var mon2 = (now2.getMonth()+1)>9 ? ''+(now2.getMonth()+1) : '0'+(now2.getMonth()+1);
    var day2 = now2.getDate()>9 ? ''+now2.getDate() : '0'+now2.getDate();
    $('#datepicker').val(year2+"-"+mon2+"-"+day2);
    
	var totalNameSelTmp = '<c:out value="${nameSel}"/>';
	var totalNameTextTmp = '<c:out value="${nameText}"/>';
	if(totalNameSelTmp != null && totalNameSelTmp != ""){
		frm.nameSel.value = '<c:out value="${nameSel}"/>';
		document.all.totalTopFrm.totalNameSel.value= '<c:out value="${nameSel}"/>';
	}
	if(totalNameTextTmp != null && totalNameTextTmp != ""){
		frm.nameText.value = '<c:out value="${nameText}"/>';
		document.all.totalTopFrm.totalNameText.value = '<c:out value="${nameText}"/>';
	}
		
	
	if('${succ}'== "N"){
		alert('업로드 에러 입니다. 확인하시고 다시 시도해주세요.');
		search(1);
	}else{
		search(1);
	}
});



function ajaxPageSplit(num) {
	frm.pageNumTmp.value = num;
	search(num);
}

function search(pageNum, eqNum){
	var siteCode = frm.siteCode.value;
	var orderStat = frm.orderStat.value;
	var startDay = frm.startDay.value;
	var endDay = frm.endDay.value;
	var nameSel = frm.nameSel.value;
	var nameText = frm.nameText.value;
	var companyCategory = frm.companyCategory.value;
	var shopId = frm.shopId.value;
	var openMarketAccountYn = frm.openMarketAccountYn.value;
	
	var orderName = "";
	var dName = "";
	if(nameSel == "orderName"){
		orderName = nameText;
	}else{
		dName = nameText;
	}
	var listScale = $("#listScale").val();
	
	
	$.ajax({
		
        type:"POST",
        cache: false,
        data:{
			"orderStat": orderStat,
			"siteCode": siteCode,
			"startDay": startDay,
			"endDay": endDay,
			"pageNum": pageNum,
			"listScale": listScale,
			"orderName" : orderName,
			"dName" : dName,
			"companyCategory":companyCategory,
			"openMarketAccountYn":openMarketAccountYn,
			"shopId" : shopId
        },
        dataType: "json",
        url:"/admin/orderManage/init.action",
        beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
		success:function(data, status) {
			var c = "";
			
			var cHeader = "<tr>"
				+"<td width='40' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>정산</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>PR</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>수집</td>"
				+"<td width='85' align='center' bgcolor='e7e7e7' class='tx12B'>수집일</td>"
				+"<td width='85' align='center' bgcolor='e7e7e7' class='tx12B'>정보변경일</td>"
				+"<td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>상태</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>주문자</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>수령자</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>업체</td>"
				+"<td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>정산여부</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>수량</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>재고</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>원가</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>판매가</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>마진</td>"
				+"<td width='45' align='center' bgcolor='e7e7e7' class='tx12B'>%</td>"
				+"<td width='50'align='center' bgcolor='e7e7e7' class='tx12B'>배송</td>"
				+"</tr>";
			var a = 1;  

			if(data.totalOrderList.length == 0){
            	c = "<tr><td colspan='18' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>";
          		$("#search_total_order").html(cHeader+c);
          		
            }else{
                
	            $.each(data.totalOrderList, function() {
	                var bbColor = '#FFFFFF';
	                var ordererTmp = this.orderer;
	                if(this.cnt > 1 && this.orderStatCode != 6 && this.orderStatCode != 3){
	                	bbColor = '#e1f1c9';
	                	ordererTmp ="<a href='javascript:packageInfoPopup(\""+this.seq+"\")'>"+this.orderer + "("+this.cnt+")</a>";
	                }
	                
	                var fontColor = 'black';
	                if(this.deliverType == '착불'){
	                	fontColor = 'blue';
	                }
	                
	                if(this.receiverAddress.substr(0,2) == '제주'){
	                	fontColor = 'red';
	                }	                
	                
	                var fontColor2 = '#595959';
                    if(this.orderStatCode == '3'){
                        fontColor2 = 'red';
                    }
	
	        		var value = parseInt(this.marginPrice) / (parseInt(this.orderPrice));
	        		var roundVal = Math.ceil(value*10000)/100;
	                var companyImage = "";
	                if(this.companyCategory.length == 1){
	                	companyImage = "no0"+this.companyCategory;
	                }else{
	                	companyImage = "no"+this.companyCategory;
	                } 
	                
		            var marketTypeUrl ="";
	                var shopIdTmp2 = "";
	                
	                if(this.shopIdTmp == "good"){
	                	shopIdTmp2 = "goodfather";
	                }else if(this.shopIdTmp == "twin"){
	                	shopIdTmp2 = "twinmall";
	                }else if(this.shopIdTmp == "choco"){
	                	shopIdTmp2 = "choco";
	                }else if(this.shopIdTmp == "fobu"){
	                	shopIdTmp2 = "fobu";
	                }else{
	                	shopIdTmp2 = this.shopId;
	                }
	                
	                if(this.siteCode=="aut"){
	                	marketTypeUrl = data.autUrl;
	                }else if(this.siteCode=="gmk"){
	                	marketTypeUrl = data.gmkUrl;
	                }else if(this.siteCode=="itp"){
	                	marketTypeUrl = data.itpUrl;
                    }else if(this.siteCode=="cyw"){
	                	marketTypeUrl = data.cywUrl;
                    }else{
                    	marketTypeUrl = data.shnUrl+shopIdTmp2+"/products/";
                    } 
	                
	                var openMarketAccountYn = "";
	                if(this.openMarketAccountYn == "Y"){
	                	openMarketAccountYn = "정산";
	                }else if(this.openMarketAccountYn == "N"){
	                	openMarketAccountYn = "미정산";
	                }
	                
	            	c += "<tr onclick='rowSelect(this, \""+this.seq+"\");' bgcolor='#FFFFFF' style=cursor:hand;>"
	            	  +"<td width='40' height='20' align='center'>"
	      			  +"<input type='checkbox' name='checkbox' id='checkboxA"+a+"' value='"+this.seq+"'></td>"
	      			  +"<td width='30' align='center' ><img src='/images/com/"+companyImage+".gif' title='"+this.companyName+"'></td>"
	      			  +"<td width='30' align='center' ><a href='"+marketTypeUrl+this.url+"'  target='_blank'><img src='/images/"+this.siteImg+".gif'></a></td>"
	      			  +"<td width='85' align='center' >"+this.collectDt+"</td>"
	      			  +"<td width='85' align='center' >"+this.modifyDt+"</td>"
	      			  +"<td width='60' align='center' ><font color="+fontColor2+">"+this.orderStat+"</font></td>"	      				  
	      			  +"<td width='55' align='center' bgcolor="+bbColor+"><div style='width:55px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>"+ordererTmp+"</div></td>"
	      			  +"<td width='55' align='center' ><div style='width:55px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>"+this.receiver+"</div></td>"
	      			  +"<td width='50' align='center' ><img src='/images/"+this.shopImg+".gif'></td>"
	      			  +"<td width='245' align='left' ><div style='width:240px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>["+this.brandNm+"]"+this.product+"</div></td>"
	      			  +"<td width='50' align='center' >"+openMarketAccountYn+"</td>"
	      			  +"<td width='30' align='right' ><b>"+commify(this.orderQy)+"</b></td>"
	      			  +"<td width='30' align='right' ><a href='javascript:changeRealSrock(\""+this.productCode+"\", \""+this.product+"\", \""+this.realStock+"\");'>"+commify(this.realStock)+"</a></td>"
	      			  +"<td width='50' align='right' >"+commify(parseInt(this.familyPrice)*parseInt(this.orderQy))+"</td>"
	      			  +"<td width='50' align='right' >"+commify(this.orderPrice)+"</td>"
	      			  +"<td width='50' align='right' >"+commify(parseInt(this.marginPrice))+"</td>"
	      			  +"<td width='45' align='right' >"+roundVal+"</td>"
	      			  +"<td width='50' align='center' ><a href='javascript:onOrderInfoPopup(\""+this.seq+"\");'><font color="+fontColor+">"+this.deliverType+"</font></a></td>"
	      			  +"</tr>";
	            	
	            	a++;
	            });
	            $("#search_total_order").html(cHeader+c);
            }
            var totalPage = Math.ceil(parseInt(data.totalOrderCount)/parseInt(listScale));
            $("#spanCount").empty().html("<font color='red'>Total "+commify(data.totalOrderCount)+"</font> : "+commify(pageNum)+" / "+commify(totalPage)+" Page");                     
            $("#page").empty().html(data.pageSplit);                      
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	closeBlockUI();
        	var num = 1;
        	if(eqNum != null && eqNum != ""){
        		num = eqNum;
        	}
        	$("#search_total_order tr:eq("+num+")").click();
        }
	});
}

function rowSelect(obj, seq){
	trIndex = $("#search_total_order tr").index(obj);
	$("#search_total_order tr").css("backgroundColor","#FFFFFF");
	obj.style.backgroundColor="#e0eeee";
}

function allChk(objNm){
	var tempNm = "checkbox";
	
	if($("[name="+objNm+"]").is(":checked")){
		
		$("[name="+tempNm+"]").each(function(){
			$(this).attr("checked","checked");
		});
		
	}else{
		
		$("[name="+tempNm+"]").each(function(){
			$(this).removeAttr("checked");
		});
	}
	
}

function chkArrValue(){
	var arrChkVal ="";
	var checkedCnt = 0;
	
	$("[name=checkbox]").each(function(){
		if($(this).is(":checked")){
			arrChkVal += $(this).val()+","; 
			checkedCnt++;		
		}
	});

	if(checkedCnt == 0){
		alert("체크하시고 체크전송하세요.");
		return;
	}
	//alert(arrChkVal);
	frm.orderSeqStr.value = arrChkVal;
	statSave();
}

function statSave(){	
	var orderSeqStrTmp = frm.orderSeqStr.value;
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"orderSeqStr": orderSeqStrTmp
	    },
	    dataType: "json",
	    url:"/admin/orderManage/saveAccountStat.action",
	    success:function(data, status) {
	    },
	    error:function(request, status) {
	        alert(status);
	    },
	    complete:function(xhr, textStatus) {
	    	search(frm.pageNumTmp.value);  
	    }
	});	
	
}


function openMarketAccountSubmit(){
	var fileTmp = document.openMarketAccountFrm.file.value;
	if(fileTmp == null || fileTmp == ""){
		alert("파일을 먼저 선택하세요.");
		document.openMarketAccountFrm.file.focus();
		return;
	}
	$.ajax({        
        beforeSend:function(xhr) {
			showMsg("업로드중입니다...");
		},
		complete:function(xhr, textStatus) {
        	closeBlockUI();
        	document.openMarketAccountFrm.reset();
        }})
	openMarketAccountFrm.submit();
}
</script>
<form name="openMarketAccountFrm" action="/openMarketAccountUpload.action" method="post" enctype="multipart/form-data">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 오픈마켓정산</td>
    <td valign="bottom" align="right">
   		<input type="file" id="file" name="file">
   		<input type="button" name="account" value="정산" onclick='javeScript:openMarketAccountSubmit();' style="height:23px">
   		<!-- <img src="/images/button/open_oder.gif" onclick='javeScript:openMarketAccountSubmit();'> -->
    </td>
  </tr>
</table>
</form>
<form name="totalOrderFrm" method="post" onsubmit="return false">
<input type="hidden" name="orderSeqStr">
<input type="hidden" name="orderAccountStr">
<input type="hidden" name="pageNumTmp" value="1">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" background="/images/osb_t.gif">
    <table width="1180" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width=280>
                      시작일 <input style="width:30%;" type="text" name="startDay" id="datepicker" readonly>
          ~
                      종료일 <input style="width:30%;" type="text" name="endDay" id="datepicker2" readonly>
        </td>
        <td width="450">
          <select name="companyCategory">
          		<option value="">거래처</option>
	          <c:forEach items="${requestScope.listCompany}" var="listCompanyList">
	        	<option value="${listCompanyList.seq}">
	        	${listCompanyList.company }</option>
	          </c:forEach>
          </select>
          <select name="shopId" id="shopId">
            <option value="">업체</option>
            <option value="fobu">포부</option>
            <option value="choco">초코</option>
            <option value="min">민트윈</option>
            <option value="good">굿파더</option>
            <option value="twin">트윈몰</option>            
          </select>
          <select name="openMarketAccountYn">
            <option value="">정산여부</option>
            <option value="Y">정산</option>
            <option value="N">미정산</option>
          </select>
          <select name="siteCode" id="siteCode">
            <option value="">주문경로</option>				
            <option value="gmk">지마켓</option>
            <option value="aut">옥션</option>
            <option value="cyw">11번가</option>
            <option value="itp">인터파크</option>
            <option value="shn">샵N</option>
            <option value="dir">직거래</option>
            <option value="shop">사이트</option>
          </select>
          <select name="orderStat" id="orderStat">
            <option value="">주문상태</option>				
            <option value="0">신규주문</option>
            <option value="1">업체발주</option>
            <option value="2">업체입금</option>
            <option value="3">배송완료</option>
            <option value="4">발송보류</option>
            <option value="5">취소요청</option>
            <option value="6">취소완료</option>
            <option value="7">반품요청</option>
            <option value="8">반품완료</option>
            <option value="9">교환요청</option>
            <option value="10">교환완료</option>
          </select>
        </td>
        <td width="220" align="right">
        	<select name="nameSel">
          		<option value="orderName">주문자</option>
          		<option value="dName">수령인</option>
          		<option value="sDeliveryNo">송장번호</option>
          		<option value="sTel">전화번호</option>
          		<option value="sOrderNo">주문번호</option>
            </select>
          <input name="nameText" type="text" size="20" onkeydown="javascript:if(event.keyCode==13){search(1);}">
        </td>
        <td width="55" align="center">
        	<a href="javascript:search(1);"><img src="/images/button/btn_search.gif"></a>
        </td>
        <td align="right">
        	<span name="spanCount" id="spanCount"></span>        
        	<select name="listScale" id="listScale">
	            <option value="20">20</option>
	            <option value="50">50</option>
	            <option value="100">100</option>
	            <option value="200">200</option>
           	</select>
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><img src="/images/osb_b.gif" width="1200" height="27"></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_total_order">
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="40" align="center">
    	<input type="checkbox" name="checkAllA" id="checkAllA" value="9" onclick="allChk('checkAllA');"></td>
    <td width="80"><img src="/images/button/tb_check.gif" onclick="chkArrValue();"></td>
    <td width="960" align="center">
    	<div class="page_wrap">
			<div class="page" id="page" >
			</div>
		</div>
	</td>
    
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="175"><iframe id='fileDown' src='about:blank;' frameborder='0' width=0 height=0></iframe></td>
  </tr>
</table>
</form>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->	

