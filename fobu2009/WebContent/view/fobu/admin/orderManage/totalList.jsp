<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>

<script language="javascript">

var frm = null;
var trIndex = 1;
//로딩

$(function() {
/* 	$.ajaxSetup({
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX",true);
		},
		error:function(xhr,status,err){
			alert(xhr.status);
			if(xhr.status == 404){
				alert(404);
			}
		}
	}
			); */
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
	
	search(1);
	
	
});

function viewList(seq){
	$.ajax({
	type:"POST",
    cache: false,
    data:{
		"seq": seq
    },
    dataType: "json",
    url:"/admin/orderManage/initDetail.action",
    success:function(data, status) {		
		$("#view_order_detail").hide();
		 var linkTag = "";
         if(data.totalOrderDetailList[0].companyLinkUrl.length > 0){
             linkTag = "<a href='"+data.totalOrderDetailList[0].companyLinkUrl+data.totalOrderDetailList[0].corpProductCode+"' target='_blink'> <img src='/images/button/btn_link.gif' width='37' height='21' /></a>";
         }
		var cContents = "<tr><td width='700' valign='top' align='center'><table width='98%' border='0' cellspacing='0' cellpadding='0'><tr>"
	    	+"<td width='110' height='110' rowspan='5' align='left'><img src='"+data.titleImgPath+"/"+data.totalOrderDetailList[0].titleImageFile+"' width='100' height='100' onclick='imageView(\"<c:out value='${titleImgPath2}'/>/"+data.totalOrderDetailList[0].titleImageFile+"\");' style='cursor:pointer;'>"
	    	+"<p><select name='memoSel' id='memoSel'><option value='반품요청'>반품요청</option><option value='교환요청'>교환요청</option><option value='취소요청'>취소요청</option><option value='배송독촉'>배송독촉</option>"
	        +"</select><a href='javascript:memoSave2(\""+data.totalOrderDetailList[0].seq+"\");'><img src='/images/button/s_button_03.gif' align='absmiddle'></a>"
	        +"<td height='22' class='tx12B' align='left'>["+data.totalOrderDetailList[0].brandNm+"]&nbsp;<a href='javascript:onProductUpdatePop(\""+data.totalOrderDetailList[0].productCode+"\")'>"+data.totalOrderDetailList[0].product+"</a>"
	    	+linkTag
	    	+"</td></tr><tr><td height='22' align='left'><span class='tx12B'>["+data.totalOrderDetailList[0].orderCode+"]</span>"
	    	+"<span class='tx12BR'>"+data.totalOrderDetailList[0].deliverType+" | 가격 : "+data.totalOrderDetailList[0].orderPrice+" | 수량 : "+data.totalOrderDetailList[0].orderQy+"개 | 옵션 : "+data.totalOrderDetailList[0].orderOption+"</span>"
	    	+"</td></tr><tr><td height='22' align='left'><span class='tx12B'>["+data.totalOrderDetailList[0].receiverZipcode+"]</span>"+data.totalOrderDetailList[0].receiverAddress+"</td></tr>"
	    	+"<tr align='left'><td height='22'><span class='tx12B'></span> "+data.totalOrderDetailList[0].orderer+"&nbsp;"+data.totalOrderDetailList[0].ordererTel+","+data.totalOrderDetailList[0].ordererHp+" | "+data.totalOrderDetailList[0].receiver+"&nbsp;"+data.totalOrderDetailList[0].receiverTel+","+data.totalOrderDetailList[0].receiverHp+""
	    	
	    	+"</td></tr><tr><td height='22' align='left'>"+data.totalOrderDetailList[0].deliverMemo+"["+data.totalOrderDetailList[0].inBank+"/"+data.totalOrderDetailList[0].saleChannel+"/"+data.totalOrderDetailList[0].orderChannel+"/"+data.totalOrderDetailList[0].useSavePrice+"]<br>"
	    	+"<input name='stockOptChange' type='text' id='textfield' size='55' onkeydown='javascript:if(event.keyCode==13){stockOptSave(\""+data.totalOrderDetailList[0].productCode+"\",\""+data.totalOrderDetailList[0].seq+"\");}' value = '"+data.totalOrderDetailList[0].stockOpt+"'>&nbsp;&nbsp;"
	    	+"<a href='javascript:stockOptSave(\""+data.totalOrderDetailList[0].productCode+"\",\""+data.totalOrderDetailList[0].seq+"\");'><img src='/images/button/s_button_03.gif' align='absmiddle'></a>"
	    	+"</td></tr></table></td><td valign='top' align='left'><table height='110' border='0' cellspacing='0' cellpadding='2'>"
	    	+"<tr><td align='center' height='60'><a href='javascript:onOrderInfoPopup(\""+data.totalOrderDetailList[0].seq+"\");'><img src='/images/button/btn_order.gif' width='86' height='54'></a>"
	    	+"</td></tr><tr><td height='25' align='center'><a href='javascript:onOrderChangePopup(\""+data.totalOrderDetailList[0].seq+"\");'><img src='/images/button/btn_chor.gif'></a>"
	    	+"</td></tr><tr><td height='25' align='center'><a href='javascript:exportDeliveryExcel(\""+data.totalOrderDetailList[0].seq+"\");'><img src='/images/button/btn_chorex.gif'></a>"
	    	+"</td></tr></table></td><td width='350' valign='top'>"
	    	+"<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
	    	+"<tr><td><textarea class='txa11' name='memo' cols='60' rows='8' readOnly>"+data.totalOrderDetailList[0].managerMemo+"</textarea>"
	    	+"</td></tr><tr><td height='23' align='left'>"
	    	+"<input name='memoChange' type='text' id='textfield' size='55' onkeydown='javascript:if(event.keyCode==13){memoSave(\""+data.totalOrderDetailList[0].seq+"\");}'>&nbsp;&nbsp;"
	    	+"<a href='javascript:memoSave(\""+data.totalOrderDetailList[0].seq+"\");'><img src='/images/button/s_button_03.gif' align='absmiddle'></a>"
	    	+"</td></tr></table></td></tr>";
		
	    $("#view_order_detail").fadeIn("slow");
		$("#view_order_detail").html(cContents);
	},
    error:function(request, status) {
        alert(status);
     },
    complete:function(xhr, textStatus) {
    	
     }
	});		
}

