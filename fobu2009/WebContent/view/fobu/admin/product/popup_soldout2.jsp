<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>::::::::: 마켓별 품정연동 :::::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
function onDummySoldFileUpload(){
	showMsg("업로드중입니다...");
	var frm = document.frm;
	frm.action = "/dummySoldoutFileUpload.action";
	frm.submit();
}

function onSoldOutDataSearch(){
	
	var table = $("#table").val();
	var marketType = $("#marketType").val();
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"table": table,
			"marketType": marketType
	    },
	    dataType: "json",
	    url:"/admin/product/listDummySoldout.action",
	    beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
	    success:function(data, status) {	
	    	var strVal1 ="";
	    	$.each(data.listDummySold1, function() {
	    		strVal1 += this.marketSeq+",";
	    	});
	    	$("#textarea1").val(strVal1);
	    	
	    	var strVal2 ="";
	    	$.each(data.listDummySold2, function() {
	    		strVal2 += this.marketSeq+",";
	    	});
	    	$("#textarea2").val(strVal2);
	    	
		},
	    error:function(request, status) {
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {
	    	closeBlockUI();
	     }
	});	
}


function onSoldOutDataSearch2(){
	var table = $("#table").val();
	var marketType = $("#marketType").val();
	var term = $("#term").val();
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"table": table,
			"marketType": marketType,
			"term":term
	    },
	    dataType: "json",
	    url:"/admin/product/listDummySoldout2.action",
	    beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
	    success:function(data, status) {	
	    	var strVal1 ="";
	    	$.each(data.listDummySold, function() {
	    		strVal1 += this.marketSeq+",";
	    	});
	    	$("#textarea3").val(strVal1);   	
	    	    	
		},
	    error:function(request, status) {
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {
	    	closeBlockUI();
	     }
	});	
}

function onDummySoldoutUpdate2(){
	var table = $("#table").val();
	var marketType = $("#marketType").val();
	var term = $("#term").val();
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"table": table,
			"marketType": marketType,
			"term":term
	    },
	    dataType: "json",
	    url:"/admin/product/updateDummySoldout2.action",
	    success:function(data, status) {	
	    	alert("삭제되었습니다.");
	    	//onSoldOutDataSearch();
		},
	    error:function(request, status) {
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {
	    	
	     }
	});	
}


function onDummySoldoutUpdate1(){
	var table = $("#table").val();
	var marketType = $("#marketType").val();
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"table": table,
			"marketType": marketType
	    },
	    dataType: "json",
	    url:"/admin/product/updateDummySoldout.action",
	    success:function(data, status) {	
	    	alert("삭제되었습니다.");
	    	//onSoldOutDataSearch();
		},
	    error:function(request, status) {
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {
	    	
	     }
	});	
}


function afterInit(obj){
	closeBlockUI();
}
</script>

</head>
<body bgcolor="4b4b4b">
<form name="frm" method="post" enctype="multipart/form-data" target="iframe_proc">
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" valign="bottom" background="/images/title_soldout.gif">&nbsp;</td>
  </tr>
</table>
<table width="760" border="7" align="center" cellpadding="15" cellspacing="0" bordercolor="4b4b4b">
  <tr>
    <td align="center" bgcolor="#FFFFFF"><br>
      <table width="730" border="0" align="center" cellpadding="0" cellspacing="0">
        <!--인터파크 제품번호,제품번호로 콤마구분/ 11번가,옥션,지마켓 엔터로 구분 -->
        <tr>
          <td height="25" align="center">
          	<select name="table" id="table" >
	            <option value="fobu" selected>포부</option>
	            <option value="choco" >초코</option>
	            <option value="good" >굿파더</option>
	            <option value="min" >민트윈</option>
	            <option value="tmin" >트윈몰</option>
          	</select>
            <select name="marketType" id="marketType" >
              <option value="aut">옥션</option>
              <option value="gmk">지마켓</option>
              <option value="cyw">11번가</option>
              <option value="itp">인터파크</option>
              <option value="shn">샵엔</option>
            </select>
          <input type="button" value="조회" onClick="onSoldOutDataSearch();"/></td>
        </tr>
        <tr>
          <td height="25">
          	<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
              <tr>
                <td height="25" colspan="2" align="center" bgcolor="#FFFFFF">
                	<span class="tx12B">
                  	오픈마켓 판매 파일 
	                <input type="file" name="file" />
	                <img src="/images/button/open_oder.gif" style='cursor: hand;' onclick="onDummySoldFileUpload();" align="absmiddle" />
	                </span>
                </td>
                <td width="10%" align="center" bgcolor="#FFFFFF">                	
                	<select name="term" id="term" >                  		
               			<option value="-12">12개월</option>
               			<option value="-9">9개월</option>
               			<option value="-6">6개월</option>
               			<option value="-3">3개월</option>
                	</select>
                	<input type="button" value="조회" onClick="onSoldOutDataSearch2();"/>
                </td>
              </tr>
              <tr>
                <td height="21" align="center" bgcolor="#CCCCCC"><strong>관리자삭제목록</strong></td>
                <td align="center" bgcolor="#CCCCCC"><strong>오픈마켓삭제목록</strong></td>
                <td align="center" bgcolor="#CCCCCC"><strong>히트수 및 미판매상품 목록</strong></td>
              </tr>
              <tr>
                <td width="10%" height="21" align="center" bgcolor="#FFFFFF">
                  	<textarea name="textarea1" id="textarea1" cols="15" rows="10"></textarea>
                </td>
                <td width="10%" align="center" bgcolor="#FFFFFF">
                	<textarea name="textarea2" id="textarea2" cols="15" rows="10"></textarea>
                </td>
                <td align="center" bgcolor="#FFFFFF">
                	<textarea name="textarea3" id="textarea3" cols="15" rows="10"></textarea>
                </td>
              </tr>
              <tr>
                <td height="21" align="center" bgcolor="#FFFFFF">
                	<a href="javascript:;" onclick="onDummySoldoutUpdate1();"><img src="/images/button/s_button_03.gif" width="30" height="18" border="0"></a>
                </td>
                <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
                <td align="center" bgcolor="#FFFFFF">
                	<a href="javascript:;" onclick="onDummySoldoutUpdate2();"><img src="/images/button/s_button_03.gif" width="30" height="18" border="0"></a>
                </td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="25">&nbsp;</td>
        </tr>
      </table>
    <br></td></tr>
</table>
</form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
</body>
</html>


