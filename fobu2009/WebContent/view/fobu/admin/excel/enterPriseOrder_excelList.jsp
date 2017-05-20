<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" %>
<%
String toDay = request.getParameter("toDay");    
String excelName = request.getParameter("searchCompany").trim()+"_"+ toDay + ".xls";
String toDayTmp = toDay.substring(0,4)+"."+toDay.substring(4,6)+"."+toDay.substring(6,8);
System.out.println("excelName ===>"+excelName);
    response.setHeader("Content-Type","application/vnd.ms-xls");
   	response.setHeader("Content-Disposition", "attachment; filename="+excelName);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
    <c:forEach items="${requestScope.listCompany}" var="listCompanyList">
    <table id="orderExcel_list" border="1" cellspacing='0' cellpadding='0' align="center">
        <tr style="background-color:yellow; font-size: 13pt"><td colspan="9"><b><c:out value="${listCompanyList.companyName}"/>(<%=toDayTmp%>)</b></td>
        </tr>
        <tr>
            <c:if test='${textYn == "N"}'>
            <td>이미지</td>
            </c:if>
            <td>[브랜드] 상품명</td>
            <td>원가</td>
            <td>수량</td>
            <td>총계</td>
            <td>재고</td>
            <td>비고</td>
            <td>주문경로</td>
            <td>발주일</td>
        </tr>       
            <c:set var="orderQySum" value="0"/>
            <c:set var="orderPriceSum" value="0"/>
            <c:set var="orderCnt" value="0"/>
	        <c:forEach items="${requestScope.enterpriseOrderExcelList}" var="list" varStatus="status">
	        <c:if test='${listCompanyList.companyCategory == list.companyCategory}'>
	            <c:set var="orderQySum" value="${orderQySum + list.enterpriseOrderQy}"/>
                <c:set var="orderPriceSum" value="${orderPriceSum + list.orderPriceSum}"/>
                <c:set var="orderCnt" value="${orderCnt+1}"/>
	            <tr height='55'>
	                <c:if test='${textYn == "N"}'>
	                <td style="vertical-align: middle;" align='center' width='50'>
	                    <img src='<c:out value="${hostURL}"/><c:out value="${titleImgPath}"/>/<c:out value="${list.titleImageFile}"/>' width='50' height='50'/>
	                </td>
	                </c:if>
	                <td>[<c:out value="${list.brandNm}"/>] <b><c:out value="${list.product}"/></b>
	                </td>
	                <td><c:out value="${list.originalPrice}"/></td>
                    <td><c:out value="${list.enterpriseOrderQy}"/></td>
                    <td><c:out value="${list.orderPriceSum}"/></td>
	                <td><c:out value="${list.realStock}"/></td>
	                <td><c:out value="${list.remark}"/></td>
	                <td><c:out value="${list.enterpriseOrderTarget}"/></td>
	                <td><c:out value="${list.orderDate}"/></td>
	            </tr>
	            </c:if>
	        </c:forEach>
	        <tr style="background-color:gray">
	           <td></td>
	           <td></td>
	           <td></td>
	           <td>${orderCnt}건 ${orderQySum}개</td>
	           <td>${orderPriceSum}원</td>
	           <td></td>
	           <td></td>
	           <td></td>
	           <td></td>
	        </tr>
        <tr><td colspan="9"></td></tr>
    </table>
    </c:forEach>
</body>
</html>




