<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>

<script language="javascript">

var frm = null;
//로딩

$(function() {
	frm = document.all.operationBbsFrm;
	
	$('#datepicker').datepicker({
		changeMonth: true,
		changeYear: true,
		yearRange: '2008:2020'
	});		

	$('#datepicker2').datepicker({
		changeMonth: true,
		changeYear: true,
		yearRange: '2008:2020'
	});		
    var userIdTmp = "<%= loginId %>";

   // $("#shopId > option[value="+userIdTmp+"]").attr("selected", "true");
	var now = new Date();
    var year= now.getFullYear();
    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		
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
	search(1);
	
	
});

function ajaxPageSplit(num) {
	frm.pageNumTmp.value = num;
	search(num);
}


function search(pageNum){
	
	var startDay = frm.startDay.value;
	var endDay = frm.endDay.value;
	var typeCode = frm.typeCode.value;
	
	var listScale = $("#listScale").val();
	
	
	$.ajax({
		
        type:"POST",
        cache: false,
        data:{
			"startDay": startDay,
			"endDay": endDay,
			"typeCode": typeCode,
			"pageNum": pageNum,
			"listScale": listScale
        },
        dataType: "json",
        url:"/admin/operationBbs/init.action",
        beforeSend:function(xhr) {
			showMsg("<font size=2>로딩중입니다...</font>");
		},
        success:function(data, status) {
			//$("#page").empty();
			$("#search_bbs tr").remove();
			var c = "";
			
			var cHeader = "<tr>"
				+"<td width='100' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>번호</td>"
				+"<td align='center' bgcolor='e7e7e7' class='tx12B'>제목</td>"
				+"<td width='150' align='center' bgcolor='e7e7e7' class='tx12B'>작성일자</td>"
				+"<td width='200' align='center' bgcolor='e7e7e7' class='tx12B'>작성자</td>"
				+"</tr>";
			$("#search_bbs").append(cHeader);
			var a = 1; 
			
			if(data.operationBbsList.length == 0){
            	c = "<tr><td colspan='5' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>";
          		$("#search_bbs").append(c);
            }else{
                
	            $.each(data.operationBbsList, function() {
	            	//var value = parseInt(this.marginPrice) / (parseInt(this.orderPrice));
	               var reImg = "";
	               for(var i =0; i < this.lvl; i++){
	            	   reImg += "&nbsp;[RE]";
	               }
	               c = "<tr onclick='rowSelect(this, \""+this.idx+"\");' bgcolor='#FFFFFF' style=cursor:hand;>"
	      			  +"<td height='23' align='center'>"+a+"</td>"
	      			  +"<td align='left' ><a href='/admin/bbs/bbsDetail.html?idx="+this.idx+"&typeCode=<c:out value="${typeCode}"/>'>"
	      			  +reImg+this.title+"</a></td>"
	      			  +"<td align='center' >"+this.createDt+"</td>"
	      			  +"<td align='center' >"+this.creater+"</td>"
	      			  +"</tr>";
	            	$("#search_bbs").append(c);
	            	a++;
	            });
            }
            var totalPage = Math.ceil(parseInt(data.operationBbsCount)/parseInt(listScale));
            $("#spanCount").empty().append("전체 "+data.operationBbsCount+" 개 : "+pageNum+" / "+totalPage+" 페이지")
                     
            $("#page").empty().append(data.pageSplit);
                      
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	closeBlockUI();
        	$("#search_bbs tr:eq(1)").click();      	
        }
	});
}

function rowSelect(obj, seq){
	$("#search_bbs tr").css("backgroundColor","#FFFFFF");
	obj.style.backgroundColor="#e0eeee";
	
}

function onNewBBS(){
	var typeCodeTmp = frm.typeCode.value;
	location.href = "/admin/operationBbs/operationBbsNew.html?typeCode="+typeCodeTmp;	
}

//간격조절 스트립트 끝
		
</script>
<form name="operationBbsFrm" method="post" onsubmit="return false">
<input type="hidden" name="pageNumTmp" value="1">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">
    	▣ 작업요청게시판
    </td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" background="/images/bsearch_bg.gif">
    	<table width="1150" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	      	<td width=280>
	                      시작일 <input style="width:30%;" type="text" name="startDay" id="datepicker" readonly>
	          ~
	                      종료일 <input style="width:30%;" type="text" name="endDay" id="datepicker2" readonly>
	        </td>
	        <td align="left">&nbsp;&nbsp;처리상태
	          <select name="select7">
		          <option>전체</option>
		          <option>완료</option>
		          <option>미처리</option>
	          </select>&nbsp;&nbsp;
	          작업자
	          <select name="select8">
		          <option>전체</option>
		          <option>조영선</option>
		          <option>민정화</option>
		          <option>민정호</option>
		          <option>민정이</option>
		          <option>류헌열</option>
	          </select>&nbsp;&nbsp;
	          <select name="select10">
	          <option>전체</option>
	          <option>작성자</option>
	          <option>제목</option>
	          <option>내용</option>
	                </select>
	          <input name="textfield" type="text" size="40"></td>
	        <td align="right">
	        	<a href="javascript:search(1);"><img src="/images/button/btn_search.gif"></a>
	        	&nbsp;
	        	<span name="spanCount" id="spanCount"></span>        
	        	<select name="listScale" id="listScale">
		            <option value="20">20</option>
		            <option value="50">50</option>
		            <option value="100">100</option>
		            <option value="200">200</option>
	           	</select>
	        </td>
	      </tr>
    	</table>
    </td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="10" valign="bottom"></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_bbs">
</table>

<div class="page_wrap">
	<div class="page" id="page" >
	</div>
</div><!-- page_wrap -->
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="40" align="right" class="tx14B" style="padding-left:10px">
			<input type="button" width="80px" style="cursor:pointer;" value="신규" onclick="onNewBBS();"/>
		</td>
	</tr>
</table>
<input type='hidden' name='typeCode' value='<c:out value="${typeCode}"/>'>
</form>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->	


















<!-- table width="1200" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
  <tr>
    <td width="40" height="23" align="center" bgcolor="e7e7e7" class="tx12B">순번</td>
    <td width="90" align="center" bgcolor="e7e7e7" class="tx12B">등록일</td>
    <td width="90" align="center" bgcolor="e7e7e7" class="tx12B">완료일</td>
    <td width="80" align="center" bgcolor="e7e7e7" class="tx12B">작성자</td>
    <td width="80" align="center" bgcolor="e7e7e7" class="tx12B">작업자</td>
    <td width="80" align="center" bgcolor="e7e7e7" class="tx12B">처리상태</td>
    <td align="center" bgcolor="e7e7e7" class="tx12B">제목</td>
    <td width="28" align="center" bgcolor="e7e7e7" class="tx12B">hit</td>
  </tr>
  <tr>
    <td height="23" align="center" bgcolor="#FFFFFF">1</td>
    <td align="center" bgcolor="#FFFFFF">11.06.09 03:03</td>
    <td align="center" bgcolor="#FFFFFF">11.06.09 03:03</td>
    <td align="center" bgcolor="#FFFFFF">홍길동</td>
    <td align="center" bgcolor="#FFFFFF">홍길동</td>
    <td align="center" bgcolor="#FFFFFF">완료</td>
    <td bgcolor="#FFFFFF">관리자 주문관리 에러 수정</td>
    <td align="center" bgcolor="#FFFFFF">1</td>
  </tr-->
  