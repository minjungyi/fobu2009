<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<title>카테고리 상세</title>
<style type="text/css">
/* ... 으로 자르기*/
.divCut {
 white-space:nowrap; 
 text-overflow:ellipsis; 
 overflow:hidden;
}
</style>
<script language="javascript">
	// javascript:p_reload('http://www.gmarket.co.kr/challenge/neo_goods/goods.asp?goodscode=226830363&amp;str_id=open_otherhit');

function p_reload(val)
{
 //alert(	"<c:out value='${marketTypeUrl}'/>"+val);
 top.location.href="<c:out value='${marketTypeUrl}' escapeXml='false'/>"+val;
}
</script>
</head>
<body>
<!--변경부분 start -->
<table width="780" border="0" align="center" cellspacing="1" bgcolor="d2d2d2">
  <tr>
    <td width="25%" align="center"><b>품명/모델명(구성/색상/종류)</b> </td>
    <td width="75%" height="25"><c:out value="${listProductDetail[0].product}"/></td>
  </tr>
  <tr>
    <td colspan="2"><table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="d2d2d2">
      <tr>
        <td width="100" bgcolor="#FFFFFF">색상/치수</td>
        <td width="245" bgcolor="#FFFFFF">
        <c:if test="${listProductDetail[0].sizeOpt == ''}">
        	상세정보 참조
        </c:if>
        <c:out value="${listProductDetail[0].sizeOpt}"/>        
        </td>
        <td width="168" bgcolor="#FFFFFF">제품소재/재질</td>
        <td width="234" bgcolor="#FFFFFF">상세정보 별도표기(정보누락 시 추후제공)</td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF">크기/중량</td>
        <td bgcolor="#FFFFFF">상세정보 별도표기(정보누락 시 추후제공)</td>
        <td bgcolor="#FFFFFF">사용연령/적용대상(전압/전력)</td>
        <td bgcolor="#FFFFFF">상세정보 별도표기(정보누락 시 추후제공)</td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF">제조일(출간일)</td>
        <td bgcolor="#FFFFFF">발송일로 12개월이내제조(이후제품별도공지)</td>
        <td bgcolor="#FFFFFF">동일모델출시년월</td>
        <td bgcolor="#FFFFFF">상세정보 별도표기(정보누락 시 추후제공)</td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF">제조국</td>
        <td bgcolor="#FFFFFF"><c:out value="${listProductDetail[0].originCountry}"/></td>
        <td bgcolor="#FFFFFF">제조자/수입자(저자/출판사)</td>
        <td bgcolor="#FFFFFF">상세정보 별도표기(정보누락 시 추후제공)</td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF">품질보증기준</td>
        <td bgcolor="#FFFFFF">상세정보 별도표기(정보누락 시 추후제공)</td>
        <td bgcolor="#FFFFFF">kc인증/안전인증/각종인증</td>
        <td bgcolor="#FFFFFF">상세정보 별도표기(정보누락 시 추후제공)</td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF">AS책임자/연락처</td>
        <td bgcolor="#FFFFFF">민정화(070-7559-4645)</td>
        <td bgcolor="#FFFFFF">주의사항/사용방법/세탁방법</td>
        <td bgcolor="#FFFFFF">상세정보 별도표기(정보누락 시 추후제공)</td>
      </tr>
    </table></td>
  </tr>
</table>
<!--변경부분 end -->
<table width="780" border="0" align="center" cellpadding="0"
	cellspacing="0">
	 <tr>
	    <td align="center"><img src="/data/images/Dealer/<c:out value='${imgFolder}'/>/chu_top.jpg" ></td>
	 </tr>
	<tr>
		<td align="center" background="/data/images/Dealer/<c:out value='${imgFolder}'/>/c_bg.gif">
		<table width="745" border="0" cellspacing="0" cellpadding="0">
			<!-- 시작점 -->
			<c:set var="tempCategory2" value="-1" />
			<c:forEach var='recommendProductList' items='${listRecommendProduct}'>
			
			<c:choose>
				<c:when test="${tempCategory2 != recommendProductList.category2}">
				<c:if test="${tempCategory2 != -1}">
     				</tr>
     				</table>
     				</td>
     				</tr>
				</c:if>
				<c:set var="count" value="1" />
					<tr height="3px"></tr>
					<tr>
						<td><!--카테고리 타이틀 start -->
						<table width="745" border="0" align="center" cellpadding="0"
							cellspacing="0" bordercolor="<c:out value='${backColor}'/>">
							<tr>
								<td><img src="/data/images/Notice/category/<c:out value='${recommendProductList.category2}'/>.gif" ></td>
							</tr>
						</table>
						<!--카테고리 타이틀 end --></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td><!--카테고리 start -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr height="0px">
								<td width="25%"></td>
								<td width="25%"></td>
								<td width="25%"></td>
								<td width="25%"></td>
							</tr>
							<tr>
				<c:set var="tempCategory2" value="${recommendProductList.category2}" />
				</c:when>
				<c:otherwise></c:otherwise>
				</c:choose>
				<td width="25%">
				<table width="175" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td>
						<table width="150" border="0" align="center" cellpadding="0"
							cellspacing="1" bordercolor="ebebeb" bgcolor="e6e6e6">
							<tr>
								<td bgcolor="#FFFFFF"><a
									href="javascript:p_reload('<c:out value='${recommendProductList.url}'/>');"><img
									border=0 name=picture
									src="<c:out value='${imageLargePath}'/>/<c:out value='${recommendProductList.titleImageFile}'/>"
									width="150" height="150"></a></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr height="3px"><td></td></tr>
					<tr>
						<td align="center"><c:out
							value='${recommendProductList.brandNm}' /></td>
					</tr>
					<tr>
						<td align="center"><a
							href="javascript:p_reload('<c:out value='${recommendProductList.url}'/>');"> 
							<div class="divCut" style="width:170px;">
							<c:out value='${recommendProductList.product}' />
							</div></a></td>
					</tr>
					<tr>
						<td align="center"><strong><c:out
							value='${recommendProductList.mallPrice}' /></strong></td>
					</tr>
				</table>
				</td>
				<c:if test="${count == 4 || count == 8 || count == 12 || count == 16 || count == 20}">
					</tr>
					<tr>
			        	<td></td>
			            <td>&nbsp;</td>
			            <td>&nbsp;</td>
			            <td>&nbsp;</td>
			        </tr>
					<tr>
				</c:if>
				<c:set var="count" value="${count+1}" />
			</c:forEach>
			<!-- 끝점 -->
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><img src="/data/images/Dealer/<c:out value='${imgFolder}'/>/c_buttom.gif" width="780" height="40"></td>
	</tr>
</table>
</body>
</html>
