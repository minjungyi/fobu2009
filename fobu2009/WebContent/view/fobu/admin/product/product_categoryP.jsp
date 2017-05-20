<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<title>카테고리 상세</title>

<script language="javascript">
$(function() {
	if(${rtnVal}>0){
		showMsgNClose("카테고리가 저장되었습니다.");
		opener.changeCateBind('${depth}',${category});
		self.close();
	}
});

function save(){
	if($("#codeName").val() == "" || $("#codeName").val() == null){
		showMsgNClose('카테고리명은 필수 입력 사항입니다.');		
		$("#codeName").focus();
		return;
	}

	if($("#depth").val() == "3" && ($("#attrExt2").val() == "" || $("#attrExt2").val() == null)){
		showMsgNClose('오픈마켓 마진율은 필수 입력 사항입니다.');
		$("#attrExt2").focus();
		return;
	}
	
	var frm = document.categoryPopFrm;

	frm.submit();
}
</script>
</head>
<body>
<form name="categoryPopFrm" method="post" action="/admin/product/product_Category_save.action" >
<input type="hidden" name="category"  id="category" style="width:70%;" value='<c:out value="${listCategory[0].category}"/>' />
<input type="hidden" name="status" id="status" style="width:70%;" value='<c:out value="${listCategory[0].status}"/>' />
<input type="hidden" name="depth" id="depth" style="width:70%;" value='<c:out value="${depth}"/>' />
<table width="440" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B">▣ 카테고리 상세</td>
  </tr>
</table>
<br/>
<div class="div_space"></div>
<table id="sizeOptStockList" width="440" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
	<tr>
		<td height='23' align='center' bgcolor='e7e7e7' class='tx12B' width='200'>카테고리 명</td>
		<td bgcolor='#FFFFFF'>
			<input name="codeName" type="text" id="codeName" style="width:90%;" value='<c:out value="${listCategory[0].codeName}"/>' />
		</td>
	</tr>
	<tr>
		<td height='23' align='center' bgcolor='e7e7e7' class='tx12B' width='200'>카테고리 코드</td>
		<td bgcolor='#FFFFFF'>
			<input name="code" type="text" id="code" style="width:90%;" value='<c:out value="${listCategory[0].code}"/>' readonly />
		</td>
	</tr>
	<tr>
		<td height='23' align='center' bgcolor='e7e7e7' class='tx12B' width='200'>초코몰 카테고리 코드</td>
		<td bgcolor='#FFFFFF'>
			<input name="attrExt4" type="text" id="attrExt4" style="width:90%;" value='<c:out value="${listCategory[0].attrExt4}"/>' />
		</td>
	</tr>
	<tr>
		<td height='23' align='center' bgcolor='e7e7e7' class='tx12B'>오픈마켓 마진율</td>
		<td bgcolor='#FFFFFF'>
			<input name="attrExt2" type="text" id="attrExt2" style="width:90%;" value='<c:out value="${listCategory[0].attrExt2}"/>' />
		</td>
	</tr>
	<tr>
		<td height='23' align='center' bgcolor='e7e7e7' class='tx12B'>순서</td>
		<td bgcolor='#FFFFFF'>
			<input name="sort" type="text" id="sort" style="width:90%;" value='<c:out value="${listCategory[0].sort}"/>' />
		</td>
	</tr>
	<tr>
		<td height='23' align='center' bgcolor='e7e7e7' class='tx12B'>검색약어</td>
		<td bgcolor='#FFFFFF'>
			<input name="attrExt3" type="text" id="attrExt3" style="width:90%;" value='<c:out value="${listCategory[0].attrExt3}"/>' />
		</td>
	</tr>
	<tr>
		<td height='23' align='center' bgcolor='e7e7e7' class='tx12B'>정보공시카테고리</td>
		<td bgcolor='#FFFFFF'>
			<select name="attrExt1" id="attrExt1" >
      			<option value="-1">선택하세요</option>            	
            	<c:forEach var="infoCategoryList" items="${listInfoCategory}">	            	
            		<option value='<c:out value="${infoCategoryList.code}"/>'  <c:if test="${listCategory[0].attrExt1 == infoCategoryList.code}">selected</c:if>>
			        	<c:out value="${infoCategoryList.codeName}" />
			        </option>	            	
		        </c:forEach>
          	</select>			
		</td>
	</tr>
	<tr>
		<td height='23' align='center' bgcolor='e7e7e7' class='tx12B'>사용유무</td>
		<td bgcolor='#FFFFFF'>
			<select style="width:60%; height:20px" name="useYN" id="useYN">
				<option value="Y" <c:if test="${listCategory[0].useYN == 'Y'}">selected</c:if>>사용</option>
				<option value="N" <c:if test="${listCategory[0].useYN == 'N'}">selected</c:if>>사용안함</option>
			</select>
		</td>
	</tr>
</table>
<table border="0" align="center">
 	<tr height="35px">
	 	<td bgcolor='#FFFFFF' style="text-align:center;">
	 		<input type="button" value="저장" onclick="save();">
	 		<input type="button" value="닫기" onclick="window.close();">
	 	</td>
 	</tr>
</table>
</form>
</body>
</html>
