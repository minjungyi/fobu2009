<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>
<style>
<!--
.num_read{text-align:right;background-color:#D9D9D9;}
-->
</style>
<script language="javascript">
$(function() {
	$("#searchText").keydown(function(e){
    	if(e.keyCode == 13){
    		search(1);
   		}
  	});
	search(1);
});
var fileExist = true;
function afterInit(){
	search($("#hdnPageNum").val());
}
function ajaxPageSplit(num) {
	search(num);
}
function search(pageNum){
	//초기화
	$("[name=allCheck1]").removeAttr("checked");
	$("[name=allCheck2]").removeAttr("checked");
	
	var listScale = parseInt($("#listScale").val());
	var marketType = $("#marketType").val();
	var face = 	$("#face").val();
	var isFixPrice = 	$("#isFixPrice").val();
	var companyCategory = $("#companyCategory").val();
	var searchText = $("#searchText").val();
	$("#hdnPageNum").val(pageNum);
	
	$.ajax({
        type:"POST",
        cache: false,
        data:{
			"companyCategory": companyCategory,
			"marketType": marketType,
			"face": face,
			"searchText": searchText,
			"pageNum": pageNum,
			"listScale": listScale,
			"isFixPrice": isFixPrice
        },
        dataType: "json",
        url:"/admin/product/openMarketMargin_list.action",
        beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
        success:function(data, status) {
			var c = "";
			
			c    +="<tr>"
				  +"	<td width='30' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>선택</td>"
				  +"    <td width='75' align='center' bgcolor='e7e7e7' class='tx12B'>이미지</td>"
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>품번</td>"
				  +"    <td width='80' align='center' bgcolor='e7e7e7' class='tx12B'>브랜드명</td>"
				  +"    <td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
				  +"    <td width='80' align='center' bgcolor='e7e7e7' class='tx12B'>판매가</td>"				  
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>쿠폰<br/>할인율</td>"
				  +"    <td width='80' align='center' bgcolor='e7e7e7' class='tx12B'>실판매가</td>"
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>마진율</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>마진</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>패밀리가</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>수수료</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>개별연동</td>"
				  +"</tr>";
            
            var index = -1;
            $.each(data.listOpenMarketMargin, function() {  
                
            	index = index+1;
            	 var linkTag = "";
                 if(this.companyLinkUrl != null && this.companyLinkUrl.length > 0){
                     linkTag = "<a href='"+this.companyLinkUrl+this.corpProductCode+"' target='_blink'> <img src='/images/button/btn_link.gif' width='37' height='21' /></a>";
                 }
            	
                var feeArray = this.fee.split(',');
                var feeVal = 0;
                var marketType = $("#marketType").val();
                if(marketType == "gmk")
                	feeVal = feeArray[0];
                else if(marketType == "aut")
                	feeVal = feeArray[1];
                else if(marketType == "cyw")
                	feeVal = feeArray[2];
                else if(marketType == "itp")
                	feeVal = feeArray[3];
                else if(marketType == "shn")
                	feeVal = feeArray[4];
                else
                	feeVal = feeArray[5];
                
            	if(feeVal == undefined)
            		feeVal = 0;
            	
            	if(this.fixedPrice){
            		c  +="<tr bgColor='#e1f1c9'>";
            	}else{
            		c  +="<tr bgcolor='#FFFFFF'>";	
            	}            	
            	c  +="  <td height='60' align='center'>"
            		+"  	<input type='checkbox' name='chk' id='chk' onclick='chkYN("+index+");'>"
            		+"  	<input type='hidden' name='checkbox' id='checkbox' value='false'>"
            		+"  	<input type='hidden' name='openSeq' id='openSeq' value='"+this.openSeq+"'>"
            		+"  	<input type='hidden' name='uid' id='uid' value='"+this.uid+"'>"
            		+"  	<input type='hidden' name='addDeliverPrice' id='addDeliverPrice' value='"+this.addDeliverPrice+"'>"
            		+"  	<input type='hidden' name='isFreeDeliver' id='isFreeDeliver' value='"+this.isFreeDeliver+"'>"
           			+"  </td>"
            	    +"	<td align='center'>";
            	 	if(this.titleImageFile.length > 0 ){
                c  +="  	<img src='<c:out value='${titleImgPath}'/>/"+this.titleImageFile+"' width='50' height='50' onclick='imageView(\"<c:out value='${titleImgPath2}'/>/"+this.titleImageFile+"\");' style='cursor:hand;'/>";
                 	}
            	 /* 	if(this.detailImageFile.length > 0){
            	    	doesImageExist("<c:out value='${detailImgPath}'/>/"+this.detailImageFile, this.seq);
            	c  +="      <img id='"+this.seq+"' src='/images/button/bkn_zoom.gif' width='16' height='16' onclick='imageView(\"<c:out value='${detailImgPath}'/>/"+this.detailImageFile+"\");' style='cursor:hand;'/>";
            	 	} 	 */
            	c  +="  </td>"
            	    +"  <td align='center'>"+this.seq+"</td>"
            	    +"  <td align='center'><a href="+data.marketTypeUrl+this.url+"  target='_blank'><font color='red' style='font-weight:bold;'>"+marketType+"</font></a><br/>"
            	    +"		<input type='hidden' name='brandCategory' id='brandCategory' value='"+this.brandCategory+"'>";            	    
            	    if(this.brandNm.length > 0){
            	c  +=    	this.brandNm;
            	    }else{
                c  +="		<font color='red'>[브랜드 없음]</font>";
            	    }
            	c  +="	</td>"
            	    +"  <td>"
            	    +"  <a href='/admin/product/product_update.html?seq="+this.seq+"' target='_blank'>"
            	    +		this.product +"</a>"+ linkTag
            	    +"      <br/>"
            	    +"		<font color='blue'>" 
            	    +		this.categoryNm1+">"+this.categoryNm2+">"+this.categoryNm2
            	    +"		</font>"            	   
            	    +"      <img src='/images/button/cate_sel.gif' width='50' height='21' />";
            		if(this.isFreeDeliver){
                c   +=      "<font color='red'>&nbsp;&nbsp;&nbsp; 무료배송</font>";
                    }
            		if(this.fixedPrice){
                c   +=      "<font color='red'>&nbsp;&nbsp;&nbsp; 고정가> " +this.sellPrice+"</font>";
                    }
          
            		
            	c  +="  </td>"
            	    +"  <td align='center'class='price'>";
            	    //if(this.fixedPrice && marketType != "sun"){
            	    if(this.fixedPrice){
                    c+="<input type='text' style='text-align:right;' class='price' name='mallPrice' id='mallPrice' size='4' value='"+this.sellPrice+"' onkeyup='calc("+index+");' onclick='calcAll();'/>";
                    }
            	    else{
            	    c+="<input type='text' style='text-align:right;' class='price' name='mallPrice' id='mallPrice' size='4' value='"+this.mallPrice+"' onkeyup='calc("+index+");' onclick='calcAll();'/>";
            	    }
            	    
            	    c+="  </td>"
            	    +"  <td align='center'>"
                	+"  	<input type='text' class='num_read' name='couponSaleRate' id='couponSaleRate' size='3' value='"+this.couponSaleRate+"'/>"
                	+"  </td>"
                	+"  <td align='center'>"
                	+"  	<input type='text' class='num_read' name='couponSalePrice' id='couponSalePrice' size='3' value='"+this.couponSalePrice+"'/>"
                	+"  </td>"
            	    +"  <td align='center'>"
            	    +"  	<input type='text' class='num_read' name='mallMarginRate' id='mallMarginRate' size='3' value='"+this.mallMarginRate+"'/>"
            	    +"  </td>"
            	    +"  <td align='center'>"
            	    +"  	<input type='text' class='price num_read' name='mallMarginPrice' id='mallMarginPrice' size='4' value='"+this.mallMarginPrice+"'/>"
            	    +"  </td>"
            	    +"  <td align='center'>"
            	    +"  	<input type='text' class='price num_read' name='famliyPrice' id='famliyPrice' size='3' value='"+this.familyPrice+"' readonly/>"
            	    +"  </td>"
            	    +"  <td align='center'>"
            	    +"      <input type='text' class='num_read' name='fee' id='fee' size='3' value='"+feeVal+"' readonly />%"
            	    +"  </td>"
            	    +"  <td align='center'>"
            	    +"      연동"
            	    +"  </td>"
            	    +"</tr>";
            	   
				
            	
            });
            $("#product_list").html(c);
            $("#page").html(data.pageSplit);
            $("#page2").html(data.pageSplit);

            var totalPage = Math.ceil(parseInt(data.listOpenMarketMarginCount)/parseInt(listScale));
            $("#spanCount").html("전체 "+data.listOpenMarketMarginCount+" 개 : "+pageNum+" / "+totalPage+" 페이지")
            
            if(index == -1)  
				$("#product_list").html(c+"<tr><td colspan='11' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>");
          
                      
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
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

function productListSave(){
	var frm = document.productfrm;
	//showMsg("1111");
	frm.submit();
}

function rateApply(){
	showMsg("계산중입니다...");
	var rate = parseInt($("#allMarginRate").val())/parseInt(100);
	var saleRate =$("#saleRate").val();
	var marketType = $("#marketType").val();
	var couponPrice = 0;
	if(marketType == 'sun'){couponPrice = 0;}
	$("input[name=famliyPrice]").each(function(index,elem){
		
		var fee = $($("input[name=fee]").get(index)).val()/parseInt(100);
		var isFreeDeliver = $($("input[name=isFreeDeliver]").get(index)).val();
		var addDeliverPrice = $($("input[name=addDeliverPrice]").get(index)).val();
		
		var tempFprice = removeStr($(elem).val(),",");
		//배송비, 추가금액 할당
		var addPrice = $("#addPrice").val();
		// 배송비 무료일때 추가배송비 적용
		if(isFreeDeliver && marketType != 'sun'){
			addPrice = parseInt(addPrice) + parseInt(addDeliverPrice);
		}
		// 100쿠폰 적용으로 인한 -100적용
		var familyPrice = parseInt(tempFprice)+ couponPrice + parseInt(addPrice); 		
		var value = parseInt(familyPrice) / (1 - parseFloat(rate) - parseFloat(fee));
		//var value = (parseInt(familyPrice)) / (1 - parseFloat(rate) - parseFloat(fee)-0.1);
		var roundVal = parseInt(Math.ceil(value/100)*100);
		
		//var mallMarginPrice = (roundVal - familyPrice) - roundVal*fee - roundVal*0.1;
		var mallMarginPrice = (roundVal - familyPrice) - roundVal*fee;
		//var mallMarginRate = (1 - fee - 0.1 - familyPrice/roundVal)*100;
		var mallMarginRate = (1 - fee - familyPrice/roundVal)*100;
		//var mallMarginRate = (((roundVal - (roundVal*fee)-0.1) - orginalPrice)/roundVal)*100;
		mallMarginRate = Math.round(mallMarginRate*100)/100;
		
		
		$($("input[name=mallPrice]").get(index)).val(roundVal);
		$($("input[name=mallMarginPrice]").get(index)).val(mallMarginPrice).toPrice();
		$($("input[name=mallMarginRate]").get(index)).val(mallMarginRate);
		$($("input[name=couponSaleRate]").get(index)).val(saleRate);
		if(saleRate > 0){
			var roundVal2 = roundVal;
			var saleRate2 = parseInt($("#saleRate").val())/parseInt(100);
			roundVal2 = parseInt(roundVal2) * (1 - parseFloat(saleRate2));
			roundVal2 = parseInt(Math.ceil(roundVal2/100)*100);
			
			mallMarginPrice = (roundVal - familyPrice) - roundVal*fee;
			mallMarginRate = (1 - fee - familyPrice/roundVal2)*100;
			mallMarginRate = Math.round(mallMarginRate*100)/100;
			
			$($("input[name=mallMarginPrice]").get(index)).val(mallMarginPrice).toPrice();
			$($("input[name=mallMarginRate]").get(index)).val(mallMarginRate);
			$($("input[name=couponSalePrice]").get(index)).val(roundVal2);
		}else{
			$($("input[name=couponSalePrice]").get(index)).val(roundVal);
		}
	});
	
	closeBlockUI();
}
function chkYN(index){
	if($("[name=chk]").eq(index).is(":checked")){
		$("[name=checkbox]").eq(index).val("true");
	}
	else{
		$("[name=checkbox]").eq(index).val("false");
	}
}

function calcAll(){
	var marketType = $("#marketType").val();
	var couponPrice = 0;
	if(marketType == 'sun'){couponPrice = 0;}
	
	$("input[name=famliyPrice]").each(function(index,elem){
		var fee = $($("input[name=fee]").get(index)).val()/parseInt(100);
		var familyPrice = removeStr($($("input[name=famliyPrice]").get(index)).val(),",");	
		var isFreeDeliver = $($("input[name=isFreeDeliver]").get(index)).val();
		var addDeliverPrice = $($("input[name=addDeliverPrice]").get(index)).val();
		
		//배송비, 추가금액 할당
		var addPrice = $("#addPrice").val();
		if(isFreeDeliver && marketType != 'sun'){
			addPrice = parseInt(addPrice) + parseInt(addDeliverPrice);
		}
		var mallPrice = removeStr($($("input[name=mallPrice]").get(index)).val(),",");
		// 100쿠폰 적용으로 인한 -100적용
		var mallMarginPrice = parseInt(Math.ceil(mallPrice - (mallPrice*fee)- couponPrice - addPrice - familyPrice));
		
		var mallMarginRate = (mallMarginPrice/mallPrice)*100;
		mallMarginRate = Math.round(mallMarginRate*100)/100;
		
		if(mallMarginPrice < 0){
			$($("input[name=mallMarginPrice]").get(index)).val(mallMarginPrice);			
		}
		else{
			$($("input[name=mallMarginPrice]").get(index)).val(mallMarginPrice).toPrice();
		}
		
		$($("input[name=mallMarginRate]").get(index)).val(mallMarginRate);
		$($("input[name=couponSalePrice]").get(index)).val("0");
		$($("input[name=couponSaleRate]").get(index)).val("0");
	});
	
}
function calc(index){
	var marketType = $("#marketType").val();
	var couponPrice = 0;
	if(marketType == 'sun'){couponPrice = 0;}
	
	var fee = $($("input[name=fee]").get(index)).val()/parseInt(100);
	var familyPrice = removeStr($($("input[name=famliyPrice]").get(index)).val(),",");	
	var isFreeDeliver = $($("input[name=isFreeDeliver]").get(index)).val();
	var addDeliverPrice = $($("input[name=addDeliverPrice]").get(index)).val();
	var saleRate = $("#saleRate").val();
	//배송비, 추가금액 할당
	var addPrice = $("#addPrice").val();
	if(isFreeDeliver && marketType != 'sun'){
		addPrice = parseInt(addPrice) + parseInt(addDeliverPrice);
	}
	var mallPrice = removeStr($($("input[name=mallPrice]").get(index)).val(),",");
	// 100쿠폰 적용으로 인한 -100적용
	var mallMarginPrice = parseInt(Math.ceil(mallPrice - (mallPrice*fee)- couponPrice - addPrice - familyPrice));
	
	var mallMarginRate = (mallMarginPrice/mallPrice)*100;
	mallMarginRate = Math.round(mallMarginRate*100)/100;
	
	if(mallMarginPrice < 0){
		$($("input[name=mallMarginPrice]").get(index)).val(mallMarginPrice);			
	}
	else{
		$($("input[name=mallMarginPrice]").get(index)).val(mallMarginPrice).toPrice();
	}
	
	$($("input[name=mallMarginRate]").get(index)).val(mallMarginRate);
	
	$("[name=chk]").eq(index).attr("checked","checked");
	$("[name=checkbox]").eq(index).val("true");
}
function allChkYN(){
	if($("[name=allCheck1]").is(":checked") || $("[name=allCheck2]").is(":checked")){
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
function onSoldOut(){
	var companyCategory = $("#companyCategory").val();
	var marketType = $("#marketType").val();
	window.open('/admin/shoplinker/shoplinker_init.html?face=soldout&marketType='+marketType+'&companyCategory'+companyCategory, 'shoplinker_init', 'width=1000, height=400, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}

function onSoldOut2(){
	
	window.open('/admin/product/popup_soldout.html?table=fobu', 'popup_soldout', 'width=1200, height=600, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}

function onSoldOut3(){
	window.open('/admin/product/popup_soldout2.html?table=fobu', 'popup_soldout2', 'width=1200, height=600, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}
</script>
<form name="productfrm" method="post" action="/admin/product/openMarketMargin_save.action" target="iframe_proc">
<input id="hdnPageNum" name="hdnPageNum" type="hidden" value="1"/>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 가격관리</td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" background="/images/osb_t.gif">
	    <table width="1150" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="631" style="text-align: left;">
	        	<select name="companyCategory" id="companyCategory">
	            	<option value="">업체</option>
		            <c:forEach var="companyList" items="${listCompany}">
				        <option value='<c:out value="${companyList.seq}"/>'>
				        <c:out value="${companyList.company}" />
				        </option>
			        </c:forEach>
	          	</select> 
	       		<select name="marketType" id="marketType">
	          		<option value="aut" selected>옥션</option>
	          		<option value="gmk">지마켓</option>
	          		<option value="itp">인터파크</option>
	          		<option value="cyw">11번가</option>
	          		<option value="shn">스토어팜</option>
	          		<option value="sun">초코팝</option>
	        	</select>
	        	<select name="face" id="face">
	          		<option value="all">전체자료</option>
	          		<option value="new">신제품</option>
	          		<option value="soldout">품절</option>
	        	</select>
	        	<select name="isFixPrice" id="isFixPrice">
	          		<option value="">전체</option>
	          		<option value="1">고정가</option>
	          		<option value="0">마진가</option>
	        	</select>
	          	<input name="searchText" id="searchText" type="text" size="40">
	          	&nbsp;
	          	<a href="javascript:search(1);"><img src="/images/button/btn_search.gif"></a>
	          	
	        </td>
	        <td align="right">
				<span name="spanCount" id="spanCount"></span>
	          	<select name="listScale" id="listScale">
	          		<option value="3">3</option>
          			<option value="5">5</option>
		            <option value="20" selected>20</option>
		            <option value="50">50</option>
		            <option value="100">100</option>
		            <option value="200">200</option>
	           	</select>
	      	</td>
	     
	    </table>
    </td>
  </tr>
  <tr>
    <td><img src="/images/osb_b.gif" width="1200" height="27"></td>
  </tr>
</table>
<table width="1200" align="center" cellpadding="0" cellspacing="0">
 <tr>
  	<td align="right">
  		할인율 : 
  		<input type="text" name="saleRate" id="saleRate" style="width:50px;" value="0"/>
  		추가 할인 금액(배송비 포함):
		<input type="text" name="addPrice" id="addPrice" value="0" style="width:50px;"></input>
		적용 마진율:
    	<input type="text" name="allMarginRate" id="allMarginRate" style="width:50px;"></input>
		<input type="button" name="btnRateApply" id="btnRateApply" value="적용하기" onclick="rateApply();"></input>   		
  	</td>
  </tr>
</table>
    	
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="30" height="30" align="center">
    	<input type="checkbox" name="allCheck1" id="allCheck1" onclick='allChkYN();'/>
   	</td>
    <td width="450" style="vertical-align:middle;">
    	<img src="/images/button/tb_check.gif"  style="cursor:hand;" onclick="productListSave();">
    	<input type="button" name="btnSoldOut" id="btnSoldOut" value="품절 오픈마켓에 적용하기" onclick="onSoldOut();"></input>
    	<input type="button" name="btnSoldOut2" id="btnSoldOut2" value="품절 하기" onclick="onSoldOut2();"></input>
    	<input type="button" name="btnSoldOut3" id="btnSoldOut3" value="품절 하기2" onclick="onSoldOut3();">
    </td>
    <td align="center">
    	<div class="page_wrap">
			<div class="page" id="page2" >
			</div>
		</div>
	</td>
  </tr>
</table>
<table width="1200" id="product_list" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
  
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="30" height="30" align="center">
    	<input type="checkbox" name="allCheck2" id="allCheck2" onclick='allChkYN();'>
   	</td>
    <td width="298"><img src="/images/button/tb_check.gif" onclick="productListSave();"></td>
    <td width="872" align="center">
    	<div class="page_wrap">
			<div class="page" id="page" >
			</div>
		</div>
	</td>
  </tr>
</table>
</form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->


