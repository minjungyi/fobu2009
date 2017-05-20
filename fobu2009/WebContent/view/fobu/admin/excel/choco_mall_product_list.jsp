<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" %>
<%

	response.setHeader("Content-Type","application/vnd.ms-excel");
   	response.setHeader("Content-Disposition", "attachment; filename=chocoMallNewProduct.xls");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<table id="product_list" border="1" cellspacing='0' cellpadding='0' align="center">
		<tr>
			  <td align=center>상품코드</td>
			  <td align=center>자체 상품코드</td>
			  <td align=center>진열상태</td>
			  <td align=center>판매상태</td>
			  <td align=center>상품분류 번호</td>
			  <td align=center>상품분류 신상품영역</td>
			  <td align=center>상품분류 추천상품영역</td>
			  <td align=center>상품명</td>
			  <td align=center>영문 상품명</td>
			  <td align=center>상품명(관리용)</td>
			  <td align=center>공급사 상품명</td>
			  <td align=center>모델명</td>
			  <td align=center>상품 요약설명</td>
			  <td align=center>상품 간략설명</td>
			  <td align=center>상품 상세설명</td>			  
			  <td align=center>검색어설정</td>
			  <td align=center>과세구분</td>
			  <td align=center>소비자가</td>
			  <td align=center>공급가</td>
			  <td align=center>판매가</td>
			  <td align=center>판매가 대체문구 사용</td>
			  <td align=center>판매가 대체문구</td>
			  <td align=center>최소 주문수량(이상)</td>
			  <td align=center>최대 주문수량(이하)</td>
			  <td align=center>적립금</td>
			  <td align=center>적립금 구분</td>
			  <td align=center>성인인증</td>
			  <td align=center>옵션사용</td>
			  <td align=center>품목 구성방식</td>
			  <td align=center>옵션 표시방식</td>
			  <td align=center>옵션입력</td>
			  <td align=center>필수여부</td>
			  <td align=center>추가입력옵션 </td>
			  <td align=center>추가입력옵션 명칭</td>
			  <td align=center>추가입력옵션 선택/필수여부</td>
			  <td align=center>입력글자수(자)</td>
			  <td align=center>이미지등록(상세)</td>
			  <td align=center>이미지등록(목록)</td>
			  <td align=center>이미지등록(작은목록)</td>
			  <td align=center>이미지등록(축소)</td>
			  <td align=center>제조사</td>
			  <td align=center>공급사</td>
			  <td align=center>브랜드</td>
			  <td align=center>트렌드</td>
			  <td align=center>제조일자</td>
			  <td align=center>출시일자</td>
			  <td align=center>유효기간 사용여부</td>
			  <td align=center>유효기간</td>
			  <td align=center>원산지</td>
			  <td align=center>상품결제안내</td>
			  <td align=center>상품배송안내</td>
			  <td align=center>교환/반품안내</td>
			  <td align=center>서비스문의/안내</td>
			  <td align=center>배송정보</td>
			  <td align=center>배송방법</td>
			  <td align=center>국내/해외배송</td>
			  <td align=center>배송지역</td>
			  <td align=center>배송비 선결제 설정</td>
			  <td align=center>배송기간</td>
			  <td align=center>배송비</td>
			  <td align=center>배송비입력</td>
			  <td align=center>상품 전체중량(kg)</td>
			  <td align=center>HS코드</td>
			  <td align=center>상품소재</td>			  
			  <td align=center>검색엔진최적화(SEO) Title</td>			  
			  <td align=center>검색엔진최적화(SEO) Author</td>			  
			  <td align=center>검색엔진최적화(SEO) Description</td>			  
			  <td align=center>검색엔진최적화(SEO) Keywords</td>
			  <td align=center>개별결제수단설정</td>
			</tr>
		<c:forEach var="newProductList" items="${listProduct}">
			<tr>
			  <td align=center></td>
			  <td align=center><c:out value="${newProductList.seq}"/></td>
			  <td align=center>Y</td>
			  <td align=center>Y</td>
			  <td align=center><c:out value="${newProductList.category3}"/></td>
			  <td align=center>Y</td>
			  <td align=center>Y</td>
			  <td align=center>
			  	<c:if test="${newProductList.companyCategory == '26' || newProductList.companyCategory == '27'}">(할인)</c:if>
			  	<c:out value="${newProductList.brandNm}"/> <c:out value="${newProductList.product}"/>
			  </td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center><c:out value="${newProductList.detailHtml}"/></td>			  
			  <td align=center><c:out value="${newProductList.searchText}"/></td>
			  <td align=center></td>
			  <td align=center style="mso-number-format:'@';"><c:out value="${newProductList.retailPrice}"/></td>
			  <td align=center style="mso-number-format:'@';"><c:out value="${newProductList.familyPrice}"/></td>
			  <td align=center style="mso-number-format:'@';"><c:out value="${newProductList.mallPrice}"/></td>
			  <td align=center>N</td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center>N</td>
			  <td align=center>
			  	<c:choose>
				  <c:when test="${newProductList.sizeOpt2 != '' || newProductList.colorOpt2 != '' }">Y</c:when>			  
				  <c:otherwise>N</c:otherwise>
				</c:choose>
			  </td>
			  <td align=center>
			  	<c:choose>
				  <c:when test="${newProductList.sizeOpt2 != '' || newProductList.colorOpt2 != '' }">T</c:when>			  
				  <c:otherwise>F</c:otherwise>
				</c:choose>
			  </td>
			  <td align=center>
			  	<c:choose>
				  <c:when test="${newProductList.sizeOpt2 != '' || newProductList.colorOpt2 != '' }">C</c:when>			  
				  <c:otherwise></c:otherwise>
				</c:choose>
			  </td>
			  <td align=center>
			  	<c:choose>
				  <c:when test="${newProductList.sizeOpt2 != ''}">옵션{<c:out value="${newProductList.sizeOpt2}"/>}</c:when>
				  <c:when test="${newProductList.colorOpt2 != ''}">옵션{<c:out value="${newProductList.colorOpt2}"/>}</c:when>			  
				  <c:otherwise></c:otherwise>
				</c:choose>			  
			  </td>
			  <td align=center>
			  	<c:choose>
				  <c:when test="${newProductList.sizeOpt2 != '' || newProductList.colorOpt2 != '' }">T</c:when>			  
				  <c:otherwise></c:otherwise>
				</c:choose>
			  </td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center><c:out value="${newProductList.seq}"/>.jpg</td>
			  <td align=center><c:out value="${newProductList.seq}"/>.jpg</td>
			  <td align=center><c:out value="${newProductList.seq}"/>.jpg</td>
			  <td align=center><c:out value="${newProductList.seq}"/>.jpg</td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center><c:out value="${newProductList.originCountryCode}"/></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center></td>
			  <td align=center>F</td>
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
			</tr>
		</c:forEach>
	</table>
</body>
</html>




