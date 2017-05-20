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
<script language="javascript">
function onSoldOutDataSearch(){
	
	soldOutFrm.action = '/admin/product/popup_soldout.html';
	soldOutFrm.target = '_self';
	soldOutFrm.submit();
}
function onSoldOut(table,marketType){
	if(!confirm('품절연동(관리자)을 하시겠습니까?')){
		return false;
	}
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"table": table,
			"marketType": marketType
	    },
	    dataType: "json",
	    url:"/admin/product/popup_soldout.action",
	    success:function(data, status) {			
	    	onSoldOutDataSearch();
		},
	    error:function(request, status) {
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {
	    	
	     }
	});		
}
</script>
</head>
<body bgcolor="4b4b4b">
<form name="soldOutFrm" method="post" >
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" valign="bottom" background="/images/title_soldout.gif">&nbsp;</td>
  </tr>
</table>
<table width="850" border="7" align="center" cellpadding="15" cellspacing="0" bordercolor="4b4b4b">
  <tr>
    <td align="center" bgcolor="#FFFFFF"><br>
      <table width="820" border="0" align="center" cellpadding="0" cellspacing="0">
        <!--인터파크 제품번호,제품번호로 콤마구분/ 11번가,옥션,지마켓 엔터로 구분 -->
        <tr>
         <td height="25"> 
        	<select name="table" id="table" >            	
            	<option value="fobu" <c:if test="${table == 'fobu'}">selected</c:if>>포부</option>
            	<option value="choco" <c:if test="${table == 'choco'}">selected</c:if>>초코</option>
            	<option value="good" <c:if test="${table == 'good'}">selected</c:if>>굿파더</option>
            	<option value="min" <c:if test="${table == 'min'}">selected</c:if>>민트윈</option>
            	<option value="tmin" <c:if test="${table == 'tmin'}">selected</c:if>>트윈몰</option>   
            	<option value="sun" <c:if test="${table == 'sun'}">selected</c:if>>초코팝</option>               
          	</select>
			<input type="button" value="조회" onclick="onSoldOutDataSearch();"/></td>
        </tr>
        <tr>
          <td height="25"><table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
              
              <tr>
                <td width="20%" height="21" align="center" bgcolor="#FFFFFF"><img src="/images/icon_auction.gif" >&nbsp;&nbsp;<b>${marketAutCnt}</b></td>
                <td width="20%" align="center" bgcolor="#FFFFFF"><img src="/images/icon_gmarket.gif" >&nbsp;&nbsp;<b>${marketGmkCnt}</b></td>
                <td width="20%" align="center" bgcolor="#FFFFFF"><img src="/images/icon_11st.gif" >&nbsp;&nbsp;<b>${marketCywCnt}</b></td>
                <td width="20%" align="center" bgcolor="#FFFFFF"><img src="/images/icon_itp.gif" >&nbsp;&nbsp;<b>${marketItpCnt}</b></td>
                <td width="20%" align="center" bgcolor="#FFFFFF"><img src="/images/logo_nshop.gif" >&nbsp;&nbsp;<b>${marketShnCnt}</b></td>
                <td width="20%" align="center" bgcolor="#FFFFFF"><img src="/images/logo_nshop.gif" >&nbsp;&nbsp;<b>${marketShnCnt}</b></td>
              <tr>
                <td height="21" align="center" bgcolor="#FFFFFF">
                    <textarea name="textarea11" id="textarea11" cols="12" rows="15"><c:forEach var='marketAutList' items='${marketAut}'>${marketAutList.url}
</c:forEach></textarea></td>
                <td align="center" bgcolor="#FFFFFF">
                	<textarea name="textarea11" id="textarea12" cols="12" rows="15"><c:forEach var='marketGmkList' items='${marketGmk}'>${marketGmkList.url}
</c:forEach></textarea></td>
                <td align="center" bgcolor="#FFFFFF">
                	<textarea name="textarea11" id="textarea13" cols="12" rows="15"><c:forEach var='marketCywList' items='${marketCyw}'>${marketCywList.url}
</c:forEach></textarea></td>
                <td align="center" bgcolor="#FFFFFF">
                	<textarea name="textarea11" id="textarea14" cols="12" rows="15"><c:forEach var='marketItpList' items='${marketItp}'>${marketItpList.url},</c:forEach></textarea></td>
                <td align="center" bgcolor="#FFFFFF">
                	<textarea name="textarea11" id="textarea15" cols="12" rows="15"><c:forEach var='marketShnList' items='${marketShn}'>${marketShnList.url},</c:forEach></textarea></td>	
                <td align="center" bgcolor="#FFFFFF">
                	<textarea name="textarea11" id="textarea16" cols="12" rows="15"><c:forEach var='marketSunList' items='${marketSun}'>${marketSunList.url},</c:forEach></textarea></td>	
              </tr>
              <tr>
                <td height="21" align="center" bgcolor="#FFFFFF"><a href="javascript:;" onclick="onSoldOut('${table}','aut');"><img src="/images/button/s_button_03.gif" width="30" height="18" border="0"></a></td>
                <td align="center" bgcolor="#FFFFFF"><a href="javascript:;" onclick="onSoldOut('${table}','gmk');"><img src="/images/button/s_button_03.gif" width="30" height="18" border="0"></a></td>
                <td align="center" bgcolor="#FFFFFF"><a href="javascript:;" onclick="onSoldOut('${table}','cyw');"><img src="/images/button/s_button_03.gif" width="30" height="18" border="0"></a></td>
                <td align="center" bgcolor="#FFFFFF"><a href="javascript:;" onclick="onSoldOut('${table}','itp');"><img src="/images/button/s_button_03.gif" width="30" height="18" border="0"></a></td>
                <td align="center" bgcolor="#FFFFFF"><a href="javascript:;" onclick="onSoldOut('${table}','shn');"><img src="/images/button/s_button_03.gif" width="30" height="18" border="0"></a></td>
                <td align="center" bgcolor="#FFFFFF"><a href="javascript:;" onclick="onSoldOut('${table}','sun');"><img src="/images/button/s_button_03.gif" width="30" height="18" border="0"></a></td>
             
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
</body>
</html>


