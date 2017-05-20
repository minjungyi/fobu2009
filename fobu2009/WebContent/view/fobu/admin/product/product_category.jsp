<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<title>주문수집</title>

<script language="javascript">
$(function() {
	changeCateBind('1','0');	
	productBrandBind();
});

function afterInit(){
	productBrandBind();
}

function brandSave(){
	if($("#codeName").val() == "" || $("#codeName").val() == null){
		showMsgNClose('브랜드명은 필수 입력 사항입니다.');		
		$("#codeName").focus();
		return;
	}
	
	var frm = document.productBrandFrm;

	frm.submit();
}

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
	    		var productCnt = 0;
	    		if(num == '1'){
	    			productCnt = this.productCnt1;
	    		}else if(num == '2'){
	    			productCnt = this.productCnt2;
	    		}else{
	    			productCnt = this.productCnt3;
	    		}
	    		$('#category'+num).get(0).options[i] = new Option(this.codeName+" ["+productCnt+"]",this.code);
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

function selectCompany(comCode){
	$("#corpProductCode").val(comCode);
}
function productBrandBind(){
	
	$('#productBrandCate').empty();
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"category": "0001",
			"searchText": $("#searchText").val(),
			"useYN": $("#useYN2").val()
	    },
	    dataType: "json",
	    url:"/admin/product/product_brand.action",
	    beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
	    success:function(data, status) {
		    var i = 0;
	    	$.each(data.listBrand, function() {
	    		$('#productBrandCate').get(0).options[i] = new Option(this.codeName+"("+this.count+")",this.code);
		    	i++;
	    	});
		},
	    error:function(request, status) {
			closeBlockUI();
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {
	    	closeBlockUI();
	     }
	});		
}
function selectBrand(code){
		
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"category": "0001",
			"code": code
	    },
	    dataType: "json",
	    url:"/admin/product/product_brand_detail.action",
	    beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
	    success:function(data, status) {
		    if(data.listBrandDetail != null)
		    {
		    	$("#code").val(data.listBrandDetail[0].code);
		    	$("#codeName").val(data.listBrandDetail[0].codeName);
		    	$("#attrExt1").val(data.listBrandDetail[0].attrExt1);
		    	$("#attrExt2").val(data.listBrandDetail[0].attrExt2);
		    	$("#useYN").val(data.listBrandDetail[0].useYN);
		    }
		},
	    error:function(request, status) {
			closeBlockUI();
	        alert(status);
	    },
	    complete:function(xhr, textStatus) {
	    	closeBlockUI();
	    }
	});	
}
function init(){
	$(":text").val("");
	$("#attrExt2").val("");
}

