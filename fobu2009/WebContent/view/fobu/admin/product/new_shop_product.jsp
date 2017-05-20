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
	var brandType = $("#brandType").val();
	var face = 	$("#face").val();
	var searchCompany = $("#searchCompany").val();
	var companyCategory = $("#companyCategory").val();
	var searchText = $("#searchText").val();
	$("#hdnPageNum").val(pageNum);
	
	$.ajax({
        type:"POST",
        cache: false,
        data:{
			"companyCategory": companyCategory,
			"marketType": marketType,
			"brandType": brandType,
			"searchCompany":searchCompany,
			"face": face,			
			"pageNum": pageNum,
			"listScale": listScale,
			"searchText": searchText
        },
        dataType: "json",
        url:"/admin/product/new_shop_product.action",
        beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
        success:function(data, status) {		
			
			var c = "";
			
			c    +="<tr>"
				  +"	<td width='30' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>선택</td>"
				  +"    <td width='75' align='center' bgcolor='e7e7e7' class='tx12B'>이미지</td>"
				  +"    <td width='80' align='center' bgcolor='e7e7e7' class='tx12B'>브랜드명</td>"
				  +"    <td width='70' align='center' bgcolor='e7e7e7' class='tx12B'>업체명</td>"
				  +"    <td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>매입가</td>"
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>판매가</td>"
				  +"    <td width='80' align='center' bgcolor='e7e7e7' class='tx12B'>마진금액</td>"
				  +"    <td width='180' align='center' bgcolor='e7e7e7' class='tx12B'>미등록 사업자</td>"
				  +"</tr>";
            
            var index = -1;
            $.each(data.listNewShopProduct, function() {  
                
            	index = index+1;
                
            	c +="<tr>"
            		+"  <td height='60' align='center' bgcolor='#FFFFFF'>"
            		+"  	<input type='checkbox' name='chk' id='chk' onclick='chkYN("+index+");'>"
            		+"  	<input type='hidden' name='checkbox' id='checkbox' value='false'>"            		
            		+"  	<input type='hidden' name='uid' id='uid' value='"+this.uid+"'>"
           			+"  </td>"
            	    +"	<td align='center' bgcolor='#FFFFFF'>";
            	 	if(this.titleImageFile.length > 0 ){
                c  +="  	<img src='<c:out value='${titleImgPath}'/>/"+this.titleImageFile+"' width='50' height='50' onclick='imageView(\"<c:out value='${titleImgPath2}'/>/"+this.titleImageFile+"\");' style='cursor:hand;'/>";
                 	}
            	 /* 	if(this.detailImageFile.length > 0){
            	 		doesImageExist("<c:out value='${detailImgPath}'/>/"+this.detailImageFile, this.seq);
            	c  +="      <img id='"+this.seq+"' src='/images/button/bkn_zoom.gif' width='16' height='16' onclick='imageView(\"<c:out value='${detailImgPath}'/>/"+this.detailImageFile+"\");' style='cursor:hand;'/>";
            	 	} 	 */
            	c  +="  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='hidden' name='brandCategory' id='brandCategory' value='"+this.brandCategory+"'>"
            	    +"  	<a href='/admin/product/product_updatePop.html?seq="+this.uid+"' target='_blank'>";
            	    if(this.brandNm.length > 0){
            	c  +=    	this.brandNm;
            	    }else{
                c  +="		<font color='red'>[브랜드 없음]</font>";
            	    }
            	c  +="		</a>"
            	    +"	</td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +       this.uid +"<br/>"
            	    +		this.company
            	    +"  </td>"
            	    +"  <td bgcolor='#FFFFFF'>"
            	    +"		<input type='text' name='product' id='product' value='"+this.product+"' style='width:70%;'/>"            	    
            	    +"      <a href='"+this.companyLinkUrl+this.corpProductCode+"' target='_blink'> <img src='/images/button/btn_link.gif' width='37' height='21' /></a><br/>"
            	    +"		<font color='blue'>" 
            	    +"		<span id='spanCategory' name='spanCategory'>"
            	    +			this.categoryNm1+">"+this.categoryNm2+">"+this.categoryNm3
            	    +"		</span>"
            	    +"		</font>"
            	    +"		<input type='hidden' name='category1' id='category1' value='"+this.category1+"'>"
            	    +"		<input type='hidden' name='category2' id='category2' value='"+this.category2+"'>"
            	    +"		<input type='hidden' name='category3' id='category3' value='"+this.category3+"'>"
            	    +"      <img src='/images/button/cate_sel.gif' style='cursor:hand;' width='50' height='21' onclick='openWindow(\"product_categoryPop.html?seq="+this.uid+"&cate1="+this.category1+"&cate2="+this.category2+"&cate3="+this.category3+"\", \"categoryPop\", 800, 300, \"no\");'/>"
            	    +"  </td>"
            	    +"  <td align='center'class='price' bgcolor='#FFFFFF'>"
            	    +"  	<input type='text'  style='text-align:right;' class='price' name='familyPrice' id='familyPrice' size='4' value='"+this.familyPrice+"'/>"
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +		commify(this.mallPrice)         	    
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +		commify(this.mallMarginPrice)+" ("+this.mallMarginRate+"%)"            	    
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>";
            	    if(this.fobu != 0)
                	    c+="<img src='/images/logo_fobu.gif' width='30' >";
               	    if(this.choco != 0)
               	    	c+="&nbsp;<img src='/images/logo_choco.gif' width='30'>";
             	    if(this.good != 0)
             	    	c+="&nbsp;<img src='/images/logo_gf.gif' width='30'>";
               	    //if(this.min != 0)
               	    //	c+="&nbsp;<img src='/images/logo_mintwin.gif' width='30'>";
               	    if(this.tmin != 0)
                	    c+="&nbsp;<img src='/images/logo_twin.gif' width='30'>";
            	  c+="  </td>"            	   
            	    +"</tr>";
            });
            $("#product_list").html(c);
            $("#page").html(data.pageSplit);
            $("#page2").html(data.pageSplit);

            var totalPage = Math.ceil(parseInt(data.listNewShopProductCount)/parseInt(listScale));
            $("#spanCount").html("전체 "+data.listNewShopProductCount+" 개 : "+pageNum+" / "+totalPage+" 페이지")
            
            if(index == -1)  
				$("#product_list").html(c+"<tr><td colspan='10' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>");
          
                      
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
	var rate = parseInt($("#allMarginRate").val())/parseInt(100);
	
	$("input[name=famliyPrice]").each(function(index,elem){
		var fee = $($("input[name=fee]").get(index)).val()/parseInt(100);

		var familyPrice = removeStr($(elem).val(),",");		
		//var value = parseInt(orginalPrice) / (1 - parseFloat(rate) - parseFloat(fee));
		var value = parseInt(familyPrice) / (1 - parseFloat(rate) - parseFloat(fee)-0.1);
		var roundVal = parseInt(Math.ceil(value/100)*100);
		
		var mallMarginPrice = (roundVal - familyPrice) - roundVal*fee - roundVal*0.1;
		var mallMarginRate = (1 - fee - 0.1 - familyPrice/roundVal)*100;
		//var mallMarginRate = (((roundVal - (roundVal*fee)-0.1) - orginalPrice)/roundVal)*100;
		mallMarginRate = Math.round(mallMarginRate*100)/100;
		
		
		$($("input[name=mallPrice]").get(index)).val(roundVal);
		$($("input[name=mallMarginPrice]").get(index)).val(mallMarginPrice).toPrice();
		$($("input[name=mallMarginRate]").get(index)).val(mallMarginRate);
	});
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
function onNewShopExcelRegist()
{
	var marketType = $("#marketType").val();	
	var companyCategory = $("#searchCompany").val();
		
	openWindow("new_shop_excel_registPop.html?marketType="+marketType+"&companyCategory="+companyCategory, "ExcelRegistPop", 800, 300, "no");
}

function onCategoryPop(){
	openWindow("product_categoryPop.html?seq=-1","categoryAllPop", 800, 300, "yes");
}

function setCategoryVal(cate1,cate2,cate3,cateNm1,cateNm2,cateNm3){
	
	$("[name=chk]").each(function(index,elem){
		if($(this).is(":checked")){
			$("[name=spanCategory]").eq(index).html(cateNm1+">"+cateNm2+">"+cateNm3);
			$("[name=category1]").eq(index).val(cate1);
			$("[name=category2]").eq(index).val(cate2);
			$("[name=category3]").eq(index).val(cate3);
		}
	});
	
}
</script>
<form name="productfrm" method="post" action="/admin/product/new_shop_product_save.action" target="iframe_proc">
<input id="hdnPageNum" name="hdnPageNum" type="hidden" value="1"/>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 신제품 관리</td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" background="/images/osb_t.gif">
	    <table width="1150" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="631" style="text-align: left;">
	        	
	       		<select name="marketType" id="marketType">
	          		<option value="aut" selected>옥션</option>
	          		<option value="gmk">지마켓</option>
	          		<option value="itp">인터파크</option>
	          		<option value="cyw">11번가</option>
	          		<option value="shn">스토어팜</option>
	          		<option value="sun">초코샵</option>
	        	</select>
	        	<select name="searchCompany" id="searchCompany">
	       			<option value="">전체업체</option>
	       			<c:forEach var="companyList" items="${listCompany}">
				        <option value='<c:out value="${companyList.seq}"/>'>
				        	<c:out value="${companyList.company}" />
				        </option>
			        </c:forEach>
	        	</select>
	        	<select name="brandType" id="brandType">
	          		<option value="Y" selected>브랜드 있음</option>
	          		<option value="N">브랜드 없음</option>
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
	      </tr>
	    </table>
    </td>
  </tr>
  <tr>
    <td><img src="/images/osb_b.gif" width="1200" height="27"></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="30" height="30" align="center">
    	<input type="checkbox" name="allCheck1" id="allCheck1" onclick='allChkYN();'/>
   	</td>
    <td width="600" style="vertical-align:middle;">
    	<select name="brandCategory2" id="brandCategory2">
          	<option value="0">브랜드</option>
          	<c:forEach var="brandList" items="${listBrand}">
	        	<option value='<c:out value="${brandList.code}"/>'>
	        	<c:out value="${brandList.codeName}" />
	        </option>
        	</c:forEach>
       	</select>
    	
       	&nbsp;
       	<img src="/images/button/tb_check.gif" style="cursor:hand;" onclick="productListSave();">
       	&nbsp;
       	<input type="button" width="100px" style="cursor:hand;" value="엑셀관련작업창" onclick="onNewShopExcelRegist();"/>
       	&nbsp;
       	<input type="button" width="100px" style="cursor:hand;" value="카테고리 설정" onclick="onCategoryPop();"/>
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


