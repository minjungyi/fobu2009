<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>

<script language="javascript">

var frm = null;
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
	var now = new Date();
    var year= now.getFullYear();
    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		
	//$('#datepicker').val(year+"-"+mon+"-"+day);
	search(1);
	
	
});

function statSave(){	
	var siteCode = frm.siteCode.value;
	var accountCode = frm.accountCode.value;
	var accountCodeAll = frm.accountCodeAll.value;
	var startDay = frm.startDay.value;
	var endDay = frm.endDay.value;
	var nameSel = frm.nameSel.value;
	var nameText = frm.nameText.value;
	var companyCategory = frm.companyCategory.value;
	var shopId = frm.shopId.value;
	
	if(startDay=="" || startDay == null){
        alert("시작일을 입력하세요.");
        return;
    }
	
	if(endDay=="" || endDay == null){
        alert("종료일을 입력하세요.");
        return;
    }
	
	if(shopId=="" || shopId == null){
        alert("업체명을 선택하세요.");
        return;
    }
	
	var orderName = "";
	var dName = "";
	if(nameSel == "orderName"){
		orderName = nameText;
	}else{
		dName = nameText;
	}
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"orderStat": "",
			"accountCode" : accountCode,
			"accountCodeAll" : accountCodeAll,
			"siteCode": siteCode,
			"startDay": startDay,
			"endDay": endDay,
			"orderName" : orderName,
			"companyCategory":companyCategory,
			"shopId" : shopId,
			"dName" : dName
	    },
	    dataType: "json",
	    url:"/admin/accountManage/saveAccountStat.action",
	    //url:"/admin/accountManage/init.action",
	    beforeSend:function(xhr) {
			showMsg("<font size=2>저장중입니다....</font>");
		},
	    success:function(data, status) {
	    },
	    error:function(request, status) {
	        alert(status);
	    },
	    complete:function(xhr, textStatus) {
	    	closeBlockUI();
	    	search(frm.pageNumTmp.value);  
	    }
	});	
	
}

function ajaxPageSplit(num) {
	frm.pageNumTmp.value = num;
	search(num);
}


