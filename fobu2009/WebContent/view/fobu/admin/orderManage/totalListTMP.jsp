<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>
<%
System.out.println("totalOrderList---------------->"+ request.getAttribute("totalOrderList"));
%>

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
    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()-2);
    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		
	//$('#datepicker').val(year+"-"+mon+"-"+day);
	var siteCode = frm.siteCode.value;
	var startDay = frm.startDay.value;
	var endDay = frm.endDay.value;
	var nameSel = frm.nameSel.value;
	var nameText = frm.nameText.value;
	var orderName = "";
	var dName = "";
	if(nameSel == "orderName"){
		orderName = nameText;
	}else{
		dName = nameText;
	}  
	var listScale = parseInt(20);
	jQuery("#list2").jqGrid({
		
		type:"POST",
        cache: false,
        
	   	url:'/admin/orderManage/init.action',
		datatype: "json",
		data: {
			"orderStat": "",
			"siteCode": siteCode,
			"startDay": startDay,
			"endDay": endDay,
			"pageNum": 1,
			"listScale": listScale,
			"orderName" : orderName,
			"dName" : dName
        },		
	   	colNames:['취소','취완', '거래처', '수집','수집일','최종변경일','상태','주문자','수령자','업체명','제품명','수량','재고','원가','판매가','마진','%','배송'],
	   	colModel:[
	   		{name:'seq',index:'seq', width:20},
	   		{name:'seq',index:'seq', width:20},
	   		{name:'brand',index:'brand', width:100},
	   		{name:'siteCode',index:'siteCode', width:100},
	   		{name:'collectDt',index:'collectDt', width:100},
	   		{name:'modifyDt',index:'modifyDt', width:100},
	   		{name:'orderStat',index:'orderStat', width:100},
	   		{name:'ordererTmp',index:'ordererTmp', width:100},
	   		{name:'receiver',index:'receiver', width:100},
	   		{name:'shopId',index:'shopId', width:100},
	   		{name:'product',index:'product', width:100},
	   		{name:'orderQy',index:'orderQy', width:100},
	   		{name:'orderQy',index:'orderQy', width:100},
	   		{name:'originalPrice',index:'originalPrice', width:100},
	   		{name:'orderPrice',index:'orderPrice', width:100},
	   		{name:'orderQy',index:'orderQy', width:100},
	   		{name:'orderQy',index:'orderQy', width:100},
	   		{name:'deliverType',index:'deliverType', width:100}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#pager2',
	   	sortname: 'siteCode',
	    viewrecords: true,
	    sortorder: "desc",
	    jsonReader : {
            repeatitems: false
        },	    
	    caption:"주문정보통합목록"
	     
	});
	
	jQuery("#list2").jqGrid('navGrid','#pager2',{edit:false,add:false,del:false});


	//search(1);
	
	
});


function showMsg(str) {
	$.blockUI({ 
		message: str,
		css: { 
	        border: 'none', 
	        padding: '15px',
	        left: ($(window).width() - 300) /2 + 'px', 
	        width: '300px', 
	        textAlign: 'center', 
	        backgroundColor: '#000', 
	        opacity: .5, 
	        color: '#fff',
	        cursor: 'wait', 
	        fadeOut: 100          
		}, 
		overlayCSS:  { 
	        backgroundColor: 'white',
	        opacity:         0.5 
	    },
	    
	    centerX: true,
		  centerY: true
	}); 
}

