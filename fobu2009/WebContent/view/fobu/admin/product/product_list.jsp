<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>

<script language="javascript">
var fileExist = true;
var companyHtml = "";
var frm = null;
var trIndex = 1;

$(function() {
	
	frm = document.all.productfrm;
	
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
	closeBlockUI();
	search($("#hdnPageNum").val());
	$("#newExcelFile").val("");
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
	$("#pageNumTmp").val(num);
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
	var orderField = $("#orderField").val();
	var category1 = $("#hdnSelCategory1").val();
	var category2 = $("#hdnSelCategory2").val();
	var category3 = $("#hdnSelCategory3").val();
	
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
			"orderField": orderField,
			"category1": category1,		
			"category2": category2,
			"category3": category3,
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
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>실재고</td>"
				  +"    <td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>발주</td>"
				  +"    <td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>누적</td>"				  
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>매입가</td>"
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>원가</td>"
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>판매가</td>"
				  +"    <td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>소비자가</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>업체코드</td>"
				  +"    <td width='100' align='center' bgcolor='e7e7e7' class='tx12B'>업체명</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>상태</td>"
				  +"</tr>";
				  
			var index = -1;
            for(var z = 0 ; z < data.listProduct.length ; z++){
            	index = index+1;       	               
            	
                var linkTag = "";
                if(data.listProduct[z].companyLinkUrl != null && data.listProduct[z].companyLinkUrl.length > 0){
                    linkTag = "<a href='"+data.listProduct[z].companyLinkUrl+data.listProduct[z].corpProductCode+"' target='_blank'> <img src='/images/button/btn_link.gif' width='37' height='21' /></a>";
                }
				
                var statusTag1="";
                var statusTag2="";
                var statusTag3="";
                // 상태값 설정
				if(data.listProduct[z].status == "001"){
					statusTag1 = "selected";
				}
				else if(data.listProduct[z].status == "002"){
					statusTag2 = "selected";
				}
				else{
					statusTag3 = "selected";
				}
				selectVal = data.listProduct[z].companyCategory;
				
				var fontColor2 = 'black';
                if(parseInt(data.listProduct[z].productOrderQySum) > parseInt(data.listProduct[z].realStock)){
                    fontColor2 = 'red';
                }else if(parseInt(data.listProduct[z].productOrderQySum) < parseInt(data.listProduct[z].realStock)){
                    fontColor2 = 'blue';
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
            		+       data.listProduct[z].product+"</a>"+ linkTag+"<br/>"
            	    +"		<font color='blue'>" 
            	    +"		<span id='spanCategory' name='spanCategory'>"
            	    +		data.listProduct[z].categoryNm1+">"+data.listProduct[z].categoryNm2+">"+data.listProduct[z].categoryNm3
            	    +"		</span>"
            	    +"		</font>"
            	    +"      <img src='/images/button/cate_sel.gif' width='50' height='21' style='cursor:hand;' onclick='openWindow(\"product_categoryPop.html?seq="+data.listProduct[z].seq+"&cate1="+data.listProduct[z].category1+"&cate2="+data.listProduct[z].category2+"&cate3="+data.listProduct[z].category3+"\", \"categoryPop\", 800, 300, \"no\");'/>"
            	    +"		<input type='hidden' name='category1' id='category1' value='"+data.listProduct[z].category1+"'>"
            	    +"		<input type='hidden' name='category2' id='category2' value='"+data.listProduct[z].category2+"'>"
            	    +"		<input type='hidden' name='category3' id='category3' value='"+data.listProduct[z].category3+"'>"            	   
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    //+"		<span style='cursor:hand;' onclick='openWindow(\"product_stockPop.html?uSeq="+data.listProduct[z].seq+"&realStock="+data.listProduct[z].realStock+"\", \"stockPop\", 420, 300, \"yes\");'>"            	   
            	    //+		data.listProduct[z].realStock            	    
            	    //+"		</span>"
            	    +"		<input type='hidden' name='realStock' id='realStock' style='width:92%;text-align:right;' value='"+data.listProduct[z].realStock+"' onkeyup='checkChange("+z+");'/>"
            	    +"   <font color="+fontColor2+">"+commify(data.listProduct[z].productOrderQySum)+"</font>/<a href='javascript:changeRealSrock2(\""+data.listProduct[z].seq+"\", \""+data.listProduct[z].product+"\", \""+data.listProduct[z].realStock+"\", \""+data.listProduct[z].stockOpt+"\");'>"+commify(data.listProduct[z].realStock)+"</a>"
            	    //+    calStock(data.listProduct[z].realStock,data.listProduct[z].productStock,data.listProduct[z].orderStock)
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"      <input name='enterpriseOrderQy' type='text' id='enterpriseOrderQy' class='number' size='4' onkeyup='checkChange("+z+");'/>"
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"+data.listProduct[z].orderStock+"</td>"            	   
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"  	<input type='text' name='originalPrice' id='originalPrice' class='price' style='width:92%;text-align:right;' value='"+data.listProduct[z].originalPrice+"' onkeyup='checkChange("+z+");'/></td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +" 		<input type='text' name='familyPrice' id='familyPrice' class='price' style='width:92%;text-align:right;' value='"+data.listProduct[z].familyPrice+"' onkeyup='checkChange("+z+");'/></td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"      <input type='text' name='sellPrice' id='sellPrice' class='price' style='width:92%;text-align:right;' value='"+data.listProduct[z].sellPrice+"' onkeyup='checkChange("+z+");'/></td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='text' name='retailPrice' id='retailPrice' class='price' style='width:92%;text-align:right;' value='"+data.listProduct[z].retailPrice+"' onkeyup='checkChange("+z+");'/></td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='text' name='corpProductCode' id='corpProductCode' style='width:95%;' value='"+data.listProduct[z].corpProductCode+"' onkeyup='checkChange("+z+");'/></td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"  <c:set var='companyCode' value='"+data.listProduct[z].companyCategory+"'></c:set>"
            	     
            	    +"  <select name='companyCategory' id='companyCategory' style='width:90%;' onchange='checkChange("+z+");'>"
            	    +"		<c:forEach var='companyList' items='${listCompany}'>";
            	    if(data.listProduct[z].companyCategory == "<c:out value='${companyList.seq}'/>"){
            	    	c+="			<option value='<c:out value='${companyList.seq}'/>' selected>"
                    	  +"			<c:out value='${companyList.company}' />"
                    	  +"			</option>";
            	    }else{
            	    	c+="			<option value='<c:out value='${companyList.seq}'/>' <c:if test='${companyList.seq==companyCode}'>selected</c:if>>"
                    	  +"			<c:out value='${companyList.company}' />"
                    	  +"			</option>";
            	    }
            	  
            	  c+="		</c:forEach>"
            	    +"  </select>" 
            	    +"	</td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<select name='status' onchange='checkChange("+z+");'>"
            	    +"    		<option value='001' "+statusTag1+">판매중</option>"
            	    +"    		<option value='002' "+statusTag2+">부분품절</option>"
            	    +"    		<option value='003' "+statusTag3+">품절</option>"
            	    +"    	</select><br/>"+data.listProduct[z].createDate
            	    +"  </td></tr></tbody>";  
            }
            $("#product_list").html(c);
            
            var totalPage = Math.ceil(parseInt(data.listProductCount)/parseInt(listScale));
            $("#spanCount").empty().html("전체 "+data.listProductCount+" 개 : "+pageNum+" / "+totalPage+" 페이지");
            
            //전체 21687 개 : 2 / 1085 페이지
            if(index == -1)  
				$("#product_list").html(c+"<tr><td colspan='14' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>");
			
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
	frm.action = "/admin/product/product_save.action";
	frm.submit();
}

function onEnterpriseOrderSave(){
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
	frm.action = "/admin/product/enterpriseOrder_save.action";
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
		$("input[name=chk]").prop("checked",true);
		$("[name=checkbox]").val("true");
	}
	else{
		$("input[name=chk]").prop("checked",false);
		$("[name=checkbox]").val("false");
		
	}
}
function exportExcel(){
	var startDay = $('#datepicker').val();
	var endDay = $('#datepicker2').val();
	var pageNumTmp = $("#hdnPageNum").val();
	var listScale = $("#listScale").val();
	var searchCompany = $("#searchCompany").val();
	var searchStatus = $("#searchStatus").val();
	var searchField = $("#searchField").val();
	var searchText = $("#searchText").val();
	var searchBrand = $("#searchBrand").val();
	var searchCategory = $("#searchCategory").val();
	var orderField = $("#orderField").val();
	var category1 = $("#hdnSelCategory1").val();
	var category2 = $("#hdnSelCategory2").val();
	var category3 = $("#hdnSelCategory3").val();
	
	var paramData = "startDay="+startDay+
	"&endDay="+endDay+
	"&searchCompany="+searchCompany+
	"&searchStatus="+searchStatus+
	"&searchField="+searchField+
	"&searchText="+searchText+
	"&searchBrand="+searchBrand+	
	"&searchCategory="+searchCategory+
	"&pageNum="+pageNumTmp+
	"&orderField="+orderField+
	"&listScale="+listScale+
	"&category1="+category1+
	"&category2="+category2+
	"&category3="+category3;
	document.target="_blank";
	document.location.href = "/admin/excel/product_excellist.html?"+paramData;
}

function exportExcel2(){
	
	var startDay = $('#datepicker').val();
	var endDay = $('#datepicker2').val();
	var listScale = $("#listScale").val();
	var searchCompany = $("#searchCompany").val();
	var searchStatus = $("#searchStatus").val();
	var searchField = $("#searchField").val();
	var searchText = $("#searchText").val();
	var searchBrand = $("#searchBrand").val();
	var pageNumTmp = $("#hdnPageNum").val();
	
	//alert(nameSel);
	var urlTmp = "/util/productListExcelEtc.action";
  	
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
		"pageNum": pageNumTmp,
		"listScale": listScale
        },
        dataType: "json",
        url:urlTmp,
        beforeSend:function(xhr) {
        	showMsg("데이터를 엑셀로 변환하고 있습니다.<br><br>잠시만 기다려 주세요!");
			//window.frames['fileDown'].location.reload();
			//document.getElementById('fileDown').contentWindow.location.href="/util/download.do?key=";
        	//var a = document.getElementById('fileDown').contentWindow.document;
        	//a.self.location.reload();
        	//a.close();
        	//a.open();
        	//$("#fileDown").src="";
		},
        success:function(data, status) {
			//document.getElementById('fileDown').contentWindow.location.href="/util/download.action?key=&fileName=myExcelTest.xls&orgFileName=myExcelTest.xls";
			//location.href("/util/download.action?key=&fileName=myExcelTest.xls&orgFileName=myExcelTest.xls");
        	$("#fileDown").attr("src","/util/download.action?key=&fileName=enterpriseOrderExcel.xls&orgFileName=enterpriseOrderExcel.xls");
        	//window.open('/admin/orderManage/excelDown.html', 'excelDownPopUp', 'width=432, height=369, toolbar=no, location=no, status=no, menubar=no, scrollbars=no');
			                     
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	closeBlockUI();
        	//document.getElementById('fileDown').contentWindow.location.href="/util/download.action?key=&fileName=myExcelTest.xls&orgFileName=myExcelTest.xls";
        }
	});
}
function onCategoryPop(){
	openWindow("product_categoryPop.html?seq=-1","categoryAllPop", 800, 300, "yes");
}

