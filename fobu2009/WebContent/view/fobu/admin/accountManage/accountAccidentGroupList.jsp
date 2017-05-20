<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>

<script language="javascript">

var frm = null;
//로딩

$(function() {
	
	frm = document.all.totalOrderFrm;
	
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
	var now = new Date();
    var year= now.getFullYear();
    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		
	//$('#datepicker').val(year+"-"+mon+"-"+day);
	search(1);
	
	
});

function ajaxPageSplit(num) {
	frm.pageNumTmp.value = num;
	search(num);
}


function search(pageNum){	
	
	var startDay = frm.startDay.value;
	var endDay = frm.endDay.value;
	
	var listScale = $("#listScale").val();
	
	
	$.ajax({
		
        type:"POST",
        cache: false,
        data:{			
			"startDay": startDay,
			"endDay": endDay,
			"pageNum": pageNum,
			"listScale": listScale
        },
        dataType: "json",
        url:"/admin/accountManage/initAccidentGroup.action",
        beforeSend:function(xhr) {
			showMsg("<font size=2>로딩중입니다...</font>");
		},
        success:function(data, status) {
			var c = "";
			var cHeader = "<tr>"
				+"<td align='center' bgcolor='e7e7e7' class='tx12B'>정산명칭</td>"
				+"<td width='200' align='center' bgcolor='e7e7e7' class='tx12B'>정산일</td>"
				+"<td width='200' align='center' bgcolor='e7e7e7' class='tx12B'>정산자</td>"
				+"<td width='200' align='center' bgcolor='e7e7e7' class='tx12B'>엑셀다운</td>"
				+"</tr>";
			var a = 1;  
			
			if(data.accountGroupList.length == 0){
          		c = "<tr><td colspan='17' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>";
          		$("#search_total_order").html(cHeader+c);
            }else{
                
	            $.each(data.accountGroupList, function() {
	                c += "<tr onclick='rowSelect(this, \""+this.accountSeq+"\");' bgcolor='#FFFFFF' style=cursor:hand;>"
	                  +"<td align='center' >"+this.accountName+" 정산내역</td>"
	      			  +"<td align='center' >"+this.createDt+"</td>"
	      			  +"<td align='center' >"+this.creator+"</td>"
	      			  +"<td align='center' ><img src='/images/bn_excel.gif' onclick='accountExcelDown("+this.accountSeq+");' style='cursor:pointer'></td>"
	      			  +"</tr>";
	            	a++;
	            });
	            $("#search_total_order").html(cHeader+c);
            }
            var totalPage = Math.ceil(parseInt(data.accountGroupCount)/parseInt(listScale)); 
            $("#spanCount").empty().html("<font color='red'>Total "+commify(data.accountGroupCount)+"</font> : "+commify(pageNum)+" / "+commify(totalPage)+" Page");
            $("#page").empty().html(data.pageSplit);  
                       
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	closeBlockUI();
        	$("#search_total_order tr:eq(1)").click(); 
        	$(".price").each(function(){
        		$(this).toPrice();
        	});        	
        }
	});
}

function rowSelect(obj, seq){
	$("#search_total_order tr").css("backgroundColor","#FFFFFF");
	obj.style.backgroundColor="#e0eeee";
	
}

function accountExcelDown(seq){
	
	var paramData = "accountSeq="+seq;
	document.target="_blank";
	document.location.href = "/admin/excel/accountAccident_excellist.html?"+paramData;
}


//간격조절 스트립트 끝
		
</script>
<form name="totalOrderFrm" method="post" onsubmit="return false">
<input type="hidden" name="orderSeqStr">
<input type="hidden" name="orderStatStr"> 
<input type="hidden" name="pageNumTmp" value="1">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 정산 후 변경 그룹목록</td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" background="/images/osb_t.gif">
	    <table width="1150" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width=331>
	                      시작일 <input style="width:30%;" type="text" name="startDay" id="datepicker" readonly>
	          ~
	                      종료일 <input style="width:30%;" type="text" name="endDay" id="datepicker2" readonly>
	        </td>
	        <td width="559">	          
	        </td>
	        <td width="55" align="center">
	        	<a href="javascript:search(1);"><img src="/images/button/btn_search.gif"></a>
	        </td>
	        <td align="right">
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
  <tr>
    <td><img src="/images/osb_b.gif" width="1200" height="27"></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_total_order">
</table>

<div class="page_wrap">
	<div class="page" id="page" >
	</div>
</div><!-- page_wrap -->
</form>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->	
