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
	
	var siteCode = frm.siteCode.value;
	var startDay = frm.startDay.value;
	var endDay = frm.endDay.value;
	var companyCategory = frm.companyCategory.value;
	var shopId = frm.shopId.value;
	//alert(nameSel);
	var listScale = $("#listScale").val();
	
	
	$.ajax({
		
        type:"POST",
        cache: false,
        data:{
			"orderStat": "",
			"siteCode": siteCode,
			"startDay": startDay,
			"endDay": endDay,
			"pageNum": pageNum,
			"listScale": listScale,
			"companyCategory":companyCategory,
			"shopId" : shopId
        },
        dataType: "json",
        url:"/admin/statisticsManage/initProduct.action",
        beforeSend:function(xhr) {
			showMsg("<font size=2>로딩중입니다...</font>");
		},
        success:function(data, status) {
			//$("#page").empty();
			$("#view_order_detail tr").remove();
			$("#search_total_order tr").remove();
			var c = "";
			
			var cHeader = "<tr>"
				+"<td width='200' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>거래처명</td>"
				+"<td width='400' align='center' bgcolor='e7e7e7' class='tx12B'>상품명</td>"
				+"<td width='100' align='center' bgcolor='e7e7e7' class='tx12B'>주문건수</td>"
				+"<td width='100' align='center' bgcolor='e7e7e7' class='tx12B'>주문수량</td>"
				+"<td width='200' align='center' bgcolor='e7e7e7' class='tx12B'>원가</td>"
				+"<td width='200' align='center' bgcolor='e7e7e7' class='tx12B'>판매된 총가격</td>";
				+"</tr>";
			$("#search_total_order").append(cHeader);
			var a = 1;  

			if(data.statisticsList.length == 0){
            	c = "<tr><td colspan='17' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>";
          		$("#search_total_order").append(c);
          		$("#view_order_detail tr").remove();
            }else{
                
	            $.each(data.statisticsList, function() {
	               c = "<tr onclick='rowSelect(this, \""+this.seq+"\");' bgcolor='#FFFFFF' style=cursor:hand;>"
	      			  +"<td height='23' align='center'>"+this.companyName+"</td>"
	      			  +"<td align='left' >"+this.product+"</td>"
	      			  +"<td align='center' >"+commify(this.productCnt)+"</td>"
	      			  +"<td align='center' >"+commify(this.orderQy)+"</td>"
	      			  +"<td align='center' >"+commify(this.familyPrice)+"</td>"
	      			  +"<td align='center' >"+commify(this.orderPrice)+"</td>"      			  
	      			  +"</tr>";
	            	$("#search_total_order").append(c);
	            	a++;
	            });
            }
            var totalPage = Math.ceil(parseInt(data.statisticsProductCount)/parseInt(listScale));
            $("#spanCount").empty().append("전체 "+data.statisticsProductCount+" 개 : "+pageNum+" / "+totalPage+" 페이지")
                     
            $("#page").empty().append(data.pageSplit);
                      
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
//간격조절 스트립트 끝
		
</script>
<form name="totalOrderFrm" method="post" onsubmit="return false">
<input type="hidden" name="orderSeqStr">
<input type="hidden" name="orderStatStr"> 
<input type="hidden" name="pageNumTmp" value="1">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 상품별통계</td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" background="/images/osb_t.gif">
	    <table width="1150" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width=280>
	                      시작일 <input style="width:30%;" type="text" name="startDay" id="datepicker" readonly>
	          ~
	                      종료일 <input style="width:30%;" type="text" name="endDay" id="datepicker2" readonly>
	        </td>
	        <td width="390">
	          <select name="companyCategory">
	          		<option value="">거래처</option>
		          <c:forEach items="${requestScope.listCompany}" var="listCompanyList">
		        	<option value="${listCompanyList.seq}">
		        	${listCompanyList.company }</option>
		          </c:forEach>
	          </select>
	          <select name="shopId">
	            <option value="">업체</option>
	            <option value="fobu">포부</option>
	            <option value="choco">초코</option>
	            <option value="min">민트윈</option>
	            <option value="good">굿파더</option>
	            <option value="twin">트윈몰</option>     
	            <option value="sun">선플라워</option>    
	          </select>
	          <select name="siteCode" id="siteCode">
	            <option value="">주문경로</option>				
	            <option value="gmk">지마켓</option>
	            <option value="aut">옥션</option>
	            <option value="cyw">11번가</option>
	            <option value="itp">인터파크</option>
	            <option value="shn">샵N</option>
	            <option value="dir">직거래</option>
	            <option value="shop">사이트</option>
	          </select>
	        </td>
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