function onEnterpriseOrderPop(){
	openWindow("enterpriseOrder.html","enterpriseOrderPop", 800, 700, "yes");
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

function calStock(real,product,order){
	return parseInt(real) +parseInt(product)-parseInt(order); 	
}


function changeRealSrock2(productCode, product, realStock, stockOpt){	
	var pageNumPop = $("#hdnPageNum").val();
	window.open('/admin/orderManage/realStockPop.html?productCode='+productCode+'&stockOpt='+stockOpt+'&product='+product+'&realStock='+realStock+'&trIndex=0&pageNumPop='+pageNumPop, 'realStockPop99', 'width=830, height=550, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
	 
}

function onSaveNewProductExcel(){
	showMsg("저장중입니다...");
	$("#newFrm").submit();
}
function onCategoryPop2(){
	openWindow("product_categoryPop.html?seq=-99","categoryAllPop", 800, 300, "yes");
}
function setCategoryVal2(cate1,cate2,cate3,cateNm1,cateNm2,cateNm3){
	$("[name=spanSelCategory]").html(cateNm1+">"+cateNm2+">"+cateNm3);
	$("[name=hdnSelCategory1]").val(cate1);
	$("[name=hdnSelCategory2]").val(cate2);
	$("[name=hdnSelCategory3]").val(cate3);
	
	search(1);
}
function onCategoryInit(){
	$("[name=spanSelCategory]").html(" > > ");
	$("[name=hdnSelCategory1]").val("");
	$("[name=hdnSelCategory2]").val("");
	$("[name=hdnSelCategory3]").val("");
}
</script>
<form name="productfrm" method="post" target="iframe_proc">
<input id="hdnPageNum" name="hdnPageNum" type="hidden" value="1"/>
<input type="hidden" name="pageNumTmp" value="1">
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
                <option value='<c:out value="${brandList.code}"/>' <c:if test="${brandList.code == selectBrand}">selected</c:if>>
                	<c:out value="${brandList.codeName}" />
                </option>
              </c:forEach>
            </select>
            <select name="orderField" id="orderField">            	
            	<option value="000">정렬순서</option>
            	<option value="001">재고대</option>
            	<option value="002">재고소</option>
            	<option value="003">판매대</option>
            	<option value="004">판매소</option>            
          	</select>
          	<select name="searchField" id="searchField">            	
            	<option value="product">제품명</option>
            	<option value="A.seq">제품번호</option>
            	<option value="B.codeName">카테고리명</option>                
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
          	<span name="spanSelCategory" id="spanSelCategory">
          		<c:out value="${category1}" />><c:out value="${category2}" />><c:out value="${category3}" />
          	</span>
          	<input type="hidden" name="hdnSelCategory1" id="hdnSelCategory1" value="<c:out value="${category1}" />"/>
          	<input type="hidden" name="hdnSelCategory2" id="hdnSelCategory2" value="<c:out value="${category2}" />"/>
          	<input type="hidden" name="hdnSelCategory3" id="hdnSelCategory3" value="<c:out value="${category3}" />"/>
          	<input type="button" width="100px" style="cursor:pointer;" value="카테고리 선택" onclick="onCategoryPop2();"/>
          	<input type="button" width="100px" style="cursor:pointer;" value="초기화" onclick="onCategoryInit();"/>
            <span name="test1" id="test1">1</span>
       	    <span name="test2" id="test2">2</span>        </td>
        <td width="123">&nbsp;</td>
        <td width="176" align="right">
        	<a href="#" target="_blank"><img src="/images/button/tb_comlist.gif" style="cursor:hand;"/></a> 
        	<img src="/images/button/tb_excel.gif" style="cursor:hand;" onclick="exportExcel();"/>
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
    	<img src="/images/button/tb_com.gif" style="cursor:pointer;" onclick="onEnterpriseOrderSave();"/>
    	<input type="button" width="100px" style="cursor:pointer;" value="카테고리 설정" onclick="onCategoryPop();"/>  
    	<input type="button" width="100px" style="cursor:pointer;" value="업체 발주 팝업" onclick="onEnterpriseOrderPop();"/>   	 	
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
<form id="newFrm" action="/productUpload2.action" method="post" enctype="multipart/form-data" target="iframe_proc">  
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="4">
    <input type="file" id="newExcelFile" name="file">&nbsp;&nbsp;&nbsp;<img src="/images/button/open_oder.gif" width="132" height="21" onclick="onSaveNewProductExcel();">
    </td>
  </tr>

</table>
 </form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
<iframe id='fileDown' src='about:blank;' frameborder='0' width=0 height=0></iframe>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>

<!-- top end-->


