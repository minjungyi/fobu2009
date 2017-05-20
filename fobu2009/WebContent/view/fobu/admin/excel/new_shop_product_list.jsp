<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" %>
<%

	response.setHeader("Content-Type","application/vnd.ms-excel");
   	response.setHeader("Content-Disposition", "attachment; filename=newProduct.xls");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<table id="product_list" border="1" cellspacing='0' cellpadding='0' align="center">
		<c:forEach var="newProductList" items="${listProduct}">
			<tr>
			  <td align=center><c:out value="${newProductList.seq}"/></td>
			  <td align=center>
			  	<c:if test="${deliver_type == '무료'}">(무료배송)</c:if>
			  	<c:if test="${marketType == 'aut' || marketType == 'cyw' || marketType == 'shn'}"><c:out value="${newProductList.brandNm}"/></c:if>
			  	<c:out value="${newProductList.product}"/>
		  	  </td>
			  <td align=center><c:out value="${newProductList.searchText}"/></td>
			  <td align=center>&nbsp;</td>
			  <td align=center></td>
			  <td align=center>&nbsp;</td>
			  <td align=center style="mso-number-format:'@';"><c:out value="${newProductList.startPrice}"/></td>
			  <td align=center style="mso-number-format:'@';"><c:out value="${newProductList.familyPrice}"/></td>
			  <td align=center style="mso-number-format:'@';"><c:out value="${newProductList.mallPrice}"/></td>
			  <td align=center style="mso-number-format:'@';"><c:out value="${newProductList.retailPrice}"/></td>
			  <td align=center style="mso-number-format:'@';">
				  <c:choose>
				  <c:when test="${companyCategory == '26' || companyCategory == '27' }"> <c:out value="${newProductList.realStock}"/> </c:when>			  
				  <c:otherwise><c:out value="${newProductList.stock}"/></c:otherwise>
				  </c:choose>
			  </td>
			  <td align=center>과세</td>
			  <td align=center>&nbsp;</td>
			  <td align=center><c:out value="${newProductList.brandNm}"/></td>
			  <td align=center><c:out value="${newProductList.originCountry}"/></td>
			  <td align=center>전국</td>
			  <td align=center>공용</td>
			  <td align=center>판매중</td>
			  <td align=center>
			  	<c:if test="${newProductList.sizeOpt !=''}">사이즈</c:if>
			  	<c:if test="${newProductList.sizeOpt =='' && newProductList.colorOpt != ''}">색상</c:if>
		  	  </td>
			  <td align=center style="mso-number-format:'@';">
			  	<c:if test="${newProductList.sizeOpt !=''}"><c:out value="${newProductList.sizeOpt}"/></c:if>
			  	<c:if test="${newProductList.sizeOpt =='' && newProductList.colorOpt != ''}"><c:out value="${newProductList.colorOpt}"/></c:if>			  	
			  </td>
			  <td align=center>
			  	<c:if test="${newProductList.sizeOpt !='' && newProductList.colorOpt != ''}">색상</c:if>
			  </td>
			  <td align=center style="mso-number-format:'@';">
			  	<c:if test="${newProductList.sizeOpt !='' && newProductList.colorOpt != ''}"><c:out value="${newProductList.colorOpt}"/></c:if>
			  </td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center>
			  	<c:out value="${hostURL}"/><c:out value="${imageTitlePath}"/><c:if test="${marketType == 'cyw'}">_cyw</c:if>/<c:out value="${newProductList.titleImageFile}"/></td>
			  <td align=center><c:out value="${deliver_type}"/></td>
			  <td align=center><c:out value="${newProductList.deliverPrice}"/></td>
			  <td align=center>
			  	<c:if test="${deliver_type == '무료'}">(무료배송)</c:if>
			  	<c:if test="${marketType == 'aut' || marketType == 'cyw'}"><c:out value="${newProductList.brandNm}"/></c:if>
			  	<c:out value="${newProductList.product}"/>
		  	  </td>
			  <td align=center><c:out value="${newProductList.detailHtml}"/></td>
			  <td align=center><c:if test="${marketType == 'aut' || marketType == 'gmk'}"><c:out value="${newProductList.detailHtml}"/></c:if></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center><c:out value="${newProductList.brandNm}"/></td>
			  <td align=center style="mso-number-format:'@';"><c:out value="${newProductList.category1}"/></td>
			  <td align=center style="mso-number-format:'@';"><c:out value="${newProductList.category2}"/></td>
			  <td align=center style="mso-number-format:'@';"><c:out value="${newProductList.category3}"/></td>
			  <td align=center style="mso-number-format:'@';">&nbsp;</td>
			  
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center>i<c:out value="${newProductList.infocategory}"/></td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>
			  	<c:choose>
				  <c:when test="${newProductList.infocategory == '06' || newProductList.infocategory == '07' || newProductList.infocategory == '08'
				  				|| newProductList.infocategory == '09'|| newProductList.infocategory == '10'|| newProductList.infocategory == '11'
				  				|| newProductList.infocategory == '12'|| newProductList.infocategory == '13'|| newProductList.infocategory == '14'
				  				|| newProductList.infocategory == '23' }"></c:when>			  
				  <c:otherwise>상세정보 별도표기(정보누락 시 추후제공)</c:otherwise>
				</c:choose>
			  </td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			  <td align=center>상세정보 별도표기(정보누락 시 추후제공)</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>




