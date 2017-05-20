<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ page import="org.springframework.web.context.request.RequestContextHolder" session="true"%>
<%@ page import="org.springframework.web.context.request.RequestAttributes" session="true"%>
<%@ page import="main.java.fobu.common.service.UserVO" session="true"%>


<%

UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
String userNm = userInfo.getLoginNm();
String userId = userInfo.getUserId();
String loginId = userInfo.getLoginId();
    
%>
<html>
<head>
<title>::::::::: FOBU 관리자페이지 입니다 :::::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/jquery.alphanumeric.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function MM_showHideLayers() { //v9.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) 
  with (document) if (getElementById && ((obj=getElementById(args[i]))!=null)) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}

function totalSearch(){
	var topFrm = document.all.totalTopFrm;
	var totalNameSel = topFrm.totalNameSel.value;
	var totalNameText = topFrm.totalNameText.value;
	topFrm.action = "/admin/orderManage/totalList.html";
	topFrm.target = "_self";
	topFrm.submit();
}

function newOrderPopup(){
	window.open('/admin/orderManage/orderProductT.html', 'packageInfoP', 'width=800, height=800, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}
//-->
</script>
<style type="text/css">
<!--
#top1 {
	position:absolute;
	height:20px;
	z-index:1;
	visibility: hidden;
}
#top2 {
	position:absolute;
	height:20px;
	z-index:1;
	visibility: hidden;
}
#top3 {
	position:absolute;
	height:20px;
	z-index:1;
	visibility: hidden;
}
#top4 {
	position:absolute;
	height:20px;
	z-index:1;
	visibility: hidden;
}
#top5 {
	position:absolute;
	height:20px;
	z-index:1;
	visibility: hidden;
}
#top6 {
	position:absolute;
	height:20px;
	z-index:1;
	visibility: hidden;
}
#top7 {
	position:absolute;
	height:20px;
	z-index:1;
	visibility: hidden;
}
#top8 {
	position:absolute;
	height:20px;
	z-index:1;
	visibility: hidden;
}
-->
</style>
</head>
<body>
<form name="totalTopFrm" method="post" onSubmit="return false">
<table width="100%" height="80" border="0" cellpadding="0" cellspacing="0" onLoad="MM_preloadImages('/view/fobu/admin/ainclude/images/mtb_01o.gif','/view/fobu/admin/ainclude/images/mtb_02o.gif','/view/fobu/admin/ainclude/images/mtb_03o.gif','/view/fobu/admin/ainclude/images/mtb_04o.gif','/view/fobu/admin/ainclude/images/mtb_05o.gif','/view/fobu/admin/ainclude/images/mtb_06o.gif','/view/fobu/admin/ainclude/images/mtb_07o.gif','/view/fobu/admin/ainclude/images/mtb_08o.gif','/view/fobu/admin/ainclude/images/mtb_09o.gif','../view/fobu/admin/ainclude/images/mtb_10o.gif')">

	<tr>
		<td align="center" valign="top" background="/view/fobu/admin/ainclude/images/top_bg.gif"><table width="1200" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="27" colspan="10" align="right" valign="top" style="padding-top:5px"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="1051" align="right">
                <b><%= userNm %></b> 님이 로그인 하셨습니다.
                <select name="totalNameSel">
                  <option value="orderName">주문자</option>
                  <option value="dName">수령인</option>
                  <option value="sDeliveryNo">송장번호</option>
                  <option value="sTel">전화번호</option>
                  <option value="sProducts">제품명</option>
                </select>
                  <input name="totalNameText" type="text" size="20" onkeydown="javascript:if(event.keyCode==13){totalSearch();}"></td>
                <td width="50" align="right"><a href="javascript:totalSearch()"><img src="/images/button/btn_search.gif"></a></td>
                <td width="100" align="right"><a href="javascript:newOrderPopup()"><img src="/images/button/tel_oder.gif"></a></td>
              </tr>
            </table></td>
		  </tr>
          <tr>
            <td><a href="/admin/main.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt1','','/view/fobu/admin/ainclude/images/mtb_01o.gif',1)"><img src="/view/fobu/admin/ainclude/images/mtb_01.gif" name="bt1" width="121" height="39" border="0"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt2','','/view/fobu/admin/ainclude/images/mtb_02o.gif',1)"><img src="/view/fobu/admin/ainclude/images/mtb_02.gif" name="bt2" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','show','top2','','hide','top3','','hide','top4','','hide','top5','','hide','top6','','hide','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt3','','/view/fobu/admin/ainclude/images/mtb_03o.gif',1)"><img src="/view/fobu/admin/ainclude/images/mtb_03.gif" name="bt3" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','show','top3','','hide','top4','','hide','top5','','hide','top6','','hide','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt4','','/view/fobu/admin/ainclude/images/mtb_04o.gif',1)"><img src="/view/fobu/admin/ainclude/images/mtb_04.gif" name="bt4" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','show','top4','','hide','top5','','hide','top6','','hide','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt5','','/view/fobu/admin/ainclude/images/mtb_05o.gif',1)"><img src="/view/fobu/admin/ainclude/images/mtb_05.gif" name="bt5" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','hide','top4','','show','top5','','hide','top6','','hide','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt6','','/view/fobu/admin/ainclude/images/mtb_06o.gif',1)"><img src="/view/fobu/admin/ainclude/images/mtb_06.gif" name="bt6" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','hide','top4','','hide','top5','','show','top6','','hide','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt7','','/view/fobu/admin/ainclude/images/mtb_07o.gif',1)"><img src="/view/fobu/admin/ainclude/images/mtb_07.gif" name="bt7" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','hide','top4','','hide','top5','','hide','top6','','show','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt8','','/view/fobu/admin/ainclude/images/mtb_08o.gif',1)"><img src="/view/fobu/admin/ainclude/images/mtb_08.gif" name="bt8" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','hide','top4','','hide','top5','','hide','top6','','hide','top7','','show','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt9','','/view/fobu/admin/ainclude/images/mtb_09o.gif',1)"><img src="/view/fobu/admin/ainclude/images/mtb_09.gif" name="bt9" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','hide','top4','','hide','top5','','hide','top6','','hide','top7','','hide','top8','','show')"></a></td>
            <td width="100"><a href="/common/login/logout.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt10','','/view/fobu/admin/ainclude/images/mtb_10o.gif',1)"><img src="/view/fobu/admin/ainclude/images/mtb_10.gif" name="bt10" width="120" height="39" border="0"></a></td>
          </tr>
          <tr>
            <td height="25"></td>
            <td align="left">
            	<div id="top1">
            		<a href="/admin/orderManage/totalList.html?type=111">주문정보통합검색</a> | 
		           	<a href="/admin/orderManage/totalList.html?type=0">신규주문</a> | 
		           	<a href="/admin/orderManage/totalList.html?type=1">업체발주</a> | 
		           	<a href="/admin/orderManage/totalList.html?type=2">업체입금</a> | 
		           	<a href="/admin/orderManage/totalList.html?type=3">배송완료</a> | 
		           	<a href="/admin/orderManage/totalList.html?type=4">발송보류</a> | 
		           	<a href="/admin/orderManage/totalList.html?type=5">취소요청</a> | 
		           	<a href="/admin/orderManage/totalList.html?type=6">취소완료</a> | 
		           	<a href="/admin/orderManage/totalList.html?type=7">반품요청</a> | 
		           	<a href="/admin/orderManage/totalList.html?type=8">반품완료</a> | 
		           	<a href="/admin/orderManage/totalList.html?type=9">교환요청</a> | 
		          	<a href="/admin/orderManage/totalList.html?type=10">교환완료</a> |
		          	<a href="/admin/orderManage/openMatketAccount.html">오픈마켓정산</a>
		         </div>
		    </td>
            <td align="left">
            	<div id="top2">
	            	<a href="/admin/product/product_list.html">제품통합검색</a> | 
	            	<a href="/admin/product/product_detailList.html">제품상세검색</a> | 
	            	<a href="/admin/product/product_write.html">제품등록 </a>| 
	            	<a href="/admin/product/product_list2.html">업체별 간편등록</a>| 
	            	<a href="/admin/product/product_category.html">카테고리/브랜드관리</a> | 
	            	<!--<a href="/admin/product/product_brand.html">브랜드관리</a> |--> 
	            	<a href="/admin/product/shop_manager.html">가격관리</a> | 
	            	<a href="/admin/product/new_shop_product.html">신제품관리</a> |
	           		<a href="/admin/product/product_company.html">거래처관리</a> |
	           		<a href="/admin/product/openmarket_manager.html">오픈마켓관리</a> 
           		</div>   
			</td>
            <td align="left"><div id="top3">회원통합검색 | 탈퇴회원관리 | B2B회원관리 | B2B회원가입요청</div></td>
            <td align="left">
            	<div id="top4">
            		<a href="/admin/accountManage/accountList.html">정산목록</a> |
            		<a href="/admin/accountManage/accountGroupList.html">정산그룹목록</a> |
            		<a href="/admin/accountManage/accountAccidentList.html">정산 후 변경목록</a> |
                    <a href="/admin/accountManage/accountAccidentGroupList.html">정산 후 변경그룹목록</a>
				</div>
			</td>
            <td align="left"><div id="top5">메인관리 | 팝업관리 | 이벤트관리</div></td>
			<td align="left">
            	<div id="top6">
            		<a href="/admin/operationBbs/operationBbsList.html">작업요청게시판</a> | 
            		<a href="/admin/bbs/bbsList.html?typeCode=0002">공지사항 </a>
            		<!-- a href="/admin/bbs/bbsList.html?typeCode=0003">제품문의게시판 </a> |
            		<a href="/admin/bbs/bbsList.html?typeCode=0004">이용후기관리</a> |
            		<a href="/admin/bbs/bbsList.html?typeCode=0005">기타게시판</a-->
            	</div>
			</td>
            <td align="left">
            	<div id="top7">
            		<a href="/admin/statisticsManage/statisticsList.html">월별통계</a> | 
					<a href="/admin/statisticsManage/statisticsDailyList.html">일별통계</a> |
					<a href="/admin/statisticsManage/statisticsProductList.html">상품별통계</a> |
					<a href="/admin/statisticsManage/statisticsDeliveryList.html">배송별통계</a> 
				</div></td>
            <td align="left"><div id="top8">거래처관리 | 신규거래처등록 | 매입재고등록</div></td>
            <td ></td>
          </tr>
        </table></td>
  </tr>

</table>
<input name="type" type="hidden" value="11"></input>
</form>