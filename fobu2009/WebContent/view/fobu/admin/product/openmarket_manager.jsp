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
	var companyCategory = $("#companyCategory").val();
	var searchText = $("#searchText").val();
	var orderBy = $("#orderBy").val();
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
			"orderBy": orderBy
        },
        dataType: "json",
        url:"/admin/product/openmarketManager_list.action",
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
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>판매가</td>"
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>마진율</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>마진</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>패밀리가</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>수수료</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>히트수</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>상태</td>"
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
            	 	if(this.detailImageFile.length > 0){
            	    	doesImageExist("<c:out value='${detailImgPath}'/>/"+this.detailImageFile, this.seq);
            	c  +="      <img id='"+this.seq+"' src='/images/button/bkn_zoom.gif' width='16' height='16' onclick='imageView(\"<c:out value='${detailImgPath}'/>/"+this.detailImageFile+"\");' style='cursor:hand;'/>";
            	 	} 	
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
            	    +"  <td align='center' class='price'>"+this.mallPrice+"</td>"
            	    +"  <td align='center'>"+this.mallMarginRate+"</td>"
            	    +"  <td align='center' class='price'>"+this.mallMarginPrice+"</td>"
            	    +"  <td align='center' class='price'>"+this.familyPrice+"</td>"
            	    +"  <td align='center'>"+feeVal+"%</td>"
            	    +"  <td align='center'>"+this.hitCount+"</td>"
            	    +"  <td align='center'>"+this.openStatus+"</td>"
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
        		//$(this).html($(this).html().toPrice());
        		var val = commify($(this).text());
        		$(this).text(val);
        		//alert($(this).val().toPrice());
        	});
        	        	  	
        }
	});
}

function productListSave(){
	var frm = document.productfrm;
	//showMsg("1111");
	frm.submit();
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
function onSoldOut2(){
	
	window.open('/admin/product/popup_soldout.html?table=fobu', 'popup_soldout', 'width=1200, height=600, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}
</script>
<form name="productfrm" method="post" action="/admin/product/openMarketMargin_save.action" target="iframe_proc">
<input id="hdnPageNum" name="hdnPageNum" type="hidden" value="1"/>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 오픈마켓관리</td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" background="/images/osb_t.gif">
	    <table width="1150" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="680" style="text-align: left;">
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
	          		<option value="shn">샵N</option>
	        	</select>
	        	<select name="face" id="face">
	          		<option value="sell">판매중</option>
	          		<option value="soldout">품절</option>
	          		<option value="new">신제품</option>	          		
	        	</select>
	        	<select name="orderBy" id="orderBy">
	          		<option value="E.uid DESC">제품등록</option>
	          		<option value="G.hitCount DESC,E.uid DESC">히트수</option>
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
    	
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="30" height="30" align="center">
    	<input type="checkbox" name="allCheck1" id="allCheck1" onclick='allChkYN();'/>
   	</td>
    <td width="358" style="vertical-align:middle;">
    	<img src="/images/button/tb_check.gif"  style="cursor:hand;" onclick="productListSave();">
    	<input type="button" name="btnSoldOut2" id="btnSoldOut2" value="품절 하기" onclick="onSoldOut2();"></input>
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


