<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" %>
<%
    response.setHeader("Content-Type","application/vnd.ms-xls");
    response.setHeader("Content-Disposition", "attachment; filename=accountExcel.xls");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
    <table id="accountExcel_list" border="1" cellspacing='0' cellpadding='0' align="center">
        <c:forEach items="${requestScope.accountStatList}" var="listStat" varStatus="status">
        <tr style="background-color:yellow; font-size: 13pt"><td colspan="15"><b><c:out value="${listStat.orderStat}"/></b></td>
        </tr>
        <tr>
            <td>거래처명</td>
            <td>업체명</td>
            <td>상태</td>
            <td>상품명</td>
            <td>수량</td>
            <td>공급단가</td>
            <td>추가금</td>
            <td>공급합계</td>
            <td>택배형태</td>
            <td>배송비</td>
            <td>추가배송비</td>
            <td>수령자명</td>           
            <td>핸드폰번호</td>
            <td>관리자메모</td>
            <td>주문일</td>
        </tr>
        <c:set var="orderQySum" value="0"/>
        <c:set var="familyPriceSum" value="0"/>
        <c:set var="orderCnt" value="0"/>
        <c:forEach items="${requestScope.accountExcelList}" var="list" varStatus="status">
          <c:if test='${listStat.orderStatCode == list.orderStatCode}'>
            <c:set var="orderQySum" value="${orderQySum + list.orderQy}"/>
            <c:set var="familyPriceSum" value="${familyPriceSum + list.familyPriceSum}"/>
            <c:set var="orderCnt" value="${orderCnt+1}"/>
              <tr height='55'>
                <td><c:out value="${list.companyName}"/></td>
                <td><c:out value="${list.shopId}"/></td>
                <td><c:out value="${list.orderStat}"/></td>
                <td><c:out value="${list.product}"/></td>
                <td><c:out value="${list.orderQy}"/></td>
                <td><c:out value="${list.familyPrice}"/></td>
                <td><c:out value="${list.addPrice}"/></td>
                <td><c:out value="${list.familyPriceSum}"/></td>
                <td><c:out value="${list.deliverType}"/></td>
                <td><c:out value="${list.deliverPrice}"/></td>
                <td><c:out value="${list.addDeliverPrice}"/></td>
                <td><c:out value="${list.receiver}"/></td>
                <td><c:out value="${list.receiverHp}"/></td>
                <td><c:out value="${list.managerMemo}"/></td>
                <td><c:out value="${list.collectDt}"/></td>
            </tr>
          </c:if>
        </c:forEach>
              <tr style="background-color:gray">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>${orderCnt}건 ${orderQySum}개</td>
                <td></td>
                <td>${familyPriceSum}원</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr><td colspan="15"></td></tr>
        </c:forEach>
    </table>
</body>
</html>