<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>

<script language="javascript">

var frm = null;
//로딩

$(function() {
	frm = document.all.totalOrderFrm;
	var typeCode = '<c:out value="${typeCode}"/>';
	//alert(typeCode);
	var typeName = "";
	if(typeCode == '0001'){
		typeName = "작업요청게시판";		
	}else if(typeCode == '0002'){
		typeName = "공지사항";
	}else{
		typeName = "";
	}
	$("#pageTitle").empty().html(typeName);
});

function onSaveBBS(){	
	var titleTmp = frm.title.value;
	var contentTmp = frm.content.value;
	var typeCodeTmp = frm.typeCode.value;
	if (confirm("저장하시겠습니까?") == true){ 
		$.ajax({
			type:"POST",
		    cache: false,
		    data:{
				"title": titleTmp,
				"content": contentTmp,
				"lvl": 0,
				"stp": 0,
				"typeCode": typeCodeTmp
		    },
		    dataType: "json",
		    url:"/admin/bbs/insertBbs.action",
		    success:function(data, status) {
		    },
		    error:function(request, status) {
		        alert(status);
		    },
		    complete:function(xhr, textStatus) {
		    	onBBSList();
		    }
		});	
	}
	
}

function onBBSList(){
	var typeCodeTmp = frm.typeCode.value;
	location.href = "/admin/bbs/bbsList.html?typeCode="+typeCodeTmp;
}

//간격조절 스트립트 끝
		
</script>
<form name="totalOrderFrm" method="post" onsubmit="return false">

<input type="hidden" name="pageNumTmp" value="1">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">
    	▣ <span name="pageTitle" id="pageTitle"></span> 신규</td>
  </tr>
  <tr>
    <td height="10"></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_bbs">
	<tr>
		<td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">제목</td>
		<td bgcolor="#FFFFFF">
	  		<input type="text" id="title" name="title" style="width:90%;"/>
		</td>
	</tr>
	<tr>
		<td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">내용</td>
		<td bgcolor="#FFFFFF">
	  		<textArea id="content" name="content" style="width:90%;height:300px"></textArea>
	   </td>
	</tr>
</table>

<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="40" align="right" class="tx14B" style="padding-left:10px">
			<input type="button" width="80px" style="cursor:pointer;" value="목록" onclick="onBBSList();"/>
			<input type="button" width="80px" style="cursor:pointer;" value="저장" onclick="onSaveBBS();"/>
		</td>
	</tr>
</table>
<input type='hidden' name='typeCode' value='<c:out value="${typeCode}"/>'>
</form>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->	
