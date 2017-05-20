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
<form name="operationBbsFrm" method="post" onsubmit="return false">
<input type="hidden" name="pageNumTmp" value="1">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 작업요청게시판</td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="10" valign="bottom"></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
  <tr>
    <td width="20%" height="23" bgcolor="e7e7e7" class="tx12B">요청작업자</td>
    <td bgcolor="#FFFFFF" class="tx12B"><select name="select8">
      <option>선택</option>
      <option>조영선</option>
      <option>민정화</option>
      <option>민정호</option>
      <option>민정이</option>
      <option>류헌열</option>
    </select></td>
    <td width="20%" bgcolor="e7e7e7" class="tx12B">작성자</td>
    <td bgcolor="#FFFFFF" class="tx12B">
	    <select name="select">
	      <option>선택</option>
	      <option>조영선</option>
	      <option>민정화</option>
	      <option>민정호</option>
	      <option>민정이</option>
	      <option>류헌열</option>
	    </select>
    </td>
  </tr>
  <tr>
    <td height="23" bgcolor="e7e7e7" class="tx12B">제목</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tx12B"><input name="textfield" type="text" size="100" /></td>
  </tr>
  <tr>
    <td height="23" bgcolor="e7e7e7" class="tx12B">첨부파일1</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tx12B"><input name="textfield3" type="text" size="100" />
      <a href="#"><img src="/images/button/btn_search1.gif" width="71" height="22" border="0" align="absmiddle"></a></td>
  </tr>
  <tr>
    <td height="23" bgcolor="e7e7e7" class="tx12B">첨부파일2</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tx12B"><input name="textfield4" type="text" size="100" />
      <a href="#"><img src="/images/button/btn_search1.gif" width="71" height="22" border="0" align="absmiddle" /></a></td>
  </tr>
  <tr>
    <td height="23" bgcolor="e7e7e7" class="tx12B">첨부파일3</td>
    <td colspan="3" bgcolor="#FFFFFF" class="tx12B"><input name="textfield5" type="text" size="100" />
      <a href="#"><img src="/images/button/btn_search1.gif" width="71" height="22" border="0" align="absmiddle" /></a></td>
  </tr>
  <tr>
    <td height="23" colspan="4" bgcolor="#FFFFFF"><textarea name="textarea" cols="100" rows="10"></textarea></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" align="center"><a href="#"><img src="/images/button/btn_ok.gif" width="75" height="27" border="0"></a>&nbsp; <a href="#"><img src="/images/button/btn_list.gif" width="75" height="27" border="0"/></a></td>
  </tr>
</table>
</form>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->	