function save(seq, status){
	var category = 0;	
	var code = "";
	var cate1 = $('#category1').val();
	var cate2 = $('#category2').val();
	var cate3 = $('#category3').val();
	var sort = 1;
		
	if(status == "U"){
		if(seq == "1" && cate1 == null){
			alert("1차 카테고리를 선택해주세요");
			return;
		}else if(seq =="2" && cate2 == null){
			alert("2차 카테고리를 선택해주세요");
			return;
		}else if(seq =="3" && cate3 == null){
			alert("3차 카테고리를 선택해주세요");
			return;
		}
		
		if(seq == "1"){
			category = "0";
			code = cate1;
		}else if(seq == "2"){
			category = cate1;
			code = cate2;
		}else{
			category = cate2;
			code = cate3;
		}
	}else{
		if(seq == "1"){
			category = "0";
			
		}else if(seq == "2"){
			category = cate1;
			
		}else{
			category = cate2;
		}
	}
	//alert(text);
	window.open('/admin/product/product_categoryP.html?category=' + category+'&code='+ code+'&status='+ status+'&depth='+ seq, 'productCategoryP', 'width=470, height=300, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}

function onSortChange(seq){
	var category = 0;	
	var code = "";
	
	if(seq == "1"){
		category = "0";
		code = $('#category1').val();
	}else if(seq == "2"){
		category = $('#category1').val();
		code = $('#category2').val();
	}else{
		category = $('#category2').val();
		code = $('#category3').val();
	}
	
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"category": category,
			"code": code
	    },
	    dataType: "json",
	    url:"/admin/product/product_category_sort_change.action",
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
	
	alert(document.categoryFrm.category2.value);
	//window.open('/admin/orderManage/orderDetailP.html?seq=' + seq, 'orderDetailP', 'width=780, height=920, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}

function del(seq){
	//window.open('/admin/orderManage/orderDetailP.html?seq=' + seq, 'orderDetailP', 'width=780, height=920, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}

function cateInit(){
	var strCategory3 = $("#category3").val();
	if(strCategory3 == null || strCategory3 ==""){
		alert("3차 카테고리를 선택해주세요.");
		return;
	}
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"category3": strCategory3
	    },
	    dataType: "json",
	    url:"/admin/product/product_category_init.action",
	    success:function(data, status) {
	    
		   if(data.rtnVal == "1"){
			   alert("카테고리가 초기화 되었습니다.");
			   changeCateBind('1','0');	
			   $('#category2').empty();
			   $('#category3').empty();
		   }else{
			   alert("카테고리 초기화가 실패했습니다.");
		   }
		},
	    error:function(request, status) {
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {
	    	
	     }
	});	
}

function openPop(){
	
	var selBrandCode = $("#productBrandCate").val();
	var paramData = "selectBrand="+selBrandCode;
	
	var newWin = window.open('about:blank');
	
	newWin.location.href = "/admin/product/product_list.html?"+paramData;
}
function pop(seq){
	var cate1 = "";
	var cate2 = "";
	var cate3 = "";
	
	if(seq == "1"){
		cate1 = $('#category1 option:selected').val();
	}else if(seq == "1"){
		cate1 = $('#category1 option:selected').val();
		cate2 = $('#category2 option:selected').val();
	}else{
		cate1 = $('#category1 option:selected').val();
		cate2 = $('#category2 option:selected').val();
		cate3 = $('#category3 option:selected').val();
	}
	var paramData = "cate1="+cate1+
					"&cate2="+cate2+
					"&cate3="+cate3;
	
	var newWin = window.open('about:blank');
	
	newWin.location.href = "/admin/product/product_list.html?"+paramData;
}
</script>
</head>
<body>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>
<form name="categoryFrm" method="post" action="/admin/product/product_write.action" >
<!-- top end-->
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B">▣ 카테고리 관리</td>
  </tr>
</table>
<div class="div_space"></div>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td height="38" align="right" background="/images/osb_t.gif" style="padding-right:20px">
    		<!-- 1차카테고리 4개 / 2차카테고리 20개 / 3차카테고리 50개 / <strong>총제품수 5,000개</strong> -->
   		</td>
	</tr>
  	<tr>
    	<td align="center" background="/images/osb_m.gif">
    	<table width="1160" border="0" cellspacing="0" cellpadding="3">
     		<tr>
		        <!-- td width="25%"><strong>업체선택</strong></td-->
		        <td width="33%"><strong>1차카테고리</strong></td>
		        <td width="33%"><strong>2차카테고리</strong></td>
		        <td width="33%"><strong>3차카테고리</strong></td>
      		</tr>
      		<tr>
	        	<!-- td>
		        	<select name='company' id="company" size='10' style='font-size:12px;width:260px;' onChange="selectCompany(this.value);">
		          		
			        </select>
		        </td-->
        		<td>
        			<select name='category1' id='category1'  size='10' style='font-size:12px;width:260px;' onChange="changeCateBind('2',this.value);">
						
        			</select>
       			</td>
        		<td>
        			<select name='category2' id='category2' size='10' style='font-size:12px;width:260px;' onChange="changeCateBind('3',this.value);">
          				
        			</select>
       			</td>
        		<td>
        			<select name='category3' id='category3' size='10' style='font-size:12px;width:260px;' >
          				
        			</select>
       			</td>
      		</tr>
      		<tr>
        		<td>
        			<input type="button" value="추가" onclick="save(1, 'I');">
		        	<input type="button" value="수정" onclick="save(1, 'U');">
		        	<input type="button" value="삭제" onclick="save(1, 'U');">
		        	<input type="button" value="팝업" onclick="pop(1);">
		        	<!--  <input type="button" value="Sort ▲" onclick="onSortChange(1, 'U');">
		        	<input type="button" value="Sort ▼" onclick="onSortChange(1, 'D');">-->
       			</td>
        		<td>
        			<input type="button" value="추가" onclick="save(2, 'I');">
		        	<input type="button" value="수정" onclick="save(2, 'U');">
		        	<input type="button" value="삭제" onclick="save(2, 'U');">
		        	<input type="button" value="팝업" onclick="pop(2);">
		        	<!--<input type="button" value="Sort ▲" onclick="onSortChange(2, 'U');">
		        	<input type="button" value="Sort ▼" onclick="onSortChange(2, 'D');">-->
       			</td>
        		<td>
        			<input type="button" value="추가" onclick="save(3, 'I');">
		        	<input type="button" value="수정" onclick="save(3, 'U');">
		        	<input type="button" value="삭제" onclick="save(3, 'U');">
		        	<input type="button" value="팝업" onclick="pop(3);">
		        	<input type="button" value="카테고리초기화" onclick="cateInit();">
		        	<!--<input type="button" value="Sort ▲" onclick="onSortChange(3, 'U');">
		        	<input type="button" value="Sort ▼" onclick="onSortChange(3, 'D');">-->
       			</td>
      		</tr>
   		</table>
   		</td>
	</tr>
  	<tr>
    	<td><img src="/images/osb_b.gif" width="1200" height="27"></td>
  	</tr>
</table>
</form>
<div class="div_space"></div>
<form name="productBrandFrm" method="post" action="/admin/product/product_brand_save.action" target="iframe_proc">
<input type="hidden" id="category" name="category" value="0001" />
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B">▣ 브랜드 관리</td>
  </tr>
</table>
<div class="div_space"></div>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td height="38" align="center" background="/images/osb_t.gif">
    		&nbsp;
   		</td>
	</tr>
  	<tr>
    	<td align="center" background="/images/osb_m.gif">
    	<table width="1160" border="0" cellspacing="0" cellpadding="3">     	
	    	<tr>
		        <td width="25%"><strong>브랜드선택</strong></td>
		        <td></td>
		    </tr>	
      		<tr>
	        	<td width="237">
		        	<select name='productBrandCate' id="productBrandCate" size='12' style='font-size:12px;width:260px;' onChange="selectBrand(this.value);">
		          		<!--<c:forEach var="odrId" items="${requestScope.odrList}">
					        <option value='<c:out value="${pageScope.odrId.cmbHrsmnCd}"/>'>
					        <c:out value="${pageScope.odrId.cmbHrsmnNm}" />
					        </option>
					       </c:forEach>-->
			        </select>
		        </td>
        		<td width="816" align="center" style="vertical-align:top;">
        			<table width="816" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
        				<tr>
				            <td width="20%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">검색설정</td>
				            <td width="30%" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
					            <select style="width:90%; height:20px" name="useYN2" id="useYN2" onChange="productBrandBind();">
					              <option value=""/>전체검색</option>
					              <option value="Y"/>사용</option>
					              <option value="N"/>사용안함</option>
					            </select>
				            </td>
				            <td width="20%" align="center" bgcolor="e7e7e7" class="tx12B">브랜드검색</td>
				            <td width="30%" bgcolor="#FFFFFF" style="padding : 1 0 3 0"><input type="text" id="searchText" name="searchText" style="width:73%;"/>
			                    <input type="button" value="검색" style="cursor:hand;" onClick="productBrandBind();"/></td>
			            </tr>
			            
						<tr>
							<td width="20%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">브랜드코드</td>
							<td width="30%" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<input type="text" id="code" name="code" style="width:90%;" readonly/>
							</td>
							<td width="20%" align="center" bgcolor="e7e7e7" class="tx12B">브랜드명</td>
							<td width="30%" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<input type="text" id="codeName" name="codeName" style="width:90%;"/>
							</td>
						</tr>
						<tr>
							<td  height="28" align="center" bgcolor="e7e7e7" class="tx12B">할인율(%)</td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<input type="text" id="attrExt1" name="attrExt1" style="width:90%;"/>
							</td>
							<td  align="center" bgcolor="e7e7e7" class="tx12B"></td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<!-- input type="text" id="dealerRate" name="dealerRate" style="width:90%;"/-->
							</td>
						</tr>
						<tr>
							<td  height="28" align="center" bgcolor="e7e7e7" class="tx12B">사용여부</td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<select style="width:90%; height:20px" name="useYN" id="useYN">
									<option value="Y"/>사용</option>
									<option value="N"/>사용안함</option>
								</select>
							</td>
							<td  align="center" bgcolor="e7e7e7" class="tx12B">브랜드노출여부</td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<select style="width:90%; height:20px" name="attrExt2" id="attrExt2">
									<option value="Y"/>노출</option>
									<option value="N"/>노출안함</option>
								</select>
							</td>
						</tr>
						
					</table>
					<br/>
					 <table width="500" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="30" align="center"><input type="button" value="초기화" onClick="init();" style="cursor:hand;">
                      <input type="button" value="저장" onClick="brandSave();" style="cursor:hand;">
                      <input type="button" value="팝업" onClick="openPop();" style="cursor:hand;">
                    &nbsp;&nbsp; </td>
                </tr>
            </table>
       			</td>
      		</tr>
   		</table>
   		</td>
	</tr>
  	<tr>
    	<td><img src="/images/osb_b.gif" width="1200" height="27"></td>
  	</tr>
</table>
</form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
<!-- footer start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- footer end-->


</body>
</html>
