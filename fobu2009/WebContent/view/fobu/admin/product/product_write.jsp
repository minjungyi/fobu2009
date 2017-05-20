<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>
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
	
	changeCateBind('1','0');
	companyBind();
});


// 카테고리 바인딩
function changeCateBind(num,seq){
	
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
	    		$('#companyCategory1').get(0).options[i] = new Option("["+this.seq+"] "+this.company+"("+this.cnt+")" ,tempVal);
	    		//$('#companyCategory1').get(0).options[i] = new Option(this.company,tempVal);
		    	i++;
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
	
	//alert(valArray[5]);
	if(valArray[5] =="true"){$("#isFreeDeliver").attr('checked',true);}
	else{$("#isFreeDeliver").attr('checked',false);};
	onFreeDeliverCheck();
	
	if(valArray[6]=="true"){$("#fixedPrice").attr('checked',true);}
	else{$("#fixedPrice").attr('checked',false);};
	
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
function afterInit(seq){
	location.href = "product_update.html?seq="+seq;
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

</script>
<form name="productfrm" method="post" action="product_write.action" target="iframe_proc" enctype="multipart/form-data">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 제품등록</td>
	</tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td height="38" align="center" background="/images/osb_t.gif"><table width="1160" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="25%" align="center"><strong>업체선택</strong></td>
            <td width="25%" align="center"><strong>1차카테고리</strong></td>
            <td width="25%" align="center"><strong>2차카테고리</strong></td>
            <td width="25%" align="center"><strong>3차카테고리</strong></td>
          </tr>
        </table></td>
	</tr>
  	<tr>
    	<td align="center" background="/images/osb_m.gif">
    	<table width="1160" border="0" cellspacing="0" cellpadding="3">
      		<tr>
	        	<td width="25%" align="center">
	        	  <select name='companyCategory1' id="companyCategory1" size='10' style='font-size:12px;width:260px;' onChange="selectCompany(this.value);">
		          </select>
			        <input type="hidden" id="companyCategory" name="companyCategory"/> 		        </td>
   		  <td width="25%" align="center">
		  <select name='category1' id='category1'  size='10' style='font-size:12px;width:260px;' onChange="changeCateBind('2',this.value);">
   			</select>       			</td>
   		  <td width="25%" align="center">
		  <select name='category2' id='category2' size='10' style='font-size:12px;width:260px;' onChange="changeCateBind('3',this.value);">
   			</select>       			</td>
   		  <td width="25%" align="center">
		  <select name='category3' id='category3' size='10' style='font-size:12px;width:260px;'  onClick="onCategoryDetail();">
   			</select>       			</td>
   		  </tr>
   		</table>
	  </td>
	</tr>
  	<tr>
    	<td  background="/images/osb_b.gif" height="20"></td>
  	</tr>
</table>
<!-- <table width="1150" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="60" align="center" valign="top"><a href="#"><img src="/images/button/prod_write.gif" align="absmiddle"/></a>&nbsp;&nbsp;<a href="#"><img src="/images/button/prod_copy.gif" align="absmiddle"/></a>&nbsp;&nbsp;<a href="#"><img src="/images/button/prod_del.gif" align="absmiddle"/></a></td>
  </tr> 
</table>-->
<table width="1200" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
	<tr>
		<td width="12%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">제품명/검색어</td>
		<td width="38%" bgcolor="#FFFFFF">
			<span style="padding : 1 0 3 0">
	  		<input type="text" id="product" name="product" style="width:90%;"/>
			</span>		</td>
		<td width="10%" align="center" bgcolor="e7e7e7" class="tx12B">추가내용</td>
		<td width="40%" bgcolor="#FFFFFF">
			<span style="padding : 1 0 3 0">
	  		<input type="text" id="remark" name="remark" style="width:90%;"/>
			</span>		</td>
	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">사이즈옵션</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<!-- <input type="text" id="sizeOpt" name="sizeOpt" style="width:90%;" onblur="sizeStock()"/>-->
      		<input type="text" id="sizeOpt" name="sizeOpt" style="width:90%;" />
    		</span>   		</td>
    	<td align="center" bgcolor="e7e7e7" class="tx12B">제품옵션</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="productOpt" name="productOpt" style="width:90%;"/>
    		</span>   		</td>
  	</tr>
  	<tr>
	    <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">색상옵션</td>
	    <td bgcolor="#FFFFFF">
	    	<span style="padding : 1 0 3 0">
	      	<input type="text" id="colorOpt" name="colorOpt" style="width:90%;"/>
	    	</span>    	</td>
	    <td align="center" bgcolor="e7e7e7" class="tx12B">사은품옵션</td>
	    <td bgcolor="#FFFFFF">
	    	<span style="padding : 1 0 3 0">
	   		<input type="text" id="eventOpt" name="eventOpt" style="width:90%;"/>
	    	</span>    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">업체제품코드/바코드</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="corpProductCode" name="corpProductCode" style="width:45%;"/>
      		/
      		<input type="text" id="barCode" name="barCode" style="width:45:%;"/>
    		</span>   		</td>
    	<td align="center" bgcolor="e7e7e7" class="tx12B">묶음/패키지코드</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type='text' name='packageCode' style='width:460' value='' />
    		</span>   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">제품가격</td>
   		<td colspan="3" bgcolor="#FFFFFF">
	   		<span style="padding : 1 0 3 0">
	   		소비자가
	     	<input type="text" class="price" id="retailPrice" name="retailPrice" style="width:80;"/> 
	     	판매가
	     	<input type="text" class="price" id="sellPrice" name="sellPrice" style="width:80;"/>
		 	매입가      
	 		<input type="text" class="price" id="originalPrice" name="originalPrice" style="width:80;"/>
	 		<input type="hidden" id="originalRate" name="originalRate" />	     		     	
	     	추가비용
	     	<input type="text" class="price" id="minusPrice" name='minusPrice' style='width:80' value='' />
	    	</span>   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">제품가격</td>
    	<td colspan="3" bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
    		원가
        	<input type="text" class="price" id="familyPrice" name="familyPrice" style="width:80;"/>
        	<input type="hidden" id="familyRate" name="familyRate" />
      		딜러가
      		<input type="text" class="price" id="dealerPrice" name="dealerPrice" style="width:80;"/>
      		<input type="hidden" id="dealerRate" name="dealerRate" />
      		쇼핑몰가
      		<input type="text" class="price" id="mallPrice" name="mallPrice" style="width:80;"/>
      		<input type="hidden" id="mallRate" name="mallRate" />
      		<input type='checkbox' name='fixedPrice' id='fixedPrice' maxlength='100' class='input2' />
    		고정가 판매설정   
    		<input type='checkbox' name='isFreeDeliver' id='isFreeDeliver' maxlength='100' class='input2' onclick="onFreeDeliverCheck();"/>
    		무료배송여부
			</span></td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">오픈마켓재고</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" class="number" id="stock" name="stock" style="width:90%;" value="999">
    		</span>   		</td>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">매장재고</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
    			<input type="text" class="number" id="realStock" name="realStock" style="width:90%;" value="0">
			<!-- <table id="tbRealStock">
	    		<tr>
		    		<td>합계</td>
		    		<td><input type="text" class="number" id="realStock" name="realStock" style="width:90%;" value="0"></td>
	    		</tr>	    		
    		</table>      --> 		
		  </span> 		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">배송비</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" class="price" id="deliverPrice" name="deliverPrice" style="width:90%;" value="2,500"/>
    		</span>   		</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B">추가배송비</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text" class="price" id="addDeliverPrice" name="addDeliverPrice" style="width:90%;" value="0"/>
    		</span>   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">원산지</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="originCountry" name="originCountry" style="width:90%;" value="중국(OEM)"/>
    		</span>   		</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B">브랜드</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
      			<select name="brandCategory" id="brandCategory">
      			<option value="-1">선택하세요</option>            	
            	<c:forEach var="brandList" items="${listBrand}">	            	
            		<option value='<c:out value="${brandList.code}"/>'>
			        	<c:out value="${brandList.codeName}" />
			        </option>	            	
		        </c:forEach>
          	</select>
   		  </span>   		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">노출금지</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type='checkbox' id='familyNoDisplay' name='familyNoDisplay' maxlength='100' class='input2' />
      		패밀리    		</span>
    		<span style="padding : 1 0 3 0">
    		<input type='checkbox' id='dealerNoDisplay' name='dealerNoDisplay' id='chk3' maxlength='100' class='input2'/>
    		딜러몰    		</span>
    		<span style="padding : 1 0 3 0">
    		<input type='checkbox' id='mallNoDisplay' name='mallNoDisplay' maxlength='100' class='input2' />
    		쇼핑몰    		</span>   		</td>
    	<td align="center" bgcolor="e7e7e7" class="tx12B">상태</td>
   	  <td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      			<input type='radio' name='status' class='input2' value="001" checked="checked" />
    		</span>판매
	    	<span style="padding : 1 0 3 0">
    			<input type='radio' name='status' class='input2' value="002"/>
			</span>부분품절   		
			<span style="padding : 1 0 3 0">
    			<input type='radio' name='status' class='input2' value="003"/>
   		  	</span>품절   		  	
  		</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">대표이미지</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type='file' name='titleImageFile1' style='width:80%;' onchange="fileUploadPreview(this,'imgTitle')"/>
    		<!--<img src="/images/button/btn_search1.gif" width="71" height="22" / align="absmiddle" /> -->
  			</span>		
  		</td>
  		<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">상세설명이미지</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type='file' name='detailImageFile1' style='width:80%;' onchange="fileUploadPreview(this,'imgDetail')"/>
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
            		<option value='<c:out value="${infoCategoryList.code}"/>' >
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
	  		<input type="text" id="info1" name="info1" style="width:90%;" />
			</span>		
		</td>
		<td width="10%" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo2">소재/재질</td>
		<td width="40%" bgcolor="#FFFFFF">
			<span style="padding : 1 0 3 0">
	  		<input type="text" id="info2" name="info2" style="width:90%;" />
			</span>		
		</td>
	</tr>
	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo3">제조사/수입자(저자/출판자)</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text"  id="info3" name="info3" style="width:90%;"  />
    		</span>   		
    	</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo4">제조국</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text"  id="info4" name="info4" style="width:90%;" />
    		</span>   		
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo5">사용연령(적용대상)</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text"  id="info5" name="info5" style="width:90%;" />
    		</span>   		
    	</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo6">제조일(출간일)</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text"  id="info6" name="info6" style="width:90%;" />
    		</span>   		
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo7">KC인증(각종 인증)</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text"  id="info7" name="info7" style="width:90%;"  />
    		</span>   		
    	</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo8">품질보증기준</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text"  id="info8" name="info8" style="width:90%;"  />
    		</span>   		
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo9">AS책임자(연락처)</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="info9" name="info9" style="width:90%;"  />
    		</span>   		
    	</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo10">기타사항</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text"  id="info10" name="info10" style="width:90%;" />
    		</span>   		
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo11">AS책임자(연락처)</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type="text" id="info11" name="info11" style="width:90%;" />
    		</span>   		
    	</td>
   		<td align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo12">기타사항</td>
   		<td bgcolor="#FFFFFF">
   			<span style="padding : 1 0 3 0">
  			<input type="text"  id="info12" name="info12" style="width:90%;" />
    		</span>   		
    	</td>
  	</tr>
  	<tr>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B" id="tdInfo13">주의사항(상세사양)</td>
    	<td bgcolor="#FFFFFF" >
    		<span style="padding : 1 0 3 0">
      		<input type="text"  id="info13" name="info13" style="width:90%;" />
    		</span>   		
    	</td>
    	<td height="28" align="center" bgcolor="e7e7e7" class="tx12B">상세정보 노출 여부</td>
    	<td bgcolor="#FFFFFF">
    		<span style="padding : 1 0 3 0">
      		<input type='checkbox' id='detailDisplay' name='detailDisplay' maxlength='100' class='input2'  />
      		 </span>
   		</td>
  	</tr>
</table>
<!--End 상세정보 추가 부분 끝 -->
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="40" align="center" class="tx14B" style="padding-left:10px">
			<a href="#" onclick="javascript:save2(); return false;"><img src="/images/button/btn_ok.gif"></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#"><img src="/images/button/btn_can.gif"></a>
		</td>
	</tr>
</table>
<table width="1200" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
  <tr>
    <td colspan="4" align="left" bgcolor="#FFFFFF" class="tx12B">
	    <div id="imgTitle" id="imgTitle" style="width:100px; height: 100px; float:left;"></div>
	    <div id="imgDetail" id="imgDetail" style="width:100px; height: 100px; float:left;"></div>
   	</td>
  </tr>
</table>
</form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->


