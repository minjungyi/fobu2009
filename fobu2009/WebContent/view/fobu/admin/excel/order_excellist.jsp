<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" %>
<%
String toDay = request.getParameter("toDay");    
String excelName = request.getParameter("companyCategory").trim()+"_"+ toDay + ".xls";
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
        <tr style="background-color:yellow; font-size: 13pt"><td colspan="7"><b><c:out value="${listCompanyList.companyName}"/>(<%=toDayTmp%>)</b></td>
        </tr>
        <tr>
            <td>이미지</td>
            <td>[브랜드] 상품명 (옵션)</td>
            <td>수량</td>
            <td>원가</td>
            <td>총계</td>
            <td>수령자명/배송타입/연락처</td>
            <td>[배송메세지] 관리자메모</td>
        </tr>       
        <c:forEach items="${requestScope.listCompanySum}" var="listSum" varStatus="status">
        <c:if test='${listCompanyList.companyCategory == listSum.companyCategory}'>
            <c:set var="orderQySum" value="0"/>
            <c:set var="orderPriceSum" value="0"/>
            <c:set var="orderCnt" value="0"/>
	        <c:forEach items="${requestScope.enterpriseOrderExcelList}" var="list" varStatus="status">
	            <c:if test='${listSum.companyCategory == list.companyCategory}'>
	            <c:if test='${listSum.orderStat == list.orderStat}'>
	            <c:set var="orderQySum" value="${orderQySum + list.orderQy}"/>
                <c:set var="orderPriceSum" value="${orderPriceSum + list.originalSumPrice}"/>
                <c:set var="orderCnt" value="${orderCnt+1}"/>
	            <tr height='55'>
	                <td style="vertical-align: middle;" align='center' width='50'>
	                    <img src='<c:out value="${hostURL}"/><c:out value="${titleImgPath}"/>/<c:out value="${list.titleImageFile}"/>' width='50' height='50'/>
	                </td>
	                <td>[<c:out value="${list.brandNm}"/>] <b><c:out value="${list.product}"/></b> (<c:out value="${list.orderOption}"/>)
	                </td>
	                <td><c:out value="${list.orderQy}"/></td>
	                <td><c:out value="${list.originalPrice}"/></td>
	                <td><c:out value="${list.originalSumPrice}"/></td>
	                <td><c:out value="${list.receiver}"/>/<c:out value="${list.deliverType}"/>/<c:out value="${list.receiverHp}"/></td>
	                <td><b>[<c:out value="${list.deliverMemo}"/>]</b> <c:out value="${list.managerMemo}"/></td>                
	            </tr>
	            </c:if>
	            </c:if>
	        </c:forEach>
	        <tr style="background-color:gray">
	           <td></td>
	           <td><c:out value="${listSum.orderStatName}"/>계</td>
	           <td></td>
	           <td>${orderCnt}건 ${orderQySum}개</td>
	           <td>${orderPriceSum}원</td>
	           <td></td>
	           <td></td>
	        </tr>
        </c:if>
        </c:forEach>
        <tr><td colspan="7"></td></tr>
    </table>
    </c:forEach>
</body>
</html>




