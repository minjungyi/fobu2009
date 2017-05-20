<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>
   <link rel="stylesheet" type="text/css" href="/AX-1-3-2/css/default_common.css" />
	<link rel="stylesheet" type="text/css" href="/AX-1-3-2/_AXJ/ui/default/AXJ.css" />
	
	<link rel="stylesheet" type="text/css" href="/AX-1-3-2/_AXJ/ui/default/AXButton.css" />
	<link rel="stylesheet" type="text/css" href="/AX-1-3-2/_AXJ/ui/default/AXSelect.css" />
	<link rel="stylesheet" type="text/css" href="/AX-1-3-2/_AXJ/ui/default/AXGrid.css" />
	<link rel="stylesheet" type="text/css" href="/AX-1-3-2/_AXJ/ui/default/AXInput.css" />
	<link rel="stylesheet" type="text/css" href="/AX-1-3-2/_AXJ/ui/default/AXTabs.css" />
	
	<script type="text/javascript" src="/AX-1-3-2/_AXJ/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="/AX-1-3-2/_AXJ/lib/AXJ.js"></script>
	<script type="text/javascript" src="/AX-1-3-2/_AXJ/lib/AXInput.js"></script>
	<script type="text/javascript" src="/AX-1-3-2/_AXJ/lib/AXSelect.js"></script>
	<script type="text/javascript" src="/AX-1-3-2/_AXJ/lib/AXGrid.js"></script>
	<script type="text/javascript" src="/AX-1-3-2/_AXJ/lib/AXCodeView.js"></script>
<script language="javascript">
var frm = null;
var myGrid = new AXGrid();
var itemSum = 0;
var fnObj = {
		getColGroup: function(){
			return [
				{key:"collectDt", label:"날짜", width:"100"},
				{key:"seqCnt", label:"주문수", width:"100", align:"right", formatter:"money"},
				{key:"originalPrice", label:"원가", width:"100", align:"right", formatter:"money"},
				{key:"familyPrice", label:"매입금액", width:"100", align:"right", formatter:"money"},
				{key:"orderPrice", label:"판매금액", width:"100", align:"right", formatter:"money"},
				{key:"deliverPrice", label:"배송비", width:"100", align:"right", formatter:"money"},
				{key:"addDeliverPrice", label:"추가배송비", width:"100", align:"right", formatter:"money"},
				{key:"marketPrice", label:"마켓수수료", width:"100", align:"right", formatter:"money"},
				{key:"marginPrice", label:"마진률", width:"100", align:"right", formatter:"money"},
				{key:"marginPrice", label:"마진금액", width:"100", align:"right", formatter:"money"}
				];
		},
		pageStart: function(){
			AXCode.bind(); // 소스보기

			myGrid.setConfig({
				targetID : "AXGridTarget",
				//sort:false, 정렬을 원하지 않을 경우 (tip 
				fitToWidth:true, // 너비에 자동 맞춤
				colGroup : fnObj.getColGroup(),
				colHeadAlign: "center", // 헤드의 기본 정렬 값 ( colHeadAlign 을 지정하면 colGroup 에서 정의한 정렬이 무시되고 colHeadAlign : false 이거나 없으면 colGroup 에서 정의한 속성이 적용됩니다.
				body : {
					onclick: function(){
						toast.push(Object.toJSON({index:this.index, r:this.r, c:this.c, item:this.item}));
						//alert(this.list);
						//alert(this.page);
					},
					/* ondblclick 선언하면 onclick 이벤트가 0.25 초 지연 발생 됩니다. 주의 하시기 바람니다. */
					ondblclick: function(){
						toast.push("더블클릭");
						//toast.push(Object.toJSON({index:this.index, r:this.r, c:this.c, item:this.item}));
						//alert(this.list);
						//alert(this.page);
					},
					addClass: function(){
						// red, green, blue, yellow
						/*
						if(this.index % 2 == 0){
							return "green";
						}else{
							return "red";
						}
						*/
					}
				},
				page: {
                    paging: false
                }
			});
			
		}
	};
	//로딩

$(function() {	
    setTimeout(fnObj.pageStart, 1);	
});

function ajaxPageSplit(num) {
	frm.pageNumTmp.value = num;
	search(num);
}


function search(pageNum){
	frm = document.all.totalOrderFrm;
	var siteCode = frm.siteCode.value;
	var startDay = frm.startDay.value;
	var endDay = frm.endDay.value;
	var companyCategory = frm.companyCategory.value;
	var shopId = frm.shopId.value;
	//alert(nameSel);
	var listScale = $("#listScale").val();
	
	var userId = "<%= userId %>";
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
        url:"/admin/statisticsManage/init.action",
        beforeSend:function(xhr) {
			//showMsg("<font size=2>로딩중입니다...</font>");
		},
        success:function(data, status) {
        	myGrid.setList(data.statisticsList); //Array 
           
                      
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	//closeBlockUI();
        	   	
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
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 월별통계</td>
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
	          <select name="shopId" id="shopId">
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
<table width="1200" border="0" align="center" cellpadding="1" cellspacing="1">
	<div id="AXGridTarget" style="height:800px;"></div>
</table>


</form>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end-->	