function search(pageNum){
	
	var siteCode = frm.siteCode.value;
	var accountCode = frm.accountCode.value;
	var accountCodeAll = frm.accountCodeAll.value;
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
	//alert(nameSel);
	var listScale = $("#listScale").val();
	
	
	$.ajax({
		
        type:"POST",
        cache: false,
        data:{
			"orderStat": "",
			"accountCode" : accountCode,
			"accountCodeAll" : accountCodeAll,
			"siteCode": siteCode,
			"startDay": startDay,
			"endDay": endDay,
			"pageNum": pageNum,
			"listScale": listScale,
			"orderName" : orderName,
			"companyCategory":companyCategory,
			"shopId" : shopId,
			"dName" : dName
        },
        dataType: "json",
        url:"/admin/accountManage/init.action",
        beforeSend:function(xhr) {
			showMsg("<font size=2>로딩중입니다...</font>");
		},
        success:function(data, status) {
			var c = "";
			
			var cHeader = "<tr>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>PR</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>수집</td>"
				+"<td width='85' align='center' bgcolor='e7e7e7' class='tx12B'>수집일</td>"
				+"<td width='85' align='center' bgcolor='e7e7e7' class='tx12B'>최종변경일</td>"
				+"<td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>상태</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>주문자</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>수령자</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>업체명</td>"
				+"<td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
				+"<td width='28' align='center' bgcolor='e7e7e7' class='tx12B'>수량</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>원가</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>판매가</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>마진</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>%</td>"
				+"<td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>배송</td>"
				+"<td width='60 align='center' bgcolor='e7e7e7' class='tx12B'>정산여부</td>"
				+"</tr>";
			var a = 1;  
			
			if(data.accountList.length == 0){
          		c = "<tr><td colspan='17' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>";
          		$("#search_total_order").html(cHeader+c);
            }else{
                
	            $.each(data.accountList, function() {
	               // var a = 1;
	                //alert(data.totalOrderList[1]);
	                //alert(this.product);
	                //#dbe9ff
	                var bbColor = '#FFFFFF';
	                if(this.cnt > 1){
	                	bbColor = '#e1f1c9';
	                }
	                
	                var fontColor = 'black';
	                if(this.deliverType == '착불'){
	                	fontColor = 'blue';
	                }
	                if(this.receiverAddress.substr(0,2) == '제주'){
	                	fontColor = 'red';
	                }
	                var value = parseInt(this.marginPrice) / (parseInt(this.orderPrice));
	        		var roundVal = Math.ceil(value*10000)/100;
	        		var companyImage = "";
	                if(this.companyCategory.length == 1){
	                	companyImage = "no0"+this.companyCategory;
	                }else{
	                	companyImage = "no"+this.companyCategory;
	                } 
	            	c += "<tr onclick='rowSelect(this, \""+this.seq+"\");' bgcolor='#FFFFFF' style=cursor:hand;>"
	      			  +"<td width='30' align='center' ><img src='/images/com/"+companyImage+".gif' title='"+this.companyName+"'></td>"
	      			  +"<td align='center' ><img src='/images/"+this.siteImg+".gif'></td>"
	      			  +"<td align='center' >"+this.collectDt+"</td>"
	      			  +"<td align='center' >"+this.modifyDt+"</td>"
	      			  +"<td align='center' >"+this.orderStat+"</td>"	      				  
	      			  +"<td align='center' bgcolor="+bbColor+">"+this.orderer+"</td>"
	      			  +"<td align='center' ><div style='width:55px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>"+this.receiver+"</div></td>"
	      			  +"<td align='center' ><img src='/images/"+this.shopImg+".gif'></td>"
	      			  +"<td align='left' ><div style='width:330px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>["+this.brandNm+"]"+this.product+"</div></td>"
	      			  +"<td align='center' >"+commify(this.orderQy)+"</td>"
	      			  +"<td align='center' >"+commify(this.originalPrice)+"</td>"
	      			  +"<td align='center' >"+commify(this.orderPrice)+"</td>"
	      			  +"<td align='center' >"+commify(this.marginPrice)+"</td>"
	      			  +"<td align='center' >"+roundVal+"</td>"
	      			  +"<td align='center' ><font color="+fontColor+">"+this.deliverType+"</font></td>"
	      			  +"<td align='center' >"+this.accountNm+"</td>"
	      			  +"</tr>";
	            	a++;
	            });
	            $("#search_total_order").html(cHeader+c);
            }
            var totalPage = Math.ceil(parseInt(data.accountCount)/parseInt(listScale));       
            $("#spanCount").empty().html("<font color='red'>Total "+commify(data.accountCount)+"</font> : "+commify(pageNum)+" / "+commify(totalPage)+" Page");
            $("#page").empty().html(data.pageSplit);  
                       
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	closeBlockUI();
        	$("#search_total_order tr:eq(1)").click(); 
        	$(".price").each(function(){
        		$(this).toPrice();
        	});        	
        }
	});
}

function rowSelect(obj, seq){
	$("#search_total_order tr").css("backgroundColor","#FFFFFF");
	obj.style.backgroundColor="#e0eeee";
	
}

function chkArrValue(){
	var accountCode = frm.accountCode.value;
	if(accountCode == "" || accountCode == "Y"){
		alert("정산여부를 미정산으로 조회하시고 정산하세요.");
		frm.accountCode.focus();
		return;
	}
	statSave();
}


//간격조절 스트립트 끝
		
</script>
<form name="totalOrderFrm" method="post" onsubmit="return false">
<input type="hidden" name="pageNumTmp" value="1">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 정산목록</td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" background="/images/osb_t.gif">
	    <table width="1150" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width=280>
	                      시작일 <input style="width:30%;" type="text" name="startDay" id="datepicker" readonly>
	          ~
	                      종료일 <input style="width:30%;" type="text" name="endDay" id="datepicker2" readonly>
	        </td>
	        <td width="310">
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
	        <td width="72" align="center">
			    <select name="accountCode" id="accountCode">
			       <option value="">정산여부</option>
			       <option value="Y">정산</option>
			       <option value="N">미정산</option>
			    </select>
		    </td>
	        <td width="220" align="right">
	        	<select name="nameSel">
	          		<option value="orderName">주문자</option>
	          		<option value="dName">수령인</option>
	            </select>
	          <input name="nameText" type="text" size="20">
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
	    </table>
	 </td>
  </tr>
  <tr>
    <td><img src="/images/osb_b.gif" width="1200" height="27"></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_total_order">
</table>

<div class="page_wrap">
	<div class="page" id="page" >
	</div>
</div><!-- page_wrap -->

<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="72" align="center">
	    <select name="accountCodeAll" id="accountCodeAll">
	       <option value="Y">정산</option>
	    </select>
    </td>
    <td><img src="/images/button/tb_check.gif" onclick="chkArrValue();"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->	
