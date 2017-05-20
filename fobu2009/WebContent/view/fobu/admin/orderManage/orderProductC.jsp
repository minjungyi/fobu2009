<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>::::::::: 주문상품변경 :::::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script language="javascript">
var frm = null;
function init(){
	frm = document.all.orderProductfrm;
	var c = "";	
	c =   "<tbody>"
		  + "<tr>"
		  + "<td width='30' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>선택</td>"
		  + "<td width='75' align='center' bgcolor='e7e7e7' class='tx12B'>이미지</td>"
		  + "<td width='45' align='center' bgcolor='e7e7e7' class='tx12B'>품번</td>"
		  + "<td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
		  + "<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>수량</td>"
		  + "<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>재고</td>"
		  + "<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>상태</td>"
		  +"</tr>";
		  //+"<tr><td colspan='7' height='527' bgcolor='#FFFFFF' align='center'></td></tr>";
	$("#product_list").html(c);
}
function search(pageNum){
	//초기화
	//$("[name=allCheck1]").removeAttr("checked");
	//$("[name=allCheck2]").removeAttr("checked");     

	
    
	var product = $('#product').val();
	var status = $('#status').val();
	$("#hdnPageNum").val(pageNum);
	$.ajax({
        type:"POST",
        cache: false,
        data:{
			"pageNum": pageNum,
			"product": product,
			"searchStatus" : status
			
        },
        dataType: "json",
        url:"/admin/orderManage/listChangeProduct.action",
        beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
        success:function(data, status) {
			var c = "";
			
			
			c =   "<tbody>"
				  + "<tr>"
				  + "<td width='30' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>선택</td>"
				  + "<td width='75' align='center' bgcolor='e7e7e7' class='tx12B'>이미지</td>"
				  + "<td width='45' align='center' bgcolor='e7e7e7' class='tx12B'>품번</td>"
				  + "<td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
				  + "<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>수량</td>"
				  + "<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>원가</td>"
				  + "<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>재고</td>"
				  + "<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>상태</td>"
				  +"</tr>";
				  
			if(data.changeProductList.length == 0){
				c += "<tr><td colspan='8' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>"
				$("#product_list").html(c);
			}else{
	            for(var z = 0 ; z < data.changeProductList.length ; z++){
				           	               
	            	
	                var linkTag = "";
	                if(data.changeProductList[z].companyLinkUrl != null && data.changeProductList[z].companyLinkUrl.length > 0){
	                    linkTag = "<a href='"+data.changeProductList[z].companyLinkUrl+data.changeProductList[z].corpProductCode+"' target='_blink'> <img src='/images/button/btn_link.gif' width='37' height='21' /></a>";
	                }
					
	                var statusTag="";
	                // 상태값 설정
					if(data.changeProductList[z].status == "001"){
						statusTag = "판매중";
					}else if(data.changeProductList[z].status == "002"){
						statusTag = "일시품절";
					}else{
						statusTag = "삭제";
					}
					selectVal = data.changeProductList[z].companyCategory;
	            	c  +="<tr>"
	            		+"  <td height='60' align='center' bgcolor='#FFFFFF'>"
	            		+"  	<input type='checkbox' name='chk' id='chk' onclick='chkYN("+z+");'>"
	            		+"		<input type='hidden' name='checkbox' id='checkbox' value='false'><input type='hidden' name='companyCategory' id='companyCategory' value='"+data.changeProductList[z].companyCategory+"'></td>"
	            	    +"	<td align='center' bgcolor='#FFFFFF'>";
	            	   
	            	    if(data.changeProductList[z].titleImageFile.length > 0 ){
	            	c  +="  	<img src='"+data.titleImgPath+"/"+data.changeProductList[z].titleImageFile+"' width='50' height='50' onclick='imageView(\"/view/fobu/excel/"+data.changeProductList[z].titleImageFile+"\");' style='cursor:hand;'/>";
	            	    }
	            	  	
	            	c  +="  </td>"
	            	    +"  <td align='center' bgcolor='#FFFFFF'>"
	            	    +"		<input type='hidden' id='productSeq' name='productSeq' value='"+data.changeProductList[z].seq+"'/>"+data.changeProductList[z].seq+"</td>"
	            	    +"  <td bgcolor='#FFFFFF'>"    
	            	    //+"		<a href='/admin/product/product_update.html?seq="+data.changeProductList[z].seq+"' target='_blank'>"
	            		+       data.changeProductList[z].product+"</a>"+ linkTag+"<br/>"
	            	   // +"      <img src='/images/button/cate_sel.gif' width='50' height='21' style='cursor:hand;' onclick='openWindow(\"product_categoryPop.html?seq="+this.seq+"&cate1="+this.category1+"&cate2="+this.category2+"&cate3="+this.category3+"\", \"categoryPop\", 800, 300, \"no\");'/><br/>"
	            	    +"		<font color='blue'>" 
	            	    +		data.changeProductList[z].categoryNm1+">"+data.changeProductList[z].categoryNm2+">"+data.changeProductList[z].categoryNm3
	            	    +"		</font>"            	   
	            	    +"  </td>"
	            	    +"  <td align='center' bgcolor='#FFFFFF'><input type='text' name='qy' id='qy' maxlength='5' class='price' size='2' value=''/></td>"
	            	    +"  <td align='center' bgcolor='#FFFFFF'>"+commify(data.changeProductList[z].familyPrice)+"<input type='hidden' id='familyPrice' name='familyPrice' value='"+data.changeProductList[z].familyPrice+"'/></td>"
	            	    +"  <td align='center' bgcolor='#FFFFFF'>"
	            	    +"		<span>"
	            	    +		data.changeProductList[z].realStock            	    
	            	    +"		</span>"
	            	    +"  </td>"            	    
	            	    +"  <td align='center' bgcolor='#FFFFFF'>"
	            	    +	statusTag
	            	    +"  </td></tr></tbody>";  
	            }
	            $("#product_list").html(c);
			}
             $("#page").html(data.pageSplit);
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	closeBlockUI();
        }
	});
}