function closeBlockUI(){
	$.unblockUI();
}

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
        
		$("#view_order_detail tr").remove();
		$("#view_order_detail").hide();
		var cContents = "<tr><td width='700'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr>"
	    	+"<td width='110' height='110' rowspan='5'><img src='/images/sdata/Bimg/"+data.totalOrderDetailList[0].uid+".jpg' width='100' height='100'></td>"
	    	+"<td height='24' class='tx12B'>"+data.totalOrderDetailList[0].product+"<a href='#'>"
	    	+"<img src='/images/button/btn_link.gif' width='37' height='21' align='absmiddle'></a>"
	    	+"</td></tr><tr><td height='24'><span class='tx12B'>["+data.totalOrderDetailList[0].orderCode+"]</span>"
	    	+"<span class='tx12BR'>"+data.totalOrderDetailList[0].deliverType+" | 가격 : "+data.totalOrderDetailList[0].orderPrice+" | 수량 : "+data.totalOrderDetailList[0].orderQy+"개 | </span>"
	    	+"</td></tr><tr><td height='24'><span class='tx12B'>["+data.totalOrderDetailList[0].receiverZipcode+"]</span>"+data.totalOrderDetailList[0].receiverAddress+"</td></tr>"
	    	+"<tr><td height='24'><span class='tx12B'></span> "+data.totalOrderDetailList[0].orderer+"&nbsp;"+data.totalOrderDetailList[0].ordererTel+","+data.totalOrderDetailList[0].ordererHp+" | "+data.totalOrderDetailList[0].receiver+"&nbsp;"+data.totalOrderDetailList[0].receiverTel+","+data.totalOrderDetailList[0].receiverHp+""
	    	+"</td></tr><tr><td height='24'>"+data.totalOrderDetailList[0].deliverMemo+"</td></tr></table></td><td><table width='100%' border='0' cellspacing='0' cellpadding='2'>"
	    	+"<tr><td align='center'><h3><a href='javascript:onPopup(\""+data.totalOrderDetailList[0].seq+"\");'><img src='/images/button/btn_order.gif' width='86' height='54'></a></h3>"
	    	+"</td></tr><tr><td align='center'><h3><a href='#'><img src='/images/button/btn_chor.gif' width='79' height='22'></a></h3>"
	    	+"</td></tr><tr><td align='center'>&nbsp;</td></tr></table></td><td width='380'>"
	    	+"<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
	    	+"<tr><td><textarea name='memo' cols='60' rows='6' readOnly>"+data.totalOrderDetailList[0].managerMemo+"</textarea>"
	    	+"</td></tr><tr><td height='23' align='left'>"
	    	+"<input name='memoChange' type='text' id='textfield' size='66'>&nbsp;&nbsp;"
	    	+"<a href='javascript:memoSave(\""+data.totalOrderDetailList[0].seq+"\");'><img src='/images/button/s_button_03.gif' width='30' height='18' align='absmiddle'></a>"
	    	+"</td></tr></table></td></tr>";  
		
	    $("#view_order_detail").fadeIn("slow");
		$("#view_order_detail").append(cContents);
	},
    error:function(request, status) {
        alert(status);
     },
    complete:function(xhr, textStatus) {
    	
     }
	});		
}

