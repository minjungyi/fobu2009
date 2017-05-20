<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>::::::::: 직송주문요청 입니다 :::::::::</title>
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
$(function() {	
	/* $('#datepicker').datepicker({
		changeMonth: true,
		changeYear: true,
		yearRange: '2008:2020'
	});		
		
	var now = new Date();    
    var year= now.getFullYear();
    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		
	$('#datepicker').val(year+"-"+mon+"-"+day); */
	var companyCa = '${companyCategory}';
	$("#searchCompany").val(companyCa);
	search(1);
});
function afterInit(){
	search($("#hdnPageNum").val());
}

function ajaxPageSplit(num) {
	search(num);
}

function search(pageNum){	
	//초기화
	$("[name=allCheck1]").removeAttr("checked");
	$("#hdnPageNum").val(pageNum);
	//var startDay = $('#datepicker').val();	
	var listScale = $("#listScale").val();
	var searchCompany = $("#searchCompany").val();
	var searchStatus = $("#searchStatus").val();
	
	$.ajax({
        type:"POST",
        cache: false,
        data:{
			"searchCompany": searchCompany,
			"searchStatus":searchStatus,
			"pageNum": pageNum,
			"listScale": listScale
        },
        dataType: "json",
        url:"/admin/product/enterpriseOrder.action",
        beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
        success:function(data, status) {
			
			var selectVal = 0;
			var c = "";
			
			
			c =   "<tbody>"
				  + "<tr>"
				  +"	<td width='20' height='23' align='center' bgcolor='e7e7e7' class='tx12B'><input type='checkbox' name='allCheck1' id='allCheck1' onclick='allChkYN();'/></td>"
				  +"    <td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>이미지</td>"				  
				  +"    <td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>품번</td>"
				  +"    <td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>주문경로</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>원가</td>"
				  +"    <td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>주문<br/>재고</td>"
				  +"    <td width='85' align='center' bgcolor='e7e7e7' class='tx12B'>발주일<br/>주문형태</td>"	
				  +"</tr>";
				  
			var index = -1;
			var totalCnt = 0;
			var totalAmt = 0;
            for(var z = 0 ; z < data.listEnterpriseOrder.length ; z++){
            	index = index+1;       	               
            	totalAmt = parseInt(totalAmt) + (parseInt(data.listEnterpriseOrder[z].originalPrice)*parseInt(data.listEnterpriseOrder[z].enterpriseOrderQy));
                var linkTag = "";
                if(data.listEnterpriseOrder[z].companyLinkUrl != null && data.listEnterpriseOrder[z].companyLinkUrl.length > 0){
                    linkTag = "<a href='"+data.listEnterpriseOrder[z].companyLinkUrl+data.listEnterpriseOrder[z].corpProductCode+"' target='_blank'> <img src='/images/button/btn_link.gif' width='37' height='21' /></a>";
                }
                
                if(data.listEnterpriseOrder[z].enterpriseOrderStatus =="9999"){
            		c  +="<tr bgColor='#e1f1c9'>";
            	}else{
            		c  +="<tr bgcolor='#FFFFFF'>";	
            	}    
                
            	c  +="  <td height='60' align='center' >"
            		+"  	<input type='checkbox' name='chk' id='chk' onclick='chkYN("+z+");'>"
            		+"		<input type='hidden' name='checkbox' id='checkbox' value='false'></td>"
            	    +"	<td align='center' >";
            	   
            	    if(data.listEnterpriseOrder[z].titleImageFile.length > 0 ){
            	c  +="  	<img src='<c:out value='${titleImgPath}' />/"+data.listEnterpriseOrder[z].titleImageFile+"' width='50' height='50' onclick='imageView(\"<c:out value='${titleImgPath2}'/>/"+data.listEnterpriseOrder[z].titleImageFile+"\");' style='cursor:hand;' />";
            	    }
            	    
            	  	//상세 이미지파일 존재유무 확인
            	   // if(data.listEnterpriseOrder[z].detailImageFile.length > 0){
            	    //	doesImageExist("<c:out value='${detailImgPath}'/>/"+data.listEnterpriseOrder[z].detailImageFile,data.listEnterpriseOrder[z].seq);
                	 //   c  +="&nbsp;<img id='"+data.listEnterpriseOrder[z].seq+"' src='/images/button/bkn_zoom.gif' width='16' height='16' onclick='imageView(\"<c:out value='${detailImgPath}'/>/"+data.listEnterpriseOrder[z].detailImageFile+"\");' style='cursor:hand;'/>";
            	    	                	    
            	    //}
            	  	var orderTargetName = "";
            	  	if(data.listEnterpriseOrder[z].enterpriseOrderTarget =="0001")
            	  	{
            	  		orderTargetName = "주문";
            	  	}
            	  	else if(data.listEnterpriseOrder[z].enterpriseOrderTarget =="0001")
           	  		{
            	  		orderTargetName = "제품";
           	  		}
            	  	else if(data.listEnterpriseOrder[z].enterpriseOrderTarget =="0001")
           	  		{
            	  		orderTargetName = "개별재고";
           	  		}
            	  	
            	c  +=" </td>"
            	    +"  <td align='center' >"
            	    +"		<input type='hidden' id='seq' name='seq' value='"+data.listEnterpriseOrder[z].productSeq+"'/>"
            	    +"		<input type='hidden' id='enterpriseOrderSeq' name='enterpriseOrderSeq' value='"+data.listEnterpriseOrder[z].enterpriseOrderSeq+"'/>"+data.listEnterpriseOrder[z].productSeq+"<br/>"            	    
            	    +"	 </td>"
            	    +"  <td align='left'>"    
            	    +"		<a href='/admin/product/product_updatePop.html?seq="+data.listEnterpriseOrder[z].productSeq+"' target='_blank' title='"+data.listEnterpriseOrder[z].remark+"'>"
            		+       data.listEnterpriseOrder[z].product+"</a>"+ linkTag+"<br/>"     
            		+"		<input type='text' name='remark' id='remark'  style='width:92%;' value='"+data.listEnterpriseOrder[z].remark+"' onkeyup='checkChange("+z+");'/>"
            	    +"  </td>"
            	    +"<td>"
            	    +		orderTargetName
            	    +"</td>"
            	    +"  <td align='center' >"
            	    +"  	<input type='text' name='originalPrice' id='originalPrice' class='price' style='width:92%;text-align:right;' value='"+data.listEnterpriseOrder[z].originalPrice+"' readonly/>"
            	    +"  </td>"
            	    +"  <td align='center'>"
            	    +"      <input type='text' name='enterpriseOrderQy' id='enterpriseOrderQy' style='width:92%;text-align:right;' class='number'  value='"+data.listEnterpriseOrder[z].enterpriseOrderQy +"'' onkeyup='checkChange("+z+");'/>"
            	    +"      <input type='text' name='realStock' id='realStock' class='number' style='width:92%;text-align:right;'  value='"+data.listEnterpriseOrder[z].realStock +"''  readonly/>"
            	    +"  </td>"
            	    +"  <td align='center' >" 
            	    +  data.listEnterpriseOrder[z].createDate
            	    +"  </td></tr>"
            	    +"    <tr>"
            	    +"  <td align='center' bgcolor='#FFFFFF' colspan='2'>재고옵션"
            	    +"  </td>"
            	    +"  <td align='left' bgcolor='#FFFFFF' colspan='7'>"
            	    +"  <input name='stockOptChange"+index+"' type='text' id='textfield' size='55' onkeydown='javascript:if(event.keyCode==13){stockOptPackageSave2("+data.listEnterpriseOrder[z].productSeq+","+index+");}' value = '"+data.listEnterpriseOrder[z].stockOpt+"'>"
            	    +"    <a href='javascript:stockOptPackageSave2("+data.listEnterpriseOrder[z].productSeq+","+index+")'><img src='/images/button/s_button_03.gif' align='absmiddle'></a>"
            	    +"  </td>"
            	    +"  </tr>"
            	    "</tbody>";  
            }
            $("#product_list").html(c);
            
            var totalPage = Math.ceil(parseInt(data.listEnterpriseOrderCount)/parseInt(listScale));
            $("#totalStr").empty().html("총발주금액 : <strong>"+commify(totalAmt)+"원</strong>");
            
            //전체 21687 개 : 2 / 1085 페이지
            if(index == -1)  
				$("#product_list").html(c+"<tr><td colspan='14' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>");
			
            $("#page").html(data.pageSplit);
            //$("#page2").html(data.pageSplit);
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	var time = new Date();
            $("#test2").html(time.getHours()+"/"+time.getMinutes()+"/"+time.getSeconds());
        	closeBlockUI();
        	$(".price").each(function(){
        		$(this).toPrice();
        	});
        	$(".price").keyup(function(event){
        		$(this).toPrice();	
        	});
        }
	});
}


