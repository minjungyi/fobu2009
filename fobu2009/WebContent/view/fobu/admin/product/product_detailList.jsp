<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>

<script language="javascript">
var fileExist = true;
var companyHtml = "";
$(function() {
	
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
	
	$("#searchText").keydown(function(e){
    	if(e.keyCode == 13){
    		search(1);
   		}
  	});
	
	//var now = new Date();
    //now.setMonth(now.getMonth()-3);
    //var year= now.getFullYear();
    //var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    //var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		
	//$('#datepicker').val(year+"-"+mon+"-"+day);
	$('#datepicker').val("2012-01-01");
	
	search(1);
});

function afterInit(){
	search($("#hdnPageNum").val());
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
function ajaxPageSplit(num) {
	search(num);
}
function search(pageNum){
	//초기화
	$("[name=allCheck1]").removeAttr("checked");
	$("[name=allCheck2]").removeAttr("checked");     

	
    
	var startDay = $('#datepicker').val();
	var endDay = $('#datepicker2').val();
	var listScale = $("#listScale").val();
	var searchCompany = $("#searchCompany").val();
	var searchStatus = $("#searchStatus").val();
	var searchField = $("#searchField").val();
	var searchText = $("#searchText").val();
	var searchBrand = $("#searchBrand").val();
	var searchCategory = $("#searchCategory").val();
	$("#hdnPageNum").val(pageNum);
	$.ajax({
        type:"POST",
        cache: false,
        data:{
			"startDay": startDay,
			"endDay": endDay,
			"searchCompany": searchCompany,
			"searchStatus": searchStatus,
			"searchField": searchField,
			"searchText": searchText,
			"searchBrand": searchBrand,		
			"searchCategory": searchCategory,
			"pageNum": pageNum,
			"listScale": listScale
			
        },
        dataType: "json",
        url:"/admin/product/product_list.action",
        beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
        success:function(data, status) {
			var time = new Date();        
			$("#test1").html(time.getHours()+"/"+time.getMinutes()+"/"+time.getSeconds());
			var selectVal = 0;
			var c = "";
			
			
			c =   "<tbody>"
				  + "<tr>"
				  +"	<td width='30' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>선택</td>"
				  +"    <td width='75' align='center' bgcolor='e7e7e7' class='tx12B'>이미지</td>"				  
				  +"    <td width='80' align='center' bgcolor='e7e7e7' class='tx12B'>브랜드명</td>"
				  +"    <td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
				  +"    <td width='120' align='center' bgcolor='e7e7e7' class='tx12B'>소재/재질<br/>-크기(중량/구성)</td>"
				  +"    <td width='120' align='center' bgcolor='e7e7e7' class='tx12B'>제조자/수입자(저자/출판사)<br/>-제조국</td>"
				  +"    <td width='120' align='center' bgcolor='e7e7e7' class='tx12B'>사용연령(적용대상)<br/>-제조일(출간일)</td>"				  
				  +"    <td width='120' align='center' bgcolor='e7e7e7' class='tx12B'>KC인증(각종인증)<br/>-품질보증기준</td>"
				  +"    <td width='145' align='center' bgcolor='e7e7e7' class='tx12B'>주의사항(상세사항)<br/>-기타사항</td>"
				  +"    <td width='70' align='center' bgcolor='e7e7e7' class='tx12B'>AS책임자(연락처)</td>"
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'><input type='checkbox' name='allCheck3' id='allCheck3' onclick='allChkYN2();'><br/>노출여부</td>"
				  +"</tr>";
				  
			var index = -1;
            for(var z = 0 ; z < data.listProduct.length ; z++){
            	index = index+1;     
                
				selectVal = data.listProduct[z].companyCategory;
				
				var detailDisplayChecked = "";
				
				if(data.listProduct[z].detailDisplay){
					detailDisplayChecked = "checked";
				}
				
            	c  +="<tr>"
            		+"  <td height='60' align='center' bgcolor='#FFFFFF'>"
            		+"  	<input type='checkbox' name='chk' id='chk' onclick='chkYN("+z+");'>"
            		+"		<input type='hidden' name='checkbox' id='checkbox' value='false'></td>"
            	    +"	<td align='center' bgcolor='#FFFFFF'>";
            	   
            	    if(data.listProduct[z].titleImageFile.length > 0 ){
            	c  +="  	<img src='<c:out value='${titleImgPath}' />/"+data.listProduct[z].titleImageFile+"' width='50' height='50' onclick='imageView(\"<c:out value='${titleImgPath2}'/>/"+data.listProduct[z].titleImageFile+"\");' style='cursor:pointer;' />";
            	    }
            	    
            	  	//상세 이미지파일 존재유무 확인
            	    if(data.listProduct[z].detailImageFile.length > 0){
            	    	doesImageExist("<c:out value='${detailImgPath}'/>/"+data.listProduct[z].detailImageFile,data.listProduct[z].seq);
                	    c  +="&nbsp;<img id='"+data.listProduct[z].seq+"' src='/images/button/bkn_zoom.gif' width='16' height='16' onclick='imageView(\"<c:out value='${detailImgPath}'/>/"+data.listProduct[z].detailImageFile+"\");' style='cursor:pointer;'/>";
            	    	                	    
            	    }
            	c  +="  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='hidden' id='seq' name='seq' value='"+data.listProduct[z].seq+"'/>"+data.listProduct[z].seq+"<br/>"
            	    +"		<input type='hidden' name='brandCategory' id='brandCategory' value='"+data.listProduct[z].brandCategory+"'>";            	    
            	    if(data.listProduct[z].brandNm.length > 0){
            	c  +=    	data.listProduct[z].brandNm;
            	    }else{
                c  +="		<font color='red'>[브랜드 없음]</font>";
            	    }
            	c  +="	</td>"
            	    +"  <td bgcolor='#FFFFFF'>"    
            	    +"		<a href='/admin/product/product_updatePop.html?seq="+data.listProduct[z].seq+"' target='_blank'>"
            		+       data.listProduct[z].product+"</a>&nbsp;"
            	    +"		<font color='blue'>" 
            	    +"		<span id='spanCategory' name='spanCategory'>"
            	    +		data.listProduct[z].categoryNm3
            	    +"		</span>"
            	    +"		</font><br/>"
            	    +"		-<input type='text' name='sizeOpt' id='sizeOpt' style='width:92%;' value='"+data.listProduct[z].sizeOpt+"' onkeyup='checkChange("+z+");'/>"
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='text' name='dMaterial' id='dMaterial' style='width:92%;' value='"+data.listProduct[z].dMaterial+"' onkeyup='checkChange("+z+");'/><br/>"
            	    +"		-<input type='text' name='dSize' id='dSize' style='width:90%;' value='"+data.listProduct[z].dSize+"' onkeyup='checkChange("+z+");'/>"
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='text' name='dManufacturer' id='dManufacturer' style='width:92%;' value='"+data.listProduct[z].dManufacturer+"' onkeyup='checkChange("+z+");'/><br/>"
            	    +"		-<input type='text' name='dManufacturerCountry' id='dManufacturerCountry' style='width:90%;' value='"+data.listProduct[z].dManufacturerCountry+"' onkeyup='checkChange("+z+");'/>"
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='text' name='dUseAge' id='dUseAge' style='width:92%;' value='"+data.listProduct[z].dUseAge+"' onkeyup='checkChange("+z+");'/><br/>"
            	    +"		-<input type='text' name='dMadeDate' id='dMadeDate' style='width:90%;' value='"+data.listProduct[z].dMadeDate+"' onkeyup='checkChange("+z+");'/>"
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='text' name='dKCcert' id='dKCcert' style='width:92%;' value='"+data.listProduct[z].dKCcert+"' onkeyup='checkChange("+z+");'/><br/>"
            	    +"		-<input type='text' name='dGuarantee' id='dGuarantee' style='width:90%;' value='"+data.listProduct[z].dGuarantee+"' onkeyup='checkChange("+z+");'/>"
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='text' name='dNotice' id='dNotice' style='width:92%;' value='"+data.listProduct[z].dNotice+"' onkeyup='checkChange("+z+");'/><br/>"
            	    +"		-<input type='text' name='dDescription' id='dDescription' style='width:90%;' value='"+data.listProduct[z].dDescription+"' onkeyup='checkChange("+z+");'/>"
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='text' name='dASManager' id='dASManager' style='width:92%;' value='"+data.listProduct[z].dASManager+"' onkeyup='checkChange("+z+");'/><br/>"      
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"  	<input type='checkbox' name='detailDisplay2' id='detailDisplay2' onclick='checkChange2("+z+");' "+detailDisplayChecked+">"
            	    +"		<input type='hidden' name='detailDisplay' id='detailDisplay' value='"+data.listProduct[z].detailDisplay+"'>"
            	    +"  </td></tr></tbody>";
            }
            $("#product_list").html(c);
            
            var totalPage = Math.ceil(parseInt(data.listProductCount)/parseInt(listScale));
            $("#spanCount").empty().html("전체 "+data.listProductCount+" 개 : "+pageNum+" / "+totalPage+" 페이지")
            
            //전체 21687 개 : 2 / 1085 페이지
            if(index == -1)  
				$("#product_list").html(c+"<tr><td colspan='10' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>");
			
            $("#page").html(data.pageSplit);
            $("#page2").html(data.pageSplit);
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

function productListSave(){
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
	frm.action = "/admin/product/product_save2.action";
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

function checkChange(index){	
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

function chkYN2(index){
	if($("[name=detailDisplay2]").eq(index).is(":checked")){
		$("[name=detailDisplay]").eq(index).val("true");
	}
	else{
		$("[name=detailDisplay]").eq(index).val("false");
	}
}
function checkChange2(index){	
	$("[name=chk]").eq(index).attr("checked","checked");
	$("[name=checkbox]").eq(index).val("true");
	chkYN2(index);
}
function allChkYN2(){
	if($("[name=allCheck3]").is(":checked")){
		$("[name=detailDisplay2]").each(function(){
			$(this).attr("checked","checked");
			chkYN2($("[name=detailDisplay2]").index(this));
		});
	}
	else{
		$("[name=detailDisplay2]").each(function(){
			$(this).removeAttr("checked");
			chkYN2($("[name=detailDisplay2]").index(this));
		});
	}
	
	$("[name=chk]").each(function(){
		$(this).attr("checked","checked");
		chkYN($("[name=chk]").index(this));
	});
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
<form name="productfrm" method="post" target="iframe_proc">
<input id="hdnPageNum" name="hdnPageNum" type="hidden" value="1"/>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 제품통합검색</td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" valign="bottom" background="/images/osb_t.gif"><table width="1160" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="36"  align="left">등록일 
          <input style="width:100px;" type="text" name="startDay" id="datepicker" readonly />
        	~
           	 
        	<input style="width:100px;" type="text" name="endDay" id="datepicker2" readonly />
           	<select name="searchCompany" id="searchCompany">
       			<option value="">전체업체</option>
       			<c:forEach var="companyList" items="${listCompany}">
			        <option value='<c:out value="${companyList.seq}"/>'>
			        	<c:out value="${companyList.company}" />
			        </option>
		        </c:forEach>
        	</select>
          	<select name="searchBrand" id="searchBrand">
              <option value="" selected="selected">전체브랜드</option>
              <c:forEach var="brandList" items="${listBrand}">
                <option value='<c:out value="${brandList.code}"/>'>
                	<c:out value="${brandList.codeName}" />
                </option>
              </c:forEach>
            </select>
          	<select name="searchField" id="searchField">            	
            	<option value="product">제품명</option>
            	<option value="A.seq">제품번호</option>                
          	</select>
          	<input type="text" name="searchText" id="searchText" size="25">
          	<a href="javascript:search(1);" ><img src="/images/button/btn_search.gif"></a></td>
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
    </table></td>
  </tr>
  <tr>
    <td align="center" background="/images/osb_m.gif">
    <!--iframe start -->
    <table width="1170" border="0" cellspacing="0" cellpadding="3">
      <tr>
        <td width="853" align="left">
        	상태검색 : 
             <select name="searchStatus" id="searchStatus">
            	<option value="">전체</option>
            	<option value="001" selected>판매중</option>
            	<option value="002">부분품절</option>
            	<option value="003">품절</option>            	            	
          	</select>
          	<select name='searchCategory' id='searchCategory'>
          		<option value="">전체</option>
            	<option value="001">카테고리 미설정</option>
            	<option value="002">카테고리 설정</option>
          	</select>     	
            <span name="test1" id="test1">1</span>
       	    <span name="test2" id="test2">2</span>        </td>
        <td width="123">&nbsp;</td>
        <td width="176" align="right">
       	</td>
        </tr>
    </table>
    <!--iframe end -->
    </td>
  </tr>
  <tr>
    <td height="23" background="/images/osb_b.gif"></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="30" height="30" align="center">
    	<input type="checkbox" name="allCheck1" id="allCheck1" onclick='allChkYN();'/>
   	</td>
    <td width="398">
    	<img src="/images/button/tb_check.gif"  style="cursor:pointer;" onclick="productListSave();"/>    	
    	<input type="button" width="100px" style="cursor:pointer;" value="카테고리 설정" onclick="onCategoryPop();"/>  	
   	</td>
    <td width="772" align="center">
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
    <td width="298">
    	<img src="/images/button/tb_check.gif" style="cursor:hand;" onclick="productListSave();" > <img src="/images/button/tb_com.gif" style="cursor:hand;"/>   	</td>
    <td width="872" align="center">
    	<div class="page_wrap">
			<div class="page" id="page" >
			</div>
		</div>
	</td>
  </tr>
</table>
</form>
<form action="/productUpload.action" method="post" enctype="multipart/form-data">  
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="4">
    <input type="file" name="file">&nbsp;&nbsp;&nbsp;<img src="/images/button/open_oder.gif" width="132" height="21" onclick="javeScript:submit();">
    </td>
  </tr>

</table>
 </form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
<iframe id='fileDown' src='about:blank;' frameborder='0' width=0 height=0></iframe>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>

<!-- top end-->