function onPopup(seq){
	window.open('/admin/orderManage/orderDetailP.html?seq=' + seq, 'orderDetailP', 'width=780, height=920, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}

function memoSave(seq){	
	var memoTmp = frm.memoChange.value +"\n"+frm.memo.value;
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"seq": seq,
			"memo": memoTmp
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


function search(pageNum){
	
	var siteCode = frm.siteCode.value;
	var startDay = frm.startDay.value;
	var endDay = frm.endDay.value;
	var nameSel = frm.nameSel.value;
	var nameText = frm.nameText.value;
	var orderName = "";
	var dName = "";
	if(nameSel == "orderName"){
		orderName = nameText;
	}else{
		dName = nameText;
	}
	//alert(nameSel);
	var listScale = parseInt(20);
	
	
	$.ajax({
		
        type:"POST",
        cache: false,
        data:{
			"orderStat": "",
			"siteCode": siteCode,
			"startDay": startDay,
			"endDay": endDay,
			"page": jQuery('#list2').jqGrid('getGridParam','page'),
			"rows": jQuery('#list2').jqGrid('getGridParam','rowNum'),
			"orderName" : orderName,
			"dName" : dName
        },
        dataType: "json",
        url:"/admin/orderManage/init.action",
        beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
        success:function(data, status) {
			//$("#page").empty();
			/*
			$("#view_order_detail tr").remove();
			$("#search_total_order tr").remove();
			var c = "";
			
			var cHeader = "<tr>"
				+"<td width='72' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>취소|취완</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>거래처</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>수집</td>"
				+"<td width='85' align='center' bgcolor='e7e7e7' class='tx12B'>수집일</td>"
				+"<td width='85' align='center' bgcolor='e7e7e7' class='tx12B'>최종변경일</td>"
				+"<td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>상태</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>주문자</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>수령자</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>업체명</td>"
				+"<td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
				+"<td width='28' align='center' bgcolor='e7e7e7' class='tx12B'>수량</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>재고</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>원가</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>판매가</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>마진</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>%</td>"
				+"<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>배송</td>"
				+"</tr>";  

			$("#search_total_order").append(cHeader);
			var a = 1;  
            //alert(data.totalOrderList);
            $.each(data.totalOrderList, function() {
               // var a = 1;
                //alert(data.totalOrderList[1]);
                //alert(this.product);
                //#dbe9ff
                var bbColor = '#FFFFFF';
                var ordererTmp = this.orderer;
                
                if(this.cnt > 1){
                	bbColor = '#e1f1c9';
                	ordererTmp = this.orderer + "("+this.cnt+")";
                }
                
            	c = "<tr onclick='rowSelect(this, \""+this.seq+"\");' bgcolor='#FFFFFF' style=cursor:hand;>"
      			  +"<td height='23' align='center'>"
      			  +"<input type='checkbox' name='checkbox' id='checkboxA"+a+"' value='"+this.seq+"' onclick='chkYn(this.name,"+a+");'>"
      			  +"<input type='checkbox' name='checkbox2' id='checkboxB"+a+"' value='"+this.seq+"' onclick='chkYn(this.name,"+a+");'></td>"
      			  +"<td align='center' ></td>"
      			  +"<td align='center' >"+this.siteCode+"</td>"
      			  +"<td align='center' >"+this.collectDt+"</td>"
      			  +"<td align='center' >"+this.modifyDt+"</td>"
      			  +"<td align='center' >"+this.orderStat+"</td>"
      				  
      			  +"<td align='center' bgcolor="+bbColor+">"+ordererTmp+"</td>"
      			  +"<td align='center' >"+this.receiver+"</td>"
      			  +"<td align='center' >"+this.shopId+"</td>"
      			  +"<td align='center' >"+this.product+"</td>"
      			  +"<td align='center' >"+this.orderQy+"</td>"
      			  +"<td align='center' ></td>"
      			  +"<td align='center' >"+this.originalPrice+"</td>"
      			  +"<td align='center' >"+this.orderPrice+"</td>"
      			  +"<td align='center' ></td>"
      			  +"<td align='center' ></td>"
      			  +"<td align='center' >"+this.deliverType+"</td>"
      			  +"</tr>";
            	$("#search_total_order").append(c);
            	a++;
            });
            $("#page").empty().append(data.pageSplit);
           // $("#page").append(data.pageSplit);

            //$("#count").remove();
            //alert(pageNum);
            var pageCount = "총 "+data.totalOrderCount +"건";
            $("#count").empty().append(pageCount);
            //$("#count").append(pageCount);
                    */
			var mydata = data.rows;
        			//alert(mydata[0]);
	    	for(var i = 0 ; i<=mydata.length;i++){
	    		jQuery("#list2").addRowData(i+1,mydata[i]);
	    	}
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	closeBlockUI();
        	$("#search_total_order tr:eq(1)").click(); 
        	frm.checkAllA.checked = false;
        	frm.checkAllB.checked = false; 
        	
        }
	});
}

function rowSelect(obj, seq){
	$("#search_total_order tr").css("backgroundColor","#FFFFFF");
	obj.style.backgroundColor="#e0eeee";
	viewList(seq);
	
}

function chkArrValue(){
	var arrChkVal ="";
	var arrChkValTwo ="";
	var checkAllAValue = frm.checkAllA.value;
	var checkAllBValue = frm.checkAllB.value;
	$("[name=checkbox]").each(function(){
		if($(this).is(":checked")){
			arrChkVal += $(this).val()+","; 
			arrChkValTwo += checkAllAValue+",";			
		}
	});

	$("[name=checkbox2]").each(function(){
		if($(this).is(":checked")){
			arrChkVal += $(this).val()+","; 
			arrChkValTwo += checkAllBValue+",";			
		}
	});
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
    <table width="1150" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width=331>
                      시작일 <input style="width:30%;" type="text" name="startDay" id="datepicker" readonly>
          ~
                      종료일 <input style="width:30%;" type="text" name="endDay" id="datepicker2" readonly>
        </td>
        <td width="257">
          <select name="select7">
          	<option>거래처</option>
          </select>
          <select name="select8">
            <option>업체</option>
          </select>
          <select name="siteCode" id="siteCode">
            <option>주문경로</option>
            <option value="지마켓">지마켓</option>
            <option value="옥션">옥션</option>
            <option value="11번가">11번가</option>
            <option value="인터파크">인터파크</option>
            <option value="직거래">직거래</option>
            <option value="사이트">사이트</option>
          </select>
        </td>
        <td width="230" align="right">
        	<select name="nameSel">
          		<option value="orderName">주문자</option>
          		<option value="dName">수령인</option>
            </select>
          <input name="nameText" type="text" size="20">
        </td>
        <td width="55" align="center">
        	<a href="javascript:search(1);"><img src="/images/button/btn_search.gif" width="48" height="24"></a>
        </td>
        <td align="right">
        	<div id="count" ></div>          
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="center" background="/images/osb_m.gif">
    <!--iframe start -->
    	<table width="1180" height="170" border="0" cellspacing="0" cellpadding="3" id="view_order_detail">
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
<table id="list2"></table>
<div id="pager2"></div>

<div class="page_wrap">
	<div class="page" id="page" >
	</div>
</div><!-- page_wrap -->

<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="72" align="center">
    	<input type="checkbox" name="checkAllA" id="checkAllA" value="5" onclick="allChk('checkAllA');">
    	<input type="checkbox" name="checkAllB" id="checkAllB" value="6" onclick="allChk('checkAllB');"></td>
    <td><img src="/images/button/tb_check.gif" width="80" height="21" onclick="chkArrValue();"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->	
