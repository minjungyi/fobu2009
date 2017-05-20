<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<title>제품 수정</title>
<script language="javascript">
$(function() {
	 
	$(".price").keyup(function(event){
		$(this).toPrice();	
	});

	$("#retailPrice").keyup(function(event){
		var retailPrice = removeStr($("#retailPrice").val(),",");

		$("#sellPrice").val(retailPrice).toPrice();
		$("#originalPrice").val(parseInt(retailPrice / 100 * $("#originalRate").val())).toPrice();
		$("#familyPrice").val(parseInt(retailPrice / 100 * $("#familyRate").val())).toPrice();
		$("#dealerPrice").val(parseInt(retailPrice / 100 * $("#dealerRate").val())).toPrice();
		$("#mallPrice").val(parseInt(retailPrice / 100 * $("#mallRate").val())).toPrice();
		
	});

	$(".number").keyup(function(event){
		$(this).val($(this).getOnlyNumeric());	
	});
	
	changeCateBind('1','0','true');
	companyBind();
	onChangeInfoCategory();
});

function afterInit(seq){
	location.href = "product_updatePop.html?seq="+seq;
	parent.showMsgNClose("제품이 등록되었습니다.");
}

// 카테고리 바인딩
function changeCateBind(num,seq,flag){
	
	$('#category'+num).empty();
	if(num =="2"){
		$('#category3').empty();
	}
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"category": seq
	    },
	    dataType: "json",
	    url:"/admin/product/product_category.action",
	    success:function(data, status) {
		    var i = 0;
	    	$.each(data.listCategory, function() {
	    		$('#category'+num).get(0).options[i] = new Option(this.codeName,this.code);
		    	i++;
	    	});

	    	// 수정데이터 세팅
	    	if(flag == "true")
	    	{
	    		var categoryVal = "";
		    	if(num == "1")
		    	{
		    		categoryVal = <c:out value="${listProductDetail[0].category1}"/>;
		    		$('#category'+num).val(categoryVal);
		    		changeCateBind('2',categoryVal,"true");
		    	}
	    		else if(num == "2")
	    		{
		    		categoryVal = <c:out value="${listProductDetail[0].category2}"/>;
		    		$('#category'+num).val(categoryVal);
		    		changeCateBind('3',categoryVal,"true");
	    		}
	    		else if(num == "3")
	    		{
	    			categoryVal = <c:out value="${listProductDetail[0].category3}"/>;
	    			$('#category'+num).val(categoryVal);
	    		}   				
	    	}	    	
		},
	    error:function(request, status) {
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {
	    	
	     }
	});		
}
// 업체 바인딩
function companyBind(){
	
	$('#companyCategory1').empty();
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
	    },
	    dataType: "json",
	    url:"/admin/product/product_company.action",
	    success:function(data, status) {
		    var i = 0;
	    	$.each(data.listCompany, function() {
	    		var tempVal = this.seq+"/"+this.originalRate+"/"+this.dealerRate+"/"+this.familyRate+"/"+this.mallRate+"/"+this.isFreeDeliver+"/"+this.isFixedPrice;
	    		$('#companyCategory1').get(0).options[i] = new Option(this.company,tempVal);
		    	i++;
	    	});
	    	
	    	$('#companyCategory1').find("option").each(function(){   // option 만큼 반복하면서
	    		var valArray = $(this).val().split('/');

	    		if(valArray[0] ==  "${listProductDetail[0].companyCategory}"){
		    		$(this).attr("selected","selected");
		    		selectCompany($(this).val());
		    		return;
	    		}
    		});	    	
	    	
		},
	    error:function(request, status) {
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {
	    	
	     }
	});		
}
// 카테고리 선택
function selectCompany(comCode){
	var valArray = comCode.split('/');
	$("#companyCategory").val(valArray[0]);
	$("#originalRate").val(valArray[1]);	
	$("#dealerRate").val(valArray[2]);
	$("#familyRate").val(valArray[3]);
	$("#mallRate").val(valArray[4]);
	
	var flag = $("#seq").val();
	if(flag == '-1'){
		if(valArray[5] =="true"){$("#isFreeDeliver").attr('checked',true);}
		else{$("#isFreeDeliver").attr('checked',false);};
		onFreeDeliverCheck();
		
		if(valArray[6]=="true"){$("#fixedPrice").attr('checked',true);}
		else{$("#fixedPrice").attr('checked',false);};
	}
	
}
function save(){
	
	var frm = document.productfrm;
	frm.submit();
}
//제품 등록
function save2(){
	
	if($("#companyCategory").val() == "" || $("#companyCategory").val() == null){
		showMsgNClose('업체는 필수 입력 사항입니다.');		
		$("#category1").focus();
		return;
	}
	
	if($("#category1").val() == "" || $("#category1").val() == null){
		showMsgNClose('1차 카테고리는 필수 입력 사항입니다.');		
		$("#category1").focus();
		return;
	}

	if($("#category2").val() == "" || $("#category2").val() == null){
		showMsgNClose('2차 카테고리는 필수 입력 사항입니다.');		
		$("#category1").focus();
		return;
	}

	if($("#category3").val() == "" || $("#category3").val() == null){
		showMsgNClose('3차 카테고리는 필수 입력 사항입니다.');		
		$("#category1").focus();
		return;
	}

	if($("#product").val() == "" || $("#product").val() == null){
		showMsgNClose('제품명은 필수 입력 사항입니다.');		
		$("#category1").focus();
		return;
	}

	if($("#retailPrice").val() == "" || $("#retailPrice").val() == null){
		showMsgNClose('소비자가는 필수 입력 사항입니다.');		
		$("#retailPrice").focus();
		return;
	}
	var frm = document.productfrm;
	frm.submit();
}
function sizeStock(){
	$("#tbRealStock tr").remove();
	var c= "";
	var sizeOpt = $("#sizeOpt").val();
	if(sizeOpt.length > 0){
		var valArray = sizeOpt.split('|');
		for(var i=0;i<valArray.length;i++){
			c+="<tr>"
			  +"<td>"+ valArray[i] +"<input type='hidden' id='sizeOptName' name='sizeOptName' value='"+ valArray[i] +"'></td>"
			  +"<td><input type='text' class='number' id='sizeOptStock' name='sizeOptStock' style='width:90%;' value='0'></td>"
			  +"</tr>";
		}
	}
	c+="<tr>"
	  +"<td>합계</td>"
	  +"<td><input type='text' class='number' id='realStock' name='realStock' style='width:90%;' value='0'></td>"
	  +"</tr>";
	$("#tbRealStock").append(c);

	$("[name=sizeOptStock]").keyup(function(event){
		$(this).val($(this).getOnlyNumeric());			
		calStock();	
	});
	//$("#tbRealStock tr").eq(0).remove();	
}
function calStock(){
	var tempStock = 0;
	$("[name=sizeOptStock]").each(function(){
		tempStock += parseInt($(this).val());
	});
	
	$("#realStock").val(tempStock);
}
function onFreeDeliverCheck(){	
	if($("#isFreeDeliver").is(":checked")){
		$("#addDeliverPrice").val(2500).toPrice();
		$("#deliverPrice").val(0).toPrice();
	}else{
		$("#addDeliverPrice").val(0).toPrice();
		$("#deliverPrice").val(2500).toPrice();
	}
}
function onStatusCheck(val){
	$("#status").val(val);
}
function onCopyNew(){
	$("#seq").val("-1");
	$("#spanNotice").html("복사 등록입니다.");
}

