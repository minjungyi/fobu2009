<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" %>
<%
	response.setHeader("Content-Type","application/vnd.ms-xls");
	response.setHeader("Content-Disposition", "attachment; filename=productListExcel.xls");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<table id="product_list" border="1" cellspacing='0' cellpadding='0' align="center">
		<tr>
			<td>이미지</td>
			<td>브랜드명</td>
			<td>카테고리</td>
			<td>제품명</td>
			<td>초기재고</td>
			<td>실재고</td>
			<td>누적</td>
			<td>매입가</td>
			<td>원가</td>
			<td>판매가</td>
			<td>소비자가</td>
			<td>업체명</td>		
		</tr>
		<c:forEach items="${requestScope.listProduct}" var="list" varStatus="status">
			<tr height='50'>
				<td style="vertical-align: middle;" align='center' width='50'>
					<img src='<c:out value="${hostURL}"/><c:out value="${titleImgPath}"/>/<c:out value="${list.titleImageFile}"/>' width='50' height='49'/>
				</td>
				<td><c:out value="${list.brandNm}"/></td>	
				<td><c:out value="${list.categoryNm1}"/>><c:out value="${list.categoryNm2}"/>><c:out value="${list.categoryNm3}"/></td>
				<td><c:out value="${list.product}"/></td>
				<td><c:out value="${list.realStock}"/></td>
				<td><c:out value="${list.realStock + list.productStock - list.orderStock}"/></td>
				<td><c:out value="${list.orderStock}"/></td>
				<td><c:out value="${list.originalPrice}"/></td>
				<td><c:out value="${list.familyPrice}"/></td>
				<td><c:out value="${list.sellPrice}"/></td>	
				<td><c:out value="${list.retailPrice}"/></td>		
				<td><c:out value="${list.company}"/></td>			
			</tr>
		</c:forEach>
	</table>
</body>
</html>