function chkYN(index){
	if($("[name=chk]").eq(index).is(":checked")){
		$("[name=checkbox]").eq(index).val("true");
		$("[name=chk]").each(function(){
			if($("[name=chk]").index(this) != index){
				$(this).removeAttr("checked");
				$("[name=checkbox]").eq($("[name=chk]").index(this)).val("false");
			}
		});
	}else{
		$("[name=checkbox]").eq(index).val("false");
	}
}

function ajaxPageSplit(num) {
	frm.pageNumTmp.value = num;
	search(num);
}

function save(){
	var valid = 0;
	var valData = "";
	$("[name=checkbox]").each(function(){
		if($(this).val() == "true"){
			valData = $("[name=checkbox]").index(this);
			valid = 1;
		}			
	});
	if(valid == 0){
		alert('체크된 항목이 없습니다.');	
		return;
	}else if(valid > 1){
		alert('한 건만 선택하세요.');	
		return;
	}
	
	if($("[name=qy]").eq(valData).val() == null || $("[name=qy]").eq(valData).val() == ""){
		alert('수량을 입력하세요.');	
		return;
	}	
	
	//frm.target = "iframe_proc";
	frm.action = "/admin/orderManage/saveChangeProduct.action";
	frm.submit();
}
</script>
</head>
<body bgcolor="4b4b4b" onLoad="init();">
<form name="orderProductfrm" method="post" action="/admin/orderManage/saveChangeProduct.action" onsubmit="return false">
<input type="hidden" name="pageNumTmp" value="1">
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" valign="bottom" background="/images/title_orderpc.gif">&nbsp;</td>
  </tr>
</table>
<table width="760" border="7" align="center" cellpadding="15" cellspacing="0" bordercolor="4b4b4b">
  <tr>
    <td bgcolor="#FFFFFF">
    	<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
	      <tr>
	        <td height="25">
	        	<span style="padding-top:5px">
	          		<input name="product" id="product" type="text" size="40" onkeydown="javascript:if(event.keyCode==13){search(1);}">
	        	</span>
				<select name="status" id="status">
					<option value=''>전체</option>
					<option value='001'>판매중</option>
					<option value='002'>부분품절</option>
					<option value='003'>품절</option>
				</select>
	        	<a href="javascript:search(1);"><img src="/images/button/btn_search.gif"  align="absmiddle"></a></td>
	      </tr>
    	</table>
    	<table width="700">
			<tr>
	        	<td height="550" style="vertical-align: top">
	        		<table width="700" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="product_list">
	        		</table>
	        	</td>
	        </tr>
		</table>
		<div class="page_wrap">
			<div class="page" id="page" >
			</div>
		</div>
	    <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
	    <tr>
	      <td height="40" align="center" class="tx14B" style="padding-left:10px"><a href="javascript:save();"><img src="/images/button/btn_ok.gif"></a>&nbsp;&nbsp;&nbsp;&nbsp; 
	      <a href="javascript:self.close();"><img src="/images/button/btn_can.gif"></a> </td>
	    </tr>
        </table>
   </td>
  </tr>
</table>
<input type='hidden' name='pageNumPop' value='<c:out value="${pageNumPop}"/>'>
<input type='hidden' name='trIndex' value='<c:out value="${trIndex}"/>'>
<input type='hidden' name='seq' value='<c:out value="${seq}"/>'>
</form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
</body>
</html>