function memoSave(seq){	
	//var memoTmp = frm.memoChange.value +"\n"+frm.memo.value;
	var memoChange = frm.memoChange.value;
	var memo = frm.memo.value;
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
	    	viewList(seq);  
	    }
	});	
	
}

function statSave(){	
	var orderSeqStrTmp = frm.orderSeqStr.value;
	var orderStatStrTmp = frm.orderStatStr.value;
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"orderSeqStr": orderSeqStrTmp,
			"orderStatStr": orderStatStrTmp
	    },
	    dataType: "json",
	    url:"/admin/orderManage/saveStat.action",
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

function ajaxPageSplit(num) {
	frm.pageNumTmp.value = num;
	search(num);
}


function search(pageNum, eqNum){
	
	var siteCode = frm.siteCode.value;
	var startDay = frm.startDay.value;
	var endDay = frm.endDay.value;
	var nameSel = frm.nameSel.value;
	var nameText = frm.nameText.value;
	var companyCategory = frm.companyCategory.value;
	var shopId = frm.shopId.value;
	var accident = frm.accident.value;

	var orderName = "";
	var dName = "";
	var sDeliveryNo = "";
	var sTel = "";
	var sProducts = "";
	if(nameSel == "orderName"){
		orderName = nameText;
	}else if(nameSel == "sDeliveryNo"){
		sDeliveryNo = nameText;
    }else if(nameSel == "sTel"){
    	sTel = nameText;
    }else if(nameSel == "sProducts"){
    	sProducts = nameText;
    }else{
		dName = nameText;
	}
	var listScale = $("#listScale").val();
	
	
	$.ajax({
		
        type:"POST",
        cache: false,
        data:{
			"orderStat": "",
			"siteCode": siteCode,
			"startDay": startDay,
			"endDay": endDay,
			"pageNum": pageNum,
			"listScale": listScale,
			"orderName" : orderName,
			"dName" : dName,
			"companyCategory":companyCategory,
			"shopId" : shopId,
			"sDeliveryNo":sDeliveryNo,
			"sTel":sTel,
			"sProducts":sProducts,
			"accident" : accident 
        },
        dataType: "json",
        url:"/admin/orderManage/init.action",
        beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
        success:function(data, status) {
			var c = "";
			
			var cHeader = "<tr>"
				+"<td width='72' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>취소|취완</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>PR</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>수집</td>"
				+"<td width='85' align='center' bgcolor='e7e7e7' class='tx12B'>수집일</td>"
				+"<td width='85' align='center' bgcolor='e7e7e7' class='tx12B'>정보변경일</td>"
				+"<td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>상태</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>주문자</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>수령자</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>업체</td>"
				+"<td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
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
            	c = "<tr><td colspan='17' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>";
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
	                
	            	c += "<tr onclick='rowSelect(this, \""+this.seq+"\");' bgcolor='#FFFFFF' style=cursor:hand;>"
	      			  +"<td width='72' height='20' align='center'>"
	      			  +"<input type='checkbox' name='checkbox' id='checkboxA"+a+"' value='"+this.seq+"' onclick='chkYn(this.name,"+a+");'>"
	      			  +"<input type='checkbox' name='checkbox2' id='checkboxB"+a+"' value='"+this.seq+"' onclick='chkYn(this.name,"+a+");'></td>"
	      			  +"<td width='30' align='center' ><img src='/images/com/"+companyImage+".gif' title='"+this.companyName+"'></td>"
	      			  +"<td width='30' align='center' ><a href='"+marketTypeUrl+this.url+"'  target='_blank'><img src='/images/"+this.siteImg+".gif'></a></td>"
	      			  +"<td width='85' align='center' >"+this.collectDt+"</td>"
	      			  +"<td width='85' align='center' >"+this.modifyDt+"</td>"
	      			  +"<td width='60' align='center' ><font color="+fontColor2+">"+this.orderStat+"</font></td>"	      				  
	      			  +"<td width='55' align='center' bgcolor="+bbColor+"><div style='width:55px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>"+ordererTmp+"</div></td>"
	      			  +"<td width='55' align='center' ><div style='width:55px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>"+this.receiver+"</div></td>"
	      			  +"<td width='50' align='center' ><img src='/images/"+this.shopImg+".gif'></td>"
	      			  +"<td width='245' align='left' ><div style='width:240px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>["+this.brandNm+"]"+this.product+"</div></td>"
	      			  +"<td width='30' align='right' ><b>"+commify(this.orderQy)+"</b></td>"
	      			  +"<td width='30' align='right' ><a href='javascript:changeRealSrock(\""+this.productCode+"\", \""+this.product+"\", \""+this.realStock+"\", \""+this.stockOpt+"\");'>"+commify(this.realStock)+"</a></td>"
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
        /* error:function(request, status) {
           alert(status);
        }, */
        complete:function(xhr, textStatus) {
        	closeBlockUI();
        	var num = 1;
        	if(eqNum != null && eqNum != ""){
        		num = eqNum;
        	}
        	$("#search_total_order tr:eq("+num+")").click(); 
        	frm.checkAllA.checked = false;
        	frm.checkAllB.checked = false; 
        	$(".price").each(function(){
        		$(this).toPrice();
        	});    	
        }
	});
}

function rowSelect(obj, seq){
	trIndex = $("#search_total_order tr").index(obj);
	$("#search_total_order tr").css("backgroundColor","#FFFFFF");
	obj.style.backgroundColor="#e0eeee";
	viewList(seq);
	
}

function chkArrValue(){
	var arrChkVal ="";
	var arrChkValTwo ="";
	var checkAllAValue = frm.checkAllA.value;
	var checkAllBValue = frm.checkAllB.value;
	var checkedCnt = 0;
	$("[name=checkbox]").each(function(){
		if($(this).is(":checked")){
			arrChkVal += $(this).val()+","; 
			arrChkValTwo += checkAllAValue+",";	
			checkedCnt++;		
		}
	});

	$("[name=checkbox2]").each(function(){
		if($(this).is(":checked")){
			arrChkVal += $(this).val()+","; 
			arrChkValTwo += checkAllBValue+",";	
			checkedCnt++;		
		}
	});
	if(checkedCnt == 0){
		alert("체크하시고 체크전송하세요.");
		return;
	}
	frm.orderSeqStr.value = arrChkVal;
	frm.orderStatStr.value = arrChkValTwo;
	statSave();
}

function allChk(objNm){
	var tempNm = "";
	var tempNmTwo = "";
	
	if(objNm=="checkAllA"){
		tempNm = "checkbox";
		tempNmTwo = "checkbox2";
		frm.checkAllB.checked = false;
	}else{
		tempNm = "checkbox2";
		tempNmTwo = "checkbox";
		frm.checkAllA.checked = false;
	}
	
	if($("[name="+objNm+"]").is(":checked")){
		
		$("[name="+tempNm+"]").each(function(){
			$(this).attr("checked","checked");
			$("[name="+tempNmTwo+"]").removeAttr("checked");
		});
		
	}
	else{
		
		$("[name="+tempNm+"]").each(function(){
			$(this).removeAttr("checked");
		});
	}
	
}

function chkYn(objNm, aa){
	if(objNm == "checkbox"){		
		if($("#checkboxA"+aa).is(":checked") == true){
			$("#checkboxB"+aa).removeAttr("checked");
		}
	}else{
		if($("#checkboxB"+aa).is(":checked") == true){
			$("#checkboxA"+aa).removeAttr("checked");
		
		}
	}
}

function exportDeliveryExcel(seq){	
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"seq": seq
	    },
	    dataType: "json",
	    url:"/util/exportDeliveryExcel.action",
	    beforeSend:function(xhr) {
        	showMsg("데이터를 엑셀로 변환하고 있습니다.<br><br>잠시만 기다려 주세요!");
		},
        success:function(data, status) {
        	$("#fileDown").attr("src","/util/download.action?key=&fileName=exportDeliveryExcel.xls&orgFileName=exportDeliveryExcel.xls");
			                     
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	closeBlockUI();
        }
	});	
	
}
//간격조절 스트립트 끝
		