function onChangeInfoCategory(){
	var infoCategory = $('#infoCategory').val();
	
	if(infoCategory == '1'){
		//종류|소재|치수|제조자/수입자|제조국|취급시 주의사항|품질보증기준|A/S 책임자와 전화번호|비고
		settingInfoColumn("제품소재|색상|제조자/수입자|제조국|세탁방법 및 취급시 주의사항|제조연월|품질보증기준|A/S 책임자와 전화번호|비고||||");	
	}else if(infoCategory == '2'){
		//제품소재|색상|치수|제조자/수입자|제조국|취급시 주의사항|품질보증기준|A/S 책임자와 전화번호|비고
		settingInfoColumn("제품소재|색상|치수|제조자/수입자|제조국|취급시 주의사항|품질보증기준|A/S 책임자와 전화번호|비고||||");		
	}else if(infoCategory == '3'){
		//종류|소재|색상|크기|제조자/수입자|제조국|취급시 주의사항|품질보증기준|A/S 책임자와 전화번호|비고
		settingInfoColumn("종류|소재|색상|크기|제조자/수입자|제조국|취급시 주의사항|품질보증기준|A/S 책임자와 전화번호|비고|||");	
	}else if(infoCategory == '4'){
		//종류|소재|치수|제조자/수입자|제조국|취급시 주의사항|품질보증기준|A/S 책임자와 전화번호|비고
		settingInfoColumn("종류|소재|치수|제조자/수입자|제조국|취급시 주의사항|품질보증기준|A/S 책임자와 전화번호|비고||||");	
	}else if(infoCategory == '5'){
		//제품소재|색상|치수|제품구성|제조자/수입자|제조국|세탁방법 및 취급시 주의사항|품질보증기준|A/S 책임자와 전화번호|비고
		settingInfoColumn("제품소재|색상|치수|제품구성|제조자/수입자|제조국|세탁방법 및 취급시 주의사항|품질보증기준|A/S 책임자와 전화번호|비고|||");	
	}else if(infoCategory == '10'){
		//품명 및 모델명|KCC인증 및 필 유무|정격정압,소비전력,에너지소비효율등급|동일모델의 출시년월|제조자/수입자|제조국|크기/무게|주요 사양|품질보증기준|A/S 책임자와 전화번호|비고
		settingInfoColumn("품명 및 모델명|KCC인증 및 필 유무|정격정압,소비전력,에너지소비효율등급|동일모델의 출시년월|제조자/수입자|제조국|크기/무게|주요 사양|품질보증기준|A/S 책임자와 전화번호|비고||");	
	}else if(infoCategory == '15'){
		//품명 및 모델명|동일모델의 출시년월|자동차부품 자기인증 유무|제조자/수입자|제조국|크기|적용차종|품질보증기준|A/S 책임자와 전화번호|비고
		settingInfoColumn("품명 및 모델명|동일모델의 출시년월|자동차부품 자기인증 유무|제조자/수입자|제조국|크기|적용차종|품질보증기준|A/S 책임자와 전화번호|비고||||");	
	}else if(infoCategory == '17'){
		//품명 및 모델명|재질|구성품|크기|동일모델의 출시년월|제조자/수입자|제조국|수입여부|품질보증기준|A/S 책임자와 전화번호|비고
		settingInfoColumn("품명 및 모델명|재질|구성품|크기|동일모델의 출시년월|제조자/수입자|제조국|수입여부|품질보증기준|A/S 책임자와 전화번호|비고||");	
	}else if(infoCategory == '23'){
		//품명 및 모델명|KC인증 필|크기/무게|색상|제품소재|사용연령|동일모델의 출시년월|제조자/수입자|제조국|주의사항|품질보증기준|A/S 책임자와 전화번호|비고
		settingInfoColumn("품명 및 모델명|KC인증 필|크기/무게|색상|제품소재|사용연령|동일모델의 출시년월|제조자/수입자|제조국|주의사항|품질보증기준|A/S 책임자와 전화번호|비고");	
	}else if(infoCategory == '25'){
		//품명 및 모델명|크기/무게|색상|제품소재|제품구성|동일모델의 출시년월|제조자/수입자|제조국|상품별 세부사양|품질보증기준|A/S 책임자와 전화번호|비고
		settingInfoColumn("품명 및 모델명|크기/무게|색상|제품소재|제품구성|동일모델의 출시년월|제조자/수입자|제조국|상품별 세부사양|품질보증기준|A/S 책임자와 전화번호|비고|");	
	}else if(infoCategory == '26'){
		//도서명|저자,출판사|크기(전자책의 경우 파일용량)|쪽수(전자책의 경우 제외)|제품구성(전집 또는 세트일 경우 낱권구성,CD등)|출간일|목차 또는 책소개|비고|||||
		settingInfoColumn("도서명|저자,출판사|크기(전자책의 경우 파일용량)|쪽수(전자책의 경우 제외)|제품구성(전집 또는 세트일 경우 낱권구성,CD등)|출간일|목차 또는 책소개|비고|||||");	
	}else if(infoCategory == '35'){
		//품명 및 모델명|법적 인증/허가에 대한 확인가능사항|제조국/원산지|제조자/수입자|A/S책임자와 전화번호,소비자상담관련 전화번호|비고
		settingInfoColumn("품명 및 모델명|법적 인증/허가에 대한 확인가능사항|제조국/원산지|제조자/수입자|A/S책임자와 전화번호,소비자상담관련 전화번호|비고|||||||");		
	}else{
		settingInfoColumn("info1|info2|info3|info4|info5|info6|info7|info8|info9|info10|info11|info12|info13");
	}
}