function stockOptPackageSave2(productCode, seqv){	
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

function doesImageExist(path,id)
{
	 fileExist = true;
     var oImg = new Image();
     //oImg.onload = function(){onImageEvent(oImg, true,path);};
     oImg.onerror = function(){onImageEvent(null, false,id);};
     oImg.src = path;
}

function onImageEvent(oImg, loaded,id)
{
     if(loaded)
     {    
          fileExist = true;
     }
     else
     {         
         fileExist = false;   
         $("#"+id).hide();
     }
}

function chkYN(index){
	if($("[name=chk]").eq(index).is(":checked")){
		$("[name=checkbox]").eq(index).val("true");
	}
	else{
		$("[name=checkbox]").eq(index).val("false");
	}
}

function allChkYN(){
	if($("[name=allCheck1]").is(":checked")){
		$("[name=chk]").each(function(){
			$(this).attr("checked","checked");
			chkYN($("[name=chk]").index(this));
		});
	}
	else{
		$("[name=chk]").each(function(){
			$(this).removeAttr("checked");
			chkYN($("[name=chk]").index(this));
		});
	}
}

function onUpdateEnterpriseOrderStatus(){
	var valid = 0;
	$("[name=checkbox]").each(function(){
		if($(this).val() == "true")
			valid = 1;			
	});
	if(valid == 0){
		showMsgNClose('체크된 항목이 없습니다.');	
		return;
	}
	
	var frm = document.productfrm;
	frm.action = "/admin/product/enterpriseOrderStatus_save.action";
	frm.submit();
}

function onUpdateEnterpriseOrderDel(){
	var valid = 0;
	$("[name=checkbox]").each(function(){
		if($(this).val() == "true")
			valid = 1;			
	});
	if(valid == 0){
		showMsgNClose('체크된 항목이 없습니다.');	
		return;
	}
	
	var frm = document.productfrm;
	frm.action = "/admin/product/enterpriseOrderStatus_del.action";
	frm.submit();
}

function onUpdateEnterpriseOrderQy(){
	var valid = 0;
	$("[name=checkbox]").each(function(){
		if($(this).val() == "true")
			valid = 1;			
	});
	if(valid == 0){
		showMsgNClose('체크된 항목이 없습니다.');	
		return;
	}
	
	var frm = document.productfrm;
	frm.action = "/admin/product/enterpriseOrderStatus_update.action";
	frm.submit();
}
function checkChange(index){	
	$("[name=chk]").eq(index).attr("checked","checked");
	$("[name=checkbox]").eq(index).val("true");
}

function exportExcel(arg){
    var now = new Date()
    var year= now.getFullYear();
    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
    
    var searchCompany = $("#searchCompany").val();
    var searchStatus = $("#searchStatus").val();
    var textYn = arg;
    var paramData = "searchCompany="+searchCompany+
    "&toDay="+year+mon+day+
    "&textYn="+textYn+
    "&searchStatus="+searchStatus;
    document.target="_blank";
    document.location.href = "/admin/excel/enterPriseOrder_excellist.html?"+paramData;
}

</script>
</head>
<body bgcolor="4b4b4b">
<form name="productfrm" method="post"  target="iframe_proc">
<input id="hdnPageNum" name="hdnPageNum" type="hidden" value="1"/>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" valign="bottom" background="/images/title_orderpt.gif">&nbsp;</td>
  </tr>
</table>
<table width="760" border="7" align="center" cellpadding="15" cellspacing="0" bordercolor="4b4b4b">
  <tr>
    <td align="center" bgcolor="#FFFFFF"><br>
      <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="467" height="30" align="left">
              <!-- <input style="width:100px;" type="text" name="startDay" id="datepicker" readonly /> -->
              <select name="searchCompany" id="searchCompany">
       			<option value="">전체업체</option>
       			<c:forEach var="companyList" items="${listCompany}">
			        <option value='<c:out value="${companyList.seq}"/>'>
			        	<c:out value="${companyList.company}" />
			        </option>
		        </c:forEach>
        	</select>
        	<select name="searchStatus" id="searchStatus">
          		<option value="" >전체</option>
          		<option value="0001"  selected>발주요청</option>
	            <option value="9999" >발주확정(입고)</option>
           	</select>
        	<select name="listScale" id="listScale">
          		<option value="3">3</option>
          		<option value="5">5</option>
	            <option value="20" >20</option>
	            <option value="50">50</option>
	            <option value="100">100</option>
	            <option value="200" selected>200</option>
           	</select>           	
            <a href="javascript:search(1);" ><img src="/images/button/btn_search.gif"></a>
          </td>
          <td width="233" height="25" align="right">
            <img src="/images/button/bn_ex_text.gif"  onclick="exportExcel('Y');"  style="cursor:hand;">
            <img src="/images/button/bn_ex_img.gif"  onclick="exportExcel('N');"  style="cursor:hand;">
          </td>
        </tr>
      </table>
      <table width="700" id="product_list" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
        <tr>
          <td width="20" height="23" align="center" bgcolor="e7e7e7" class="tx12B"><input type="checkbox" name="checkbox4" id="checkbox4" /></td>
          <td width="55" align="center" bgcolor="e7e7e7" class="tx12B">이미지</td>
          <td width="40" align="center" bgcolor="e7e7e7" class="tx12B">품번</td>
          <td align="center" bgcolor="e7e7e7" class="tx12B">제품명</td>
          <td width="60" align="center" bgcolor="e7e7e7" class="tx12B">원가<br>
            옵션</td>
          <td width="40" align="center" bgcolor="e7e7e7" class="tx12B">주문<br>
            재고</td>
          <td width="85" align="center" bgcolor="e7e7e7" class="tx12B">발주일<br>
            주문형태</td>
          </tr>
        <tr>
          <td height="60" align="center" bgcolor="#FFFFFF"><input type="checkbox" name="checkbox2" id="checkbox3" /></td>
          <td align="center" bgcolor="#FFFFFF"><a href="file:///E|/00오리지날사업/admin/order/대표이미지"><img src="file:///E|/00오리지날사업/admin/images/222.jpg" width="50" height="50" /></a></td>
          <td align="center" bgcolor="#FFFFFF">66645<br></td>
          <td bgcolor="#FFFFFF"><a href="file:///E|/00오리지날사업/admin/order/제품상세페이지">퓨리나 프로플랜 퍼포먼스 1kg</a> <img src="/images/button/btn_link.gif" width="37" height="21" /><br>
            블루로 주세요</td>
          <td align="center" bgcolor="#FFFFFF">5,000 <br>
          </td>
          <td align="center" bgcolor="#FFFFFF"><input name="textfield2" type="text" id="textfield8" size="4" />
            <br>
            555</td>
          <td align="center" bgcolor="#FFFFFF">12.02.14 05:30
            <br>
            관리자발주</td>
          </tr>
        
      </table>
      <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" align="right">
     		<span name="totalStr" id="totalStr"></span>       
			</td>
        </tr>
        <tr>
	        <td align="center">
	        	<div class="page_wrap">
					<div class="page" id="page" >
					</div>
				</div>
	        </td>
        </tr>
      </table>
      <br/>
        <img src="/images/button/prod_oder.gif" style="cursor:pointer;" onclick="onUpdateEnterpriseOrderStatus();" />
        <img src="/images/button/prod_modify.gif" style="cursor:pointer;" onclick="onUpdateEnterpriseOrderQy();">
        <img src="/images/button/prod_del.gif" style="cursor:pointer;" onclick="onUpdateEnterpriseOrderDel();"><br>
        
  </td>
  </tr>
</table>

</form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
</body>
</html>