</script>
<form name="totalOrderFrm" method="post" onsubmit="return false">
<input type="hidden" name="orderSeqStr">
<input type="hidden" name="orderStatStr"> 
<input type="hidden" name="pageNumTmp" value="1">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 주문정보통합검색</td>
  </tr>
</table>
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
        <td width="390">
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
            <option value="sun">선플라워</option>         
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
          <select name="accident">
          	<option value="">사고여부</option>
            <option value="accidentY">배송사고</option>
            <option value="accidentN">사고미접수</option>
            <option value="accidentC">사고처리완료</option>
          </select>
        </td>
        <td width="220" align="right">
        	<select name="nameSel">
          		<option value="orderName">주문자</option>
          		<option value="dName">수령인</option>
          		<option value="sDeliveryNo">송장번호</option>
          		<option value="sTel">전화번호</option>
          		<option value="sProducts">제품명</option>
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
    <td width="1180" height="140" align="center" background="/images/osb_m.gif">
    <!--iframe start -->
    	<table width="1180" height="140" border="0" cellspacing="0" cellpadding="3" id="view_order_detail">
    	</table>
    <!--iframe end -->
    </td>
  </tr>
  <tr>
     <td height="18" background="/images/osb_b.gif"></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_total_order">
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="72" align="center">
    	<input type="checkbox" name="checkAllA" id="checkAllA" value="5" onclick="allChk('checkAllA');">
    	<input type="checkbox" name="checkAllB" id="checkAllB" value="6" onclick="allChk('checkAllB');"></td>
    <td width="80" height="30"><img src="/images/button/tb_check.gif" onClick="chkArrValue();"></td>
    <td width="896" align="center">
    	<div class="page_wrap">
			<div class="page" id="page" >
			</div>
		</div>
    </td>
    <td width="152"><iframe id='fileDown' src='about:blank;' frameborder='0' width=0 height=0></iframe></td>
  </tr>
</table>
</form>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->	
