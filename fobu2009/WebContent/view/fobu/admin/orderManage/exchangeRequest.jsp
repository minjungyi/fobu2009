<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>

<script language="javascript">

var frm = null;
var trIndex = 1;
//로딩

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
	    	+"<p><select name='memoSel' id='memoSel'><option value='택배접수'>택배접수</option><option value='반품입고'>반품입고</option><option value='배송비입금'>배송비입금</option><option value='배송비동봉'>배송비동봉</option><option value='교환완료'>교환완료</option>"
	        +"</select><a href='javascript:memoSave2(\""+data.totalOrderDetailList[0].seq+"\");'><img src='/images/button/s_button_03.gif' align='absmiddle'></a>"
	        +"<td height='22' class='tx12B' align='left'>["+data.totalOrderDetailList[0].brandNm+"]&nbsp;<a href='javascript:onProductUpdatePop(\""+data.totalOrderDetailList[0].productCode+"\")'>"+data.totalOrderDetailList[0].product+"</a>"
            +linkTag
            +"</td></tr><tr><td height='22' align='left'><span class='tx12B'>["+data.totalOrderDetailList[0].orderCode+"]</span>"
            +"<span class='tx12BR'>"+data.totalOrderDetailList[0].deliverType+" | 가격 : "+data.totalOrderDetailList[0].orderPrice+" | 수량 : "+data.totalOrderDetailList[0].orderQy+"개 | 옵션 : "+data.totalOrderDetailList[0].orderOption+"</span>"
            +"</td></tr><tr><td height='22' align='left'><span class='tx12B'>["+data.totalOrderDetailList[0].receiverZipcode+"]</span>"+data.totalOrderDetailList[0].receiverAddress+"</td></tr>"
            +"<tr align='left'><td height='22'><span class='tx12B'></span> "+data.totalOrderDetailList[0].orderer+"&nbsp;"+data.totalOrderDetailList[0].ordererTel+","+data.totalOrderDetailList[0].ordererHp+" | "+data.totalOrderDetailList[0].receiver+"&nbsp;"+data.totalOrderDetailList[0].receiverTel+","+data.totalOrderDetailList[0].receiverHp+""
            +"</td></tr><tr><td height='22' align='left'>"+data.totalOrderDetailList[0].deliverMemo+"<br/>"            
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
			"orderStat": "9",
			"siteCode": siteCode,
			"startDay": startDay,
			"endDay": endDay,
			"pageNum": pageNum,
			"listScale": listScale,
			"orderName" : orderName,
			"dName" : dName,
			"companyCategory":companyCategory,
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
				+"<td width='40' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>교완</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>PR</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>수집</td>"
				+"<td width='85' align='center' bgcolor='e7e7e7' class='tx12B'>수집일</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>주문자</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>수령자</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>업체명</td>"
				+"<td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>수량</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>재고</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>원가</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>판매가</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>마진</td>"
				+"<td width='45' align='center' bgcolor='e7e7e7' class='tx12B'>%</td>"
				+"<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>배송</td>"
				+"</tr>";  
			var a = 1; 
			if(data.totalOrderList.length == 0){
            	c = "<tr><td colspan='15' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>";
          		$("#search_total_order").html(cHeader+c);
            }else{
	            $.each(data.totalOrderList, function() {
	                 var fontColor = 'black';
	                 if(this.deliverType == '착불'){
	                	 fontColor = 'blue';
	                 }
	                 if(this.receiverAddress.substr(0,2) == '제주'){
	                	 fontColor = 'red';
	                 }
	                 var value = parseInt(this.marginPrice) / (parseInt(this.orderPrice));
			         var roundVal = Math.ceil(value*10000)/100;
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
	      			  +"<td width='40' height='20' align='center'>"
	      			  +"<input type='checkbox' name='checkbox' id='checkboxA"+a+"' value='"+this.seq+"'></td>"
	      			  +"<td width='30' align='center' ><img src='/images/com/"+companyImage+".gif' title='"+this.companyName+"'></td>"
	      			  +"<td width='30' align='center' ><a href='"+marketTypeUrl+this.url+"'  target='_blank'><img src='/images/"+this.siteImg+".gif'></a></td>"
	      			  +"<td width='85' align='center' >"+this.collectDt+"</td>"
	      			  +"<td width='55' align='center' ><div style='width:55px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>"+this.orderer+"</div></td>"
	      			  +"<td width='55' align='center' ><div style='width:55px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>"+this.receiver+"</div></td>"
	      			  +"<td width='50' align='center' ><img src='/images/"+this.shopImg+".gif'></td>"
	      			  +"<td align='left' ><div style='width:400px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>["+this.brandNm+"]"+this.product+"</div></td>"
	      			  +"<td width='30' align='right' ><b>"+commify(this.orderQy)+"</b></td>"
	      			  +"<td width='30' align='right' ><a href='javascript:changeRealSrock(\""+this.productCode+"\", \""+this.product+"\", \""+this.realStock+"\", \""+this.stockOpt+"\");'>"+commify(this.realStock)+"</a></td>"
	      			  +"<td width='50' align='right' >"+commify(parseInt(this.familyPrice)*parseInt(this.orderQy))+"</td>"
	      			  +"<td width='50' align='right' >"+commify(this.orderPrice)+"</td>"
	      			  +"<td width='50' align='right' >"+commify(this.marginPrice)+"</td>"
	      			  +"<td width='45' align='right' >"+roundVal+"</td>"
	      			  +"<td width='40' align='center' ><a href='javascript:onOrderInfoPopup(\""+this.seq+"\");'><font color="+fontColor+">"+this.deliverType+"</font></a></td>"
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
        	frm.checkAllA.checked = false;   	
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
	var checkedCnt = 0;
	
	$("[name=checkbox]").each(function(){
		if($(this).is(":checked")){
			arrChkVal += $(this).val()+","; 
			arrChkValTwo += checkAllAValue+",";		
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

		
</script>
<form name="totalOrderFrm" method="post" onsubmit="return false">
<input type="hidden" name="orderSeqStr">
<input type="hidden" name="orderStatStr">
<input type="hidden" name="pageNumTmp" value="1">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 교환요청</td>
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
          <select name="shopId">
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
        </td>
        <td width="220" align="right">
        	<select name="nameSel">
          		<option value="orderName">주문자</option>
          		<option value="dName">수령인</option>
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
    <td><img src="/images/osb_b.gif" width="1200" height="27"></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_total_order">
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="40" align="center">
    	<input type="checkbox" name="checkAllA" id="checkAllA" value="10" onclick="allChk('checkAllA');"></td>
    <td width="80"><img src="/images/button/tb_check.gif" onclick="chkArrValue();"></td>
    <td width="960" align="center">
	    <div class="page_wrap">
			<div class="page" id="page" >
			</div>
		</div>
    </td>
    <td width="120"><iframe id='fileDown' src='about:blank;' frameborder='0' width=0 height=0></iframe></td>
  </tr>
</table>
</form>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->	
