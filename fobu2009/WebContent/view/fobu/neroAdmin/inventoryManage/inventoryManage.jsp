<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>::::::::: 네로 관리자페이지 입니다 :::::::::</title>
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<link type="text/css" href="/css/nero/css.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/jquery.alphanumeric.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script language="javascript">

var frm = null;
var trIndex = 1;
//로딩

$(function() {
	
	frm = document.all.inventoryManageFrm;
	
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



function statSave(){	
	var orderSeqStrTmp = frm.orderSeqStr.value;
	var orderStatStrTmp = frm.orderStatStr.value;
	
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"orderSeqStr": orderSeqStrTmp,
			"orderStatStr": orderStatStrTmp
	    },
	    dataType: "json",
	    url:"/admin/orderManage/saveStat.action",
	    success:function(data, status) {
	    },
	    error:function(request, status) {
	        alert(status);
	    },
	    complete:function(xhr, textStatus) {
	    	search(frm.pageNumTmp.value);  
	    }
	});	
	
}

function ajaxPageSplit(num) {
	frm.pageNumTmp.value = num;
	search(num);
}


function search(pageNum, eqNum){
	
	var startDay = frm.startDay.value;
	var endDay = frm.endDay.value;
	var saleType = frm.saleType.value;
	var searchType = frm.searchType.value;
	var searchText = frm.searchText.value;

	var productName = "";
	var barcode = "";
	
	if(searchType == "productName"){
		productName = searchText;
	}else{
		barcode = searchText;
	}
	var listScale = $("#listScale").val();
	
	
	$.ajax({
		
        type:"POST",
        cache: false,
        data:{
			"startDay": startDay,
			"endDay": endDay,
			"pageNum": pageNum,
			"listScale": listScale,
			"saleType" : saleType,
			"productName":productName,
			"barcode" : barcode 
        },
        dataType: "json",
        url:"/neroAdmin/inventoryManageManage/init.action",
        beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
        success:function(data, status) {
			var c = "";
			
			var cHeader = "<tr>"
				+"<td width='110' align='center' bgcolor='e7e7e7' class='tx12B'>거래처</td>"
				+"<td width='110' align='center' bgcolor='e7e7e7' class='tx12B'>바코드</td>"
				+"<td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>소비자가</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>재고</td>"
				//+"<td width='90' align='center' bgcolor='e7e7e7' class='tx12B'>등록일</td>"
				+"<td width='90' align='center' bgcolor='e7e7e7' class='tx12B'>최종입고일</td>"
				+"<td width='90' align='center' bgcolor='e7e7e7' class='tx12B'>최종출고일</td>"	          
				+"</tr>";
			var a = 1;  

			if(data.inventoryManageList.length == 0){
            	c = "<tr><td colspan='9' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>";
          		$("#search_inventoryManage").html(cHeader+c);
          		
            }else{
                
	            $.each(data.inventoryManageList, function() {
	                 
	            	c += "<tr onclick='rowSelect(this, \""+this.seq+"\");' bgcolor='#FFFFFF' style=cursor:hand;>"
	                +"<td align='center' bgcolor='#FFFFFF'>"+this.companyName+"</td>"
	                +"<td align='center' bgcolor='#FFFFFF'>"+this.productBarcode+"</td>"
	                +"<td align='left' bgcolor='#FFFFFF'>"+this.productName+"</td>"
	                +"<td align='right' bgcolor='#FFFFFF'>"+commify(this.productPrice)+"</td>"
	                +"<td align='right' bgcolor='#FFFFFF'>"+commify(this.inventoryCnt)+"</td>"
	                //+"<td align='center' bgcolor='#FFFFFF'>"+this.createDate+"</td>"
	                +"<td align='center' bgcolor='#FFFFFF'>"+this.createDt+"</td>"
	                +"<td align='center' bgcolor='#FFFFFF'>"+this.inventoryDate+"</td>"
	      			+"</tr>";
	            	
	            	a++;
	            });
	            $("#search_inventoryManage").html(cHeader+c);
            }
            var totalPage = Math.ceil(parseInt(data.inventoryManageCount)/parseInt(listScale));
            $("#spanCount").empty().html("전체 "+data.inventoryManageCount+" 개 : "+pageNum+" / "+totalPage+" 페이지");                     
            $("#page").empty().html(data.pageSplit);                      
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	closeBlockUI();
        	var num = 1;
        	if(eqNum != null && eqNum != ""){
        		num = eqNum;
        	}
        	$("#search_inventoryManage tr:eq("+num+")").click(); 
        	//frm.checkAllA.checked = false;
        	//frm.checkAllB.checked = false;    	
        }
	});
}

function rowSelect(obj, seq){
	trIndex = $("#search_inventoryManage tr").index(obj);
	$("#search_inventoryManage tr").css("backgroundColor","#FFFFFF");
	obj.style.backgroundColor="#e0eeee";
	
}


//간격조절 스트립트 끝
		
</script>
</head>
<body>
<form name="inventoryManageFrm" method="post" onsubmit="return false">
<input type="hidden" name="pageNumTmp" value="1">
<table width="100%" height="80" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="top" background="/images/nero/top_bg.gif"><table width="1000" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="30">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td width="330" height="40" align="center"><a href="/neroAdmin/inventoryManage/inventoryManage.html" class="white">제품관리</a></td>
        <td width="330" align="center"><a href="/neroAdmin/productInventory/productInventory.html" class="white">품목별 입출고관리</a></td>
        <td width="330" align="center"><a href="/neroAdmin/companyInventory/companyInventory.html" class="white">거래처별 입출고관리</a></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" background="/images/nero/osb_t.gif"><table width="1170" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width=280>
                      시작일 <input style="width:30%;" type="text" name="startDay" id="datepicker" readonly>
          ~
                      종료일 <input style="width:30%;" type="text" name="endDay" id="datepicker2" readonly>
        </td>
        <td width="387" align="right">
          	<select name="saleType">
              <option value="Y">판매</option>
              <option value="N">품절</option>
              <option value="">전체</option>
            </select>
          	<select name="searchType">
	            <option value="">전체검색</option>
	            <option value="productName">제품명</option>
	            <option value="barcode">바코드</option>
            </select>
            <input name="searchText" type="text" size="20" />
        </td>
        <td width="149" align="left"><a href="javascript:search(1);"><img src="/images/nero/btn_search.gif" /></a><a href="#"> <img src="/images/nero/tb_excel.gif" /></a></td>
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
    </table></td>
  </tr>
  <tr>
    <td align="center" background="/images/nero/osb_m.gif"><!--iframe start -->
	  <table  width="1170" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_inventoryManage">
	  </table>
      <table width="1170" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center">
          	<div class="page_wrap">
				<div class="page" id="page" >
				</div>
			</div>
          </td>
        </tr>
      </table>
    <!--iframe end -->    </td>
  </tr>
  <tr>
    <td><img src="/images/nero/osb_b.gif" width="1200" height="27" /></td>
  </tr>
</table>
</form>
</body>
</html>
