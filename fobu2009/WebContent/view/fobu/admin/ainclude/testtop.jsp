<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
<title>::::::::: FOBU 관리자페이지 입니다 :::::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../css/css.css" rel="stylesheet" type="text/css">
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
//-->
</script>
<style type="text/css">
<!--
#top1 {
	position:absolute;
	width:1000px;
	height:27px;
	z-index:1;
	visibility: hidden;
}
#top2 {
	position:absolute;
	width:1000px;
	height:30px;
	z-index:1;
	visibility: hidden;
}
#top3 {
	position:absolute;
	width:1000px;
	height:30px;
	z-index:1;
	visibility: hidden;
}
#top4 {
	position:absolute;
	width:1000px;
	height:30px;
	z-index:1;
	visibility: hidden;
}
#top5 {
	position:absolute;
	width:1000px;
	height:30px;
	z-index:1;
	visibility: hidden;
}
#top6 {
	position:absolute;
	width:1000px;
	height:30px;
	z-index:1;
	visibility: hidden;
}
#top7 {
	position:absolute;
	width:1000px;
	height:30px;
	z-index:1;
	visibility: hidden;
}
#top8 {
	position:absolute;
	width:1000px;
	height:30px;
	z-index:1;
	visibility: hidden;
}
-->
</style>
</head>
<body onLoad="MM_preloadImages('/view/fobu/ainclude/images/mtb_01o.gif','/view/fobu/ainclude/images/mtb_02o.gif','/view/fobu/ainclude/images/mtb_03o.gif','/view/fobu/ainclude/images/mtb_04o.gif','/view/fobu/ainclude/images/mtb_05o.gif','/view/fobu/ainclude/images/mtb_06o.gif','/view/fobu/ainclude/images/mtb_07o.gif','/view/fobu/ainclude/images/mtb_08o.gif','/view/fobu/ainclude/images/mtb_09o.gif','/view/fobu/ainclude/images/mtb_10o.gif')">
<table width="100%" height="80" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center" valign="top" background="/view/fobu/ainclude/images/top_bg.gif"><table width="1200" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="19">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><a href="file:///D|/포부포부/00오리지날사업/admin/amain/main.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt1','','/view/fobu/ainclude/images/mtb_01o.gif',1)"><img src="/view/fobu/ainclude/images/mtb_01.gif" name="bt1" width="121" height="39" border="0"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt2','','/view/fobu/ainclude/images/mtb_02o.gif',1)"><img src="/view/fobu/ainclude/images/mtb_02.gif" name="bt2" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','show','top2','','hide','top3','','hide','top4','','hide','top5','','hide','top6','','hide','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt3','','/view/fobu/ainclude/images/mtb_03o.gif',1)"><img src="/view/fobu/ainclude/images/mtb_03.gif" name="bt3" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','show','top3','','hide','top4','','hide','top5','','hide','top6','','hide','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt4','','/view/fobu/ainclude/images/mtb_04o.gif',1)"><img src="/view/fobu/ainclude/images/mtb_04.gif" name="bt4" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','show','top4','','hide','top5','','hide','top6','','hide','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt5','','/view/fobu/ainclude/images/mtb_05o.gif',1)"><img src="/view/fobu/ainclude/images/mtb_05.gif" name="bt5" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','hide','top4','','show','top5','','hide','top6','','hide','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt6','','/view/fobu/ainclude/images/mtb_06o.gif',1)"><img src="/view/fobu/ainclude/images/mtb_06.gif" name="bt6" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','hide','top4','','hide','top5','','show','top6','','hide','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt7','','/view/fobu/ainclude/images/mtb_07o.gif',1)"><img src="/view/fobu/ainclude/images/mtb_07.gif" name="bt7" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','hide','top4','','hide','top5','','hide','top6','','show','top7','','hide','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt8','','/view/fobu/ainclude/images/mtb_08o.gif',1)"><img src="/view/fobu/ainclude/images/mtb_08.gif" name="bt8" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','hide','top4','','hide','top5','','hide','top6','','hide','top7','','show','top8','','hide')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt9','','/view/fobu/ainclude/images/mtb_09o.gif',1)"><img src="/view/fobu/ainclude/images/mtb_09.gif" name="bt9" width="120" height="39" border="0" onMouseOver="MM_showHideLayers('top1','','hide','top2','','hide','top3','','hide','top4','','hide','top5','','hide','top6','','hide','top7','','hide','top8','','show')"></a></td>
            <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt10','','/view/fobu/ainclude/images/mtb_10o.gif',1)"><img src="/view/fobu/ainclude/images/mtb_10.gif" name="bt10" width="120" height="39" border="0"></a></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><div id="top1"><a href="../order/total_list.html">주문정보통합검색</a> | 신규주문정보 | 업체발주주문 | 업체입금주문 | 배송완료주문 | 발송보류| 취소요청 | 취소완료 | 반품요청 | 반품완료 | 교환요청 | 교환완료 | </div></td>
            <td><div id="top2"><a href="../order/total_list.html">제품통합검색</a> | 제품등록 | 묶음제품관리 | 카테고리관리 | 브랜드관리 | 가격관리 | 신제품관리</div></td>
            <td><div id="top3">회원통합검색 | 탈퇴회원관리 | B2B회원관리 | B2B회원가입요청</div></td>
            <td><div id="top4"> |  | | </div></td>
            <td><div id="top5">메인관리 | 팝업관리 | 이벤트관리</div></td>
            <td><div id="top6"><a href="../board/wboard_list.html">작업요청게시판</a> | 공지사항 | 제품문의게시판 | 이용후기관리 | 기타게시판</div></td>
            <td><div id="top7"> |  | | </div></td>
            <td><div id="top8">거래처관리 | 신규거래처등록 | 매입재고등록</div></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
  </tr>
</table>
