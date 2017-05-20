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
<title>카테고리 상세</title>

<script language="javascript">
$(function() {
	$("#seq").val("${seq}");
	
	if(${rtnVal} < 0){
		opener.showMsgNClose("수정중 오류가 발생했습니다.");
	}
	else if(${rtnVal} > 0){
		//window.close();
		opener.showMsgNClose("카테고리가 수정되었습니다.");
		opener.afterInit();
		window.close();
	}else{
		if($("#seq").val()== "-1" || $("#seq").val()== "-99"){
			changeCateBind('1','0','false');
		}else{
			changeCateBind('1','0','true');
		}
	}
});
//카테고리 바인딩
function changeCateBind(num,seq,flag){
	
	$('#category'+num).empty();
	if(num =="2"){
		$('#category3').empty();
	}

	if((num =="2" || num =="3") && seq =="0"){
		return;
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
		    		categoryVal = "${cate1}";
		    		$('#category'+num).val(categoryVal);
		    		changeCateBind('2',categoryVal,"true");
		    	}
	    		else if(num == "2")
	    		{
		    		categoryVal = "${cate2}";
		    		$('#category'+num).val(categoryVal);
		    		changeCateBind('3',categoryVal,"true");
	    		}
	    		else if(num == "3")
	    		{
	    			categoryVal = "${cate3}";
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
function save(){

	if($("#seq").val() == "-1"){
		var cateNm1 = $('#category1 option:selected').text();
		var cateNm2 = $('#category2 option:selected').text();
		var cateNm3 = $('#category3 option:selected').text();

		var cate1 = $('#category1').val();
		var cate2 = $('#category2').val();
		var cate3 = $('#category3').val();
		
		opener.setCategoryVal(cate1,cate2,cate3,cateNm1,cateNm2,cateNm3);
		window.close();
	}else if($("#seq").val() == "-99"){
		
		var cateNm1 = $('#category1 option:selected').text();
		var cateNm2 = $('#category2 option:selected').text();
		var cateNm3 = $('#category3 option:selected').text();

		var cate1 = $('#category1').val();
		var cate2 = $('#category2').val();
		var cate3 = $('#category3').val();
		
		opener.setCategoryVal2(cate1,cate2,cate3,cateNm1,cateNm2,cateNm3);
		window.close();
		
	}else{
		var frm = document.categoryPopFrm;

		frm.submit();
	}
}
</script>
</head>
<body>
<form name="categoryPopFrm" method="post" action="/admin/product/product_CategoryPop_save.action" >
<input type="hidden" id="seq" name="seq"/>
<table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 카테고리 팝업</td>
	</tr>
</table>
<table width="770" border="1" cellspacing="0" cellpadding="3">
	<tr height="35px">
     	<td style="text-align: center;"><strong>1차카테고리</strong></td>
     	<td style="text-align: center;"><strong>2차카테고리</strong></td>
     	<td style="text-align: center;"><strong>3차카테고리</strong></td>
	</tr>
 	<tr>
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
	 	<td></td>
	 	<td style="text-align:center;">
	 		<input type="button" value="수정" onclick="save();">
	 		<input type="button" value="닫기" onclick="window.close();">
	 	</td>
	 	<td></td>
 	</tr>
</table>
<div class="div_space"></div>
</form>
</body>
</html>
