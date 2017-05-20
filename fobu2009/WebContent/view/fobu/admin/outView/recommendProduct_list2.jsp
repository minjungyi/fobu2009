<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/themes/base/ui.all.css"
	rel="stylesheet" />
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<title>카테고리 상세</title>

<script language="javascript">
	// javascript:p_reload('http://www.gmarket.co.kr/challenge/neo_goods/goods.asp?goodscode=226830363&amp;str_id=open_otherhit');

function p_reload(val)
{
 top.location.href="<c:out value='${marketTypeUrl}'/>/"+val;
}
</script>
</head>
<body>
<table border=0 cellspacing=0 cellpadding=0 width=780 align=center>
	<tbody>
		
		<tr>
			<td
				background="/data/images/Dealer/<c:out value='${imgFolder}'/>/blue_bg.gif"
				width=5>&nbsp;</td>
			<td width=770 align=middle>
			<table border=0 cellspacing=0 cellpadding=0 width=770>
				<tbody>
					<tr>
						<c:set var="count" value="1" />
						<c:forEach var='recommendProductList' items='${listRecommendProduct}'>
							<c:choose>
								<c:when test="${count < 17}">

									<td width=186>
									<table border=0 cellspacing=0 cellpadding=0 width=186>
										<tbody>
											<tr>
												<td colspan=3><img
													src="/data/images/Dealer/<c:out value='${imgFolder}'/>/other_a_top.jpg"
													width=186 height=20></td>
											</tr>
											<tr>
												<td rowspan=4 width=14><img
													src="/data/images/Dealer/<c:out value='${imgFolder}'/>/other_a_l.jpg"
													width=14 height=242></td>
												<td height='40' width='160' align='middle'>
												<div style='width:160px; text-overflow:ellipsis; overflow:hidden;'>
												<a href="javascript:p_reload('<c:out value='${url}'/>');"><c:out
													value='${recommendProductList.product}' /></a></div></td>
												<td rowspan=4 width=12><img
													src="/data/images/Dealer/<c:out value='${imgFolder}'/>/other_a_r.jpg"
													width=12 height=242></td>
											</tr>
											<tr> 
												<td><img
													src="/data/images/Dealer/<c:out value='${imgFolder}'/>/other_a_m.jpg"
													width=160 height=12></td>
											</tr>
											<tr>
												<td><a href="javascript:p_reload('<c:out value='${url}'/>');"><img border=0 name=picture
													src="<c:out value='${imageLargePath}'/>/<c:out value='${recommendProductList.titleImageFile}'/>" width="150" height="150"></a></td>
											</tr>
											<tr>
												<td height=26 width=160 align=middle><strong><c:out
													value='${recommendProductList.mallPrice}' /></strong></td>
											</tr>
											<tr>
												<td colspan=3><img
													src="/data/images/Dealer/<c:out value='${imgFolder}'/>/other_a_btm.jpg"
													width=186 height=19></td>
											</tr>
										</tbody>
									</table>									</td>
								</c:when>

								<c:otherwise></c:otherwise>
							</c:choose>
							<c:if test="${count == 4 || count == 8 || count == 12}">
					</tr>
					<tr>
						</c:if>
						<c:set var="count" value="${count+1}" />
						</c:forEach>
					</tr>
				</tbody>
			</table>			</td>
			<td background="/data/images/Dealer/<c:out value='${imgFolder}'/>/blue_bg2.gif" width=5>&nbsp;</td>
		</tr>
		<tr>
			<td colspan=3><img src="/data/images/Dealer/<c:out value='${imgFolder}'/>/blue_btm.gif"></td>
		</tr>
	</tbody>
</table>
</body>
</html>
