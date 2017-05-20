<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>
<!-- top end-->

<script language="javascript">
$(function() {
	
	companyBind();
});
function afterInit(){
	companyBind();
}
function save(){
	var frm = document.productfrm;

	frm.submit();
}

function companyBind(){	
	
	$('#companyCate').empty();
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"seq": "",
			"stat": $("#searchStat").val(),
			"searchCompany": $("#searchCompany").val()	
	    },
	    dataType: "json",
	    url:"/admin/product/product_company2.action",
	    beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
	    success:function(data, status) {
		    var i = 0;
	    	$.each(data.listCompany, function() {
	    		$('#companyCate').get(0).options[i] = new Option("["+this.seq+"] "+this.company+"("+this.cnt+")" ,this.seq);
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
function selectCompany(seq){
	init();
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"seq": seq,
			"stat": $("#searchStat").val()
	    },
	    dataType: "json",
	    url:"/admin/product/product_company2.action",
	    beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
	    success:function(data, status) {
		    if(data.listCompany != null)
		    {   
		    	$("#company").val(data.listCompany[0].company);
		    	$("#seq").val(data.listCompany[0].seq);
		    	$("#originalRate").val(data.listCompany[0].originalRate);
		    	$("#familyRate").val(data.listCompany[0].familyRate);
		    	$("#mallRate").val(data.listCompany[0].mallRate);
		    	$("#dealerRate").val(data.listCompany[0].dealerRate);
		    	$("#stat").val(data.listCompany[0].stat);
		    	$("#billYN").val(data.listCompany[0].billYN);
		    	$("#companyLinkUrl").val(data.listCompany[0].companyLinkUrl);
		    	$("#companyImageUrl").val(data.listCompany[0].companyImageUrl);
		    	$("#sellById").val(data.listCompany[0].sellById);
		    	if(data.listCompany[0].isFreeDeliver == true){$("#isFreeDeliver").attr('checked' ,true);}
		    	else{$("#isFreeDeliver").attr('checked' ,false);};
		    	if(data.listCompany[0].isFixedPrice == true){$("#isFixedPrice").attr('checked' ,true);}
		    	else{$("#isFixedPrice").attr('checked' ,false);};
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
	//$(":text").val("");
	
	$("#seq").val("");
	$("#company").val("");
	$("#originalRate").val("");
	$("#dealerRate").val("");
	$("#familyRate").val("");
	$("#mallRate").val("");
	$("#billYN").val("");
	$("#companyLinkUrl").val("");
	$("#companyImageUrl").val("");
	$("#sellById").val("");
}


</script>

<form name="productfrm" method="post" action="/admin/product/product_company_save.action" target="iframe_proc">

<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B">▣ 업체 관리</td>
  </tr>
</table>
<div class="div_space"></div>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    	<td height="38" align="center" background="/images/osb_t.gif">&nbsp;
    		
    		
   		</td>
	</tr>
  	<tr>
    	<td align="center" background="/images/osb_m.gif">
    	<table width="1160" border="0" cellspacing="0" cellpadding="3">
     		
      		<tr>
	        	<td width="25%">
		        	<select name='companyCate' id="companyCate" size='18' style='font-size:12px;width:260px;' onChange="selectCompany(this.value);">
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
						  <td width="20%" height="28" align="center" bgcolor="e7e7e7" class="tx12B"><strong>검색설정</strong></td>
						  <td width="30%" bgcolor="#FFFFFF" style="padding : 1 0 3 0;text-align: left;">
								&nbsp;
						  <select id="searchStat" name="searchStat" onChange="companyBind();">
                            <option value="">거래처전체</option>
                            <option value="Y">거래업체</option>
                            <option value="N">거래중지업체</option>
                          </select></td>
						  <td width="20%" align="center" bgcolor="e7e7e7" class="tx12B"><strong>업체검색</strong></td>
						  <td width="30%" bgcolor="#FFFFFF" style="padding : 1 0 3 2">
						  	<input type="text" id="searchCompany" name="searchCompany" style="width:74%;"/>
					      	<input type="button" value="검색" onclick="companyBind();" style="cursor:hand;">
				      	  </td>
					   </tr>
					   </table>
					   <br/>
					   <table width="816" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
						<tr>
							<td width="20%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">업체코드</td>
							<td width="30%" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<input type="text" id="seq" name="seq" style="width:90%;" readonly/>
							</td>
							<td width="20%" align="center" bgcolor="e7e7e7" class="tx12B">업체명</td>
							<td width="30%" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<input type="text" id="company" name="company" style="width:90%;"/>
							</td>
						</tr>
						<tr>
							<td  height="28" align="center" bgcolor="e7e7e7" class="tx12B">원가율(%)</td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<input type="text" id="originalRate" name="originalRate" style="width:90%;"/>
							</td>
							<td  align="center" bgcolor="e7e7e7" class="tx12B">딜러가 판매율(%)</td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<input type="text" id="dealerRate" name="dealerRate" style="width:90%;"/>
							</td>
						</tr>
						<tr>
							<td  height="28" align="center" bgcolor="e7e7e7" class="tx12B">패밀리가율(%)</td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<input type="text" id="familyRate" name="familyRate" style="width:90%;"/>
							</td>
							<td  align="center" bgcolor="e7e7e7" class="tx12B">쇼핑몰가 판매율(%)</td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0">
						  		<input type="text" id="mallRate" name="mallRate" style="width:90%;"/>
							</td>
						</tr>
						<tr>
							<td  height="28" align="center" bgcolor="e7e7e7" class="tx12B">거래구분</td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0;text-align: left;">
								&nbsp;
						  		<select name='stat' id='stat'>
									<option value="Y">거래업체</option>
									<option value="N">거래중지업체</option>
        						</select>
							</td>
							<td  align="center" bgcolor="e7e7e7" class="tx12B">계산서율(%)</td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0;text-align: left;">
								&nbsp;
								<input type="text" id="billYN" name="billYN" style="width:90%;"/>
							</td>
						</tr>
						<tr>
							<td  height="28" align="center" bgcolor="e7e7e7" class="tx12B">고정가여부</td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0;text-align: left;">
								&nbsp;
						  		<input type='checkbox' name='isFixedPrice' id='isFixedPrice' class='input2'/>
							</td>
							<td  align="center" bgcolor="e7e7e7" class="tx12B">무료배송비여부</td>
							<td  bgcolor="#FFFFFF" style="padding : 1 0 3 0;text-align: left;">
								&nbsp;
								<input type='checkbox' name='isFreeDeliver' id='isFreeDeliver' class='input2'/>
							</td>
						</tr>
						<tr>
							<td  height="28" align="center" bgcolor="e7e7e7" class="tx12B">제품사이트링크</td>
							<td  colspan="3" bgcolor="#FFFFFF" style="padding : 1 0 3 0;text-align: left;">
								&nbsp;
								<input type="text" id="companyLinkUrl" name="companyLinkUrl" style="width:90%;"/>
							</td>
						</tr>
						<tr>
							<td  height="28" align="center" bgcolor="e7e7e7" class="tx12B">제품이미지경로</td>
							<td  colspan="3" bgcolor="#FFFFFF" style="padding : 1 0 3 0;text-align: left;">
								&nbsp;
								<input type="text" id="companyImageUrl" name="companyImageUrl" style="width:90%;"/>
							</td>
						</tr>
						<tr>
							<td  height="28" align="center" bgcolor="e7e7e7" class="tx12B">판매아이디</td>
							<td  colspan="3" bgcolor="#FFFFFF" style="padding : 1 0 3 0;text-align: left;">
								&nbsp;
								<input type="text" id="sellById" name="sellById" style="width:90%;"/>
							</td>
						</tr>
						
					</table>
					<br/>
					<table width="500" border="0" cellpadding="0" cellspacing="0">
	                	<tr>
		                    <td height="30" align="center">
		                    	<input type="button" value="초기화" onclick="init();" style="cursor:hand;">
		                        <input type="button" value="저장" onclick="save();" style="cursor:hand;">
		                    </td>
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
