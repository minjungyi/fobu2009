<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>
<!-- top end-->

<script language="javascript">
$(function() {
	
	productBrandBind();
});

function afterInit(){
	productBrandBind();
}

function save(){
	var frm = document.productBrandFrm;

	frm.submit();
}

function search(){
	//var searchText = $("#txtSearch").val();
	//$("#productBrandCate option").each(function(){
	//	if($(this).text().indexOf(searchText) > -1){
	//		$("#productBrandCate").val($(this).val());
	//		selectCompany($(this).val());
	//		return false;
	//	}
			
	//});
	productBrandBind();
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
function selectCompany(code){
		
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


</script>

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
	        	<td width="237">
		        	<select name='productBrandCate' id="productBrandCate" size='20' style='font-size:12px;width:260px;' onChange="selectCompany(this.value);">
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
			            </table>
			            <br/>
					   <table width="816" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
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
									<option value=""/></option>
									<option value="Y"/>노출</option>
									<option value="X"/>노출안함</option>
								</select>
							</td>
						</tr>
						
					</table>
					<br/>
					 <table width="500" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="30" align="center"><input type="button" value="초기화" onClick="init();" style="cursor:hand;">
                      <input type="button" value="저장" onClick="save();" style="cursor:hand;">
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