function settingInfoColumn(strColName){
	var colArray = strColName.split('|');
	
	for(var i = 1 ;i <14;i++){
		$("#tdInfo"+i).text(colArray[i-1]);
	}
}
function onCategoryDetail(){
	var valCode = $("#category3").val();
	var valCategory = $("#category2").val();
		
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
	    	"category": valCategory,
	    	"code":valCode
	    },
	    dataType: "json",
	    url:"/admin/product/category_view.action",
	    success:function(data, status) {
	    		    	
	    	$('#infoCategory').val(data.categoryView[0].attrExt1);
	    	onChangeInfoCategory();
		},
	    error:function(request, status) {
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {
	    	
	     }
	});	
	
}

function changeRealSrock2(productCode, product, realStock, stockOpt){	
	var pageNumPop = 1;
	//alert(productCode+"/"+product+"/"+ realStock+"/"+ stockOpt);
	//var realStockPopPopWin2 = 
	//window.open('/admin/product/product_updatePop.html?seq=' + productCode, 'productUpdatePop', 'width=1200, height=750, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');	
	window.open('/admin/orderManage/realStockPop.html?productCode='+productCode+'&stockOpt='+stockOpt+'&product='+product+'&realStock='+realStock+'&trIndex=0&pageNumPop='+pageNumPop, 'realStockPop99', 'width=830, height=550, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
	//realStockPopPopWin2.focus(); 
}
</script>
</head>
<form name="productfrm" method="post" action="product_update.action" target="iframe_proc" enctype="multipart/form-data">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 제품등록</td>
	</tr>
</table>

<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td height="38" align="center" background="/images/osb_t.gif">
    		<table width="1150" border="0" cellspacing="0" cellpadding="0">
    		<tr>
    			<td id="spanNotice" style="color:red; text-align:left;"></td>
        		<td height="30" align="right"><a href="product_write.html"><img src="/images/button/prod_write.gif" width="83" height="24" align="absmiddle"/></a>&nbsp;&nbsp;<a href="javascript:onCopyNew();"><img src="/images/button/prod_copy.gif" width="83" height="24" align="absmiddle"/></a>&nbsp;&nbsp;<a href="#"><img src="/images/button/prod_del.gif" width="83" height="24"  align="absmiddle"/></a></td>
    		</tr>
    		</table>
   		</td>
	</tr>
  	<tr>
    	<td align="center" background="/images/osb_m.gif">
    	<table width="1160" border="0" cellspacing="0" cellpadding="3">
     		<tr>
		        <td width="25%"><strong>업체선택</strong></td>
		        <td width="25%"><strong>1차카테고리</strong></td>
		        <td width="25%"><strong>2차카테고리</strong></td>
		        <td width="25%"><strong>3차카테고리</strong></td>
      		</tr>
      		<tr>
	        	<td width="237">
		        	<select name='companyCategory1' id="companyCategory1" size='10' style='font-size:12px;width:260px;' onChange="selectCompany(this.value);">
		          		
			        </select>
			        <input type="hidden" id="companyCategory" name="companyCategory"/>
 		        </td>
        		<td width="816">
        			<select name='category1' id='category1'  size='10' style='font-size:12px;width:260px;' onChange="changeCateBind('2',this.value,'false');">
						
        			</select>
       			</td>
        		<td width="51">
        			<select name='category2' id='category2' size='10' style='font-size:12px;width:260px;' onChange="changeCateBind('3',this.value,'false');">
          				
        			</select>
       			</td>
        		<td width="52">
        			<select name='category3' id='category3' size='10' style='font-size:12px;width:260px;' onClick="onCategoryDetail();">
          				
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

<table width="1200" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
	<tr>
		<td width="12%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">제품명/검색어</td>
		<td width="38%" bgcolor="#FFFFFF">
			<span style="padding : 1 0 3 0">
	  		<input type="text" id="product" name="product" style="width:90%;" value='<c:out value="${listProductDetail[0].product}"/>'/>
	  		<input type="hidden" id="seq" name="seq" style="width:90%;" value='<c:out value="${listProductDetail[0].seq}"/>'/>
			</span>
		</td>
		<td width="10%" align="center" bgcolor="e7e7e7" class="tx12B">추가내용</td>
		<td width="40%" bgcolor="#FFFFFF">
			<span style="padding : 1 0 3 0">
	  		<input type="text" id="remark" name="remark" style="width:90%;" value='<c:out value="${listProductDetail[0].remark}"/>'/>
			</span>
		</td>
	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">사이즈옵션</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<!-- <input type="text" id="sizeOpt" name="sizeOpt" style="width:90%;" value='<c:out value="${listProductDetail[0].sizeOpt}"/>' onblur="sizeStock()"/> -->
      		<input type="text" id="sizeOpt" name="sizeOpt" style="width:90%;" value='<c:out value="${listProductDetail[0].sizeOpt}"/>' />
    		</span>
   		</td>
    	<td align="center" bgcolor="e7e7e7" class="tx12B">제품옵션</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="productOpt" name="productOpt" style="width:90%;" value='<c:out value="${listProductDetail[0].productOpt}"/>'/>
    		</span>
   		</td>
  	</tr>
  	<tr>
	    <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">색상옵션</td>
	    <td bgcolor="#FFFFFF">
	    	<span style="padding : 1 0 3 0">
	      	<input type="text" id="colorOpt" name="colorOpt" style="width:90%;" value='<c:out value="${listProductDetail[0].colorOpt}"/>'/>
	    	</span>
    	</td>
	    <td align="center" bgcolor="e7e7e7" class="tx12B">사은품옵션</td>
	    <td bgcolor="#FFFFFF">
	    	<span style="padding : 1 0 3 0">
	   		<input type="text" id="eventOpt" name="eventOpt" style="width:90%;" value='<c:out value="${listProductDetail[0].eventOpt}"/>'/>
	    	</span>
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">업체제품코드/바코드</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="corpProductCode" name="corpProductCode" style="width:45:%;" value='<c:out value="${listProductDetail[0].corpProductCode}"/>'/>
      		/
      		<input type="text" id="barCode" name="barCode" style="width:45:%;" value='<c:out value="${listProductDetail[0].barCode}"/>'/>
    		</span>
   		</td>
    	<td align="center" bgcolor="e7e7e7" class="tx12B">묶음/패키지코드</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type='text' name='packageCode' style='width:460' value='<c:out value="${listProductDetail[0].packageCode}"/>'/>
    		</span>
   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">제품가격</td>
   		<td colspan="3" bgcolor="#FFFFFF">
	   		<span style="padding : 1 0 3 0">
	   		소비자가
	     	<input type="text" class="price" id="retailPrice" name="retailPrice" style="width:80;" value='<c:out value="${listProductDetail[0].retailPrice}"/>'/>
	     	판매가
	     	<input type="text" class="price" id="sellPrice" name="sellPrice" style="width:80;" value='<c:out value="${listProductDetail[0].sellPrice}"/>'/>
		 	매입원가      
	 		<input type="text" class="price" id="originalPrice" name="originalPrice" style="width:80;" value='<c:out value="${listProductDetail[0].originalPrice}"/>'/>
	 		<input type="hidden" id="originalRate" name="originalRate" />	     	 
	     	추가비용
	     	<input type="text" class="price" id="minusPrice" name='minusPrice' style='width:80' value='<c:out value="${listProductDetail[0].minusPrice}"/>'/>
	    	</span>
   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">제품가격</td>
    	<td colspan="3" bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
    		패밀리가
        	<input type="text" class="price" id="familyPrice" name="familyPrice" style="width:80;" value='<c:out value="${listProductDetail[0].familyPrice}"/>'/>
        	<input type="hidden" id="familyRate" name="familyRate" />
      		딜러가
      		<input type="text" class="price" id="dealerPrice" name="dealerPrice" style="width:80;" value='<c:out value="${listProductDetail[0].dealerPrice}"/>'/>
      		<input type="hidden" id="dealerRate" name="dealerRate" />
      		쇼핑몰가
      		<input type="text" class="price" id="mallPrice" name="mallPrice" style="width:80;" value='<c:out value="${listProductDetail[0].mallPrice}"/>'/>
      		<input type="hidden" id="mallRate" name="mallRate" />
      		<input type='checkbox' name='fixedPrice' id='fixedPrice' maxlength='100' class='input2' 
      		       <c:if test="${listProductDetail[0].fixedPrice}">checked</c:if>/>
    		고정가 판매설정
    		<input type='checkbox' name='isFreeDeliver' id='isFreeDeliver' maxlength='100' class='input2' 
    				<c:if test="${listProductDetail[0].isFreeDeliver}">checked</c:if> onclick="onFreeDeliverCheck();"/>
    		무료배송여부
   			</span>
 		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">오픈마켓재고</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" class="number" id="stock" name="stock" style="width:90%;" value='<c:out value="${listProductDetail[0].stock}"/>'/>
    		</span>
   		</td>
    	<td height="23" align="center" bgcolor="e7e7e7" class="tx12B">실재고</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
    			<!-- IFNULL(A.realStock,0) + IFNULL(A.productStock,0) - IFNULL(A.orderStock,0) -->
    			<a href='javascript:changeRealSrock2("<c:out value="${listProductDetail[0].seq}"/>", "<c:out value="${listProductDetail[0].product}"/>", "<c:out value="${listProductDetail[0].realStock + listProductDetail[0].productStock - listProductDetail[0].orderStock}"/>", "<c:out value="${listProductDetail[0].stockOpt}"/>");'>
    			<c:out value="${listProductDetail[0].realStock + listProductDetail[0].productStock - listProductDetail[0].orderStock}"/>
    			</a>
    			<input type="hidden" class="number" id="realStock" name="realStock" style="width:90%;" value='<c:out value="${listProductDetail[0].realStock}"/>'/>
    		<!-- <table id="tbRealStock">
    			<c:forEach var="stockList" items="${listStock}">
					<tr>			
						<td><c:out value="${stockList.sizeOpt}"/>
						<input type='hidden' id='sizeOptName' name='sizeOptName' value='<c:out value="${stockList.sizeOpt}"/>'></td>
						<td>
							<input type="text" class='number' id="sizeOptStock" name="sizeOptStock" value="<c:out value="${stockList.sizeOptStock}"/>" style="text-align: right;"/>
						</td>
					</tr>
				</c:forEach>
	    		<tr>
		    		<td>합계</td>
		    		<td><input type="text" class="number" id="realStock" name="realStock" style="width:90%;" value='<c:out value="${listProductDetail[0].realStock}"/>'/></td>
	    		</tr>	    		
    		</table>   -->
      		
   			</span>
 		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">배송비</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" class="price" id="deliverPrice" name="deliverPrice" style="width:90%;" value='<c:out value="${listProductDetail[0].deliverPrice}"/>'/>
    		</span>
   		</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B">추가배송비</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text" class="price" id="addDeliverPrice" name="addDeliverPrice" style="width:90%;" value='<c:out value="${listProductDetail[0].addDeliverPrice}"/>'/>
    		</span>
   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">원산지</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="originCountry" name="originCountry" style="width:90%;" value='<c:out value="${listProductDetail[0].originCountry}"/>'/>
    		</span>
   		</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B">브랜드</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
      		<select name="brandCategory" id="brandCategory">
      			<option value="-1">선택하세요</option>            	
            	<c:forEach var="brandList" items="${listBrand}">	            	
            		<option value='<c:out value="${brandList.code}"/>' <c:if test="${listProductDetail[0].brandCategory == brandList.code}">selected</c:if>>
			        	<c:out value="${brandList.codeName}" />
			        </option>	            	
		        </c:forEach>
          	</select>
    		</span>
   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">노출금지</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type='checkbox' id='familyNoDisplay' name='familyNoDisplay' maxlength='100' class='input2' 
      				<c:if test="${listProductDetail[0].familyNoDisplay}">checked</c:if>/>
      		패밀리
    		</span>
    		<span style="padding : 1 0 3 0">
    		<input type='checkbox' id='dealerNoDisplay' name='dealerNoDisplay' maxlength='100' class='input2'
    				<c:if test="${listProductDetail[0].dealerNoDisplay}">checked</c:if>/>
    		딜러몰
    		</span>
    		<span style="padding : 1 0 3 0">
    		<input type='checkbox' id='mallNoDisplay' name='mallNoDisplay' maxlength='100' class='input2' 
    				<c:if test="${listProductDetail[0].mallNoDisplay}">checked</c:if>/>
    		쇼핑몰
    		</span>
   		</td>
    	<td align="center" bgcolor="e7e7e7" class="tx12B">상태</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type='radio' name='status2' id='status2' class='input2' value="001" onclick="onStatusCheck('001')"
      				<c:if test="${listProductDetail[0].status =='001'}">checked</c:if>/>
    		</span>판매중
    		<span style="padding : 1 0 3 0">
    		<input type='radio' name='status2' id='status2' class='input2' value="002" onclick="onStatusCheck('002')"
    				<c:if test="${listProductDetail[0].status =='002'}">checked</c:if>/>
    		</span>부분품절
    		<span style="padding : 1 0 3 0">
    		<input type='radio' name='status2' id='status2' class='input2' value="003" onclick="onStatusCheck('003')"
    				<c:if test="${listProductDetail[0].status =='003'}">checked</c:if>/>
    		</span>품절
    		<input type='hidden' name='status' id='status' value='<c:out value="${listProductDetail[0].status}"/>'/>
   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">대표이미지</td>
    	<td bgcolor="#FFFFFF">
    		<input type='text' id='titleImageFile'  name='titleImageFile' style='width:80%;border:0px;'  value='<c:out value="${listProductDetail[0].titleImageFile}"/>' readonly />
    		<br/>
    		<span style="padding : 1 0 3 0">
      		<input type='file' id='titleImageFile1'  name='titleImageFile1' style='width:80%;' />
    		<!--<img src="/images/button/btn_search1.gif" width="71" height="22" / align="absmiddle" /> -->
  			</span>
		</td>
		<td colspan="2" rowspan="2" align="center" bgcolor="#FFFFFF" class="tx12B">
			<img src="<c:out value="${titleImgPath}"/>/<c:out value="${listProductDetail[0].titleImageFile}"/>" style="cursor:pointer;" width="100" height="100" id="imgTitle" onclick="imageView('<c:out value="${titleImgPath}"/>/<c:out value="${listProductDetail[0].titleImageFile}"/>');"  />
		</td>
	</tr>
	<tr>	
    	<td align="center" bgcolor="e7e7e7" class="tx12B">상세설명이미지</td>
    	<td bgcolor="#FFFFFF">
    		<input type='text' id='detailImageFile'  name='detailImageFile' style='width:80%; border:0px;' value='<c:out value="${listProductDetail[0].detailImageFile}"/>' readonly/>
    		<br/>
    		<span style="padding : 1 0 3 0">
      		<input type='file' name='detailImageFile1' name='detailImageFile1' style='width:80%;'/>
      		<!-- <img src="/images/button/btn_search1.gif" width="71" height="22" / align="absmiddle">-->
      		</span>
   		</td>
  	</tr>
</table>
<br/>
<!--Start 상세정보 추가 부분 시작 -->
<table width="1200" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
	<tr>
		<td width="12%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">정보공시 카테고리</td>
		<td width="38%" bgcolor="#FFFFFF" colspan="3">
			<span style="padding : 1 0 3 0">
	  		<select name="infoCategory" id="infoCategory" onChange="onChangeInfoCategory()">
      			<option value="-1">선택하세요</option>            	
            	<c:forEach var="infoCategoryList" items="${listInfoCategory}">	            	
            		<option value='<c:out value="${infoCategoryList.code}"/>' <c:if test="${listProductDetail[0].infoCategory == infoCategoryList.code}">selected</c:if>>
			        	<c:out value="${infoCategoryList.codeName}" />
			        </option>	            	
		        </c:forEach>
          	</select>
			</span>		
		</td>
	</tr>
	<tr>
		<td width="12%" height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo1">크기(중량/구성)</td>
		<td width="38%" bgcolor="#FFFFFF">
			<span style="padding : 1 0 3 0">
	  		<input type="text" id="info1" name="info1" style="width:90%;" value='<c:out value="${listProductDetail[0].info1}"/>' />
			</span>		
		</td>
		<td width="10%" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo2">소재/재질</td>
		<td width="40%" bgcolor="#FFFFFF">
			<span style="padding : 1 0 3 0">
	  		<input type="text" id="info2" name="info2" style="width:90%;" value='<c:out value="${listProductDetail[0].info2}"/>' />
			</span>		
		</td>
	</tr>
	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo3">제조사/수입자(저자/출판자)</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text"  id="info3" name="info3" style="width:90%;" value='<c:out value="${listProductDetail[0].info3}"/>' />
    		</span>   		
    	</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo4">제조국</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text"  id="info4" name="info4" style="width:90%;" value='<c:out value="${listProductDetail[0].info4}"/>' />
    		</span>   		
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo5">사용연령(적용대상)</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text"  id="info5" name="info5" style="width:90%;" value='<c:out value="${listProductDetail[0].info5}"/>' />
    		</span>   		
    	</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo6">제조일(출간일)</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text"  id="info6" name="info6" style="width:90%;" value='<c:out value="${listProductDetail[0].info6}"/>' />
    		</span>   		
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo7">KC인증(각종 인증)</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text"  id="info7" name="info7" style="width:90%;" value='<c:out value="${listProductDetail[0].info7}"/>' />
    		</span>   		
    	</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo8">품질보증기준</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text"  id="info8" name="info8" style="width:90%;" value='<c:out value="${listProductDetail[0].info8}"/>' />
    		</span>   		
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo9">AS책임자(연락처)</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="info9" name="info9" style="width:90%;" value='<c:out value="${listProductDetail[0].info9}"/>' />
    		</span>   		
    	</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo10">기타사항</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text"  id="info10" name="info10" style="width:90%;" value='<c:out value="${listProductDetail[0].info10}"/>' />
    		</span>   		
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo11">AS책임자(연락처)</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="info11" name="info11" style="width:90%;" value='<c:out value="${listProductDetail[0].info11}"/>' />
    		</span>   		
    	</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo12">기타사항</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text"  id="info12" name="info12" style="width:90%;" value='<c:out value="${listProductDetail[0].info12}"/>' />
    		</span>   		
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo13">주의사항(상세사양)</td>
    	<td bgcolor="#FFFFFF" >
    		<span style="padding : 1 0 3 0">
      		<input type="text"  id="info13" name="info13" style="width:90%;" value='<c:out value="${listProductDetail[0].info13}"/>' />
    		</span>   		
    	</td>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">상세정보 노출 여부</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type='checkbox' id='detailDisplay' name='detailDisplay' maxlength='100' class='input2'  
      				<c:if test="${listProductDetail[0].detailDisplay}">checked</c:if>/>
      		 </span>
   		</td>
  	</tr>
</table>
<!--End 상세정보 추가 부분 끝 -->
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="40" align="center" class="tx14B" style="padding-left:10px">
			<a href="#" onclick="javascript:save(); return false;"><img src="/images/button/btn_confirm.gif"></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#" onclick="javascript:self.close(); return false;"><img src="/images/button/btn_cancel.gif"></a>
		</td>
	</tr>
</table>
<table width="1200" border="0" align="center" cellpadding="10" cellspacing="1" bgcolor="d9d9d9">
  <tr>
    <td colspan="4" align="center" bgcolor="#FFFFFF" class="tx12B">
    	
    	<img src="<c:out value="${detailImgPath}"/>/<c:out value="${listProductDetail[0].detailImageFile}"/>" />
   	</td>
  </tr>
</table>
</form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>



