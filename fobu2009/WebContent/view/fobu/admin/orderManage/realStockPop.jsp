<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>:::::::::  개별 재고 수정:::::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script language="javascript">
var frm = null;
var trIndex = 1;

$(function() {
	frm = document.all.realStockfrm;
	search();
	//alert(opener.$("#search_realstock_order tr:eq(1)").html());
});

function search(){
	var productCode = frm.productCode.value;
	
	$.ajax({
		
        type:"POST",
        cache: false,
        data:{
			"productCode": productCode
        },
        dataType: "json",
        url:"/admin/orderManage/realStockSearch.action",
        beforeSend:function(xhr) {
			showMsg("로딩중입니다...");
		},
        success:function(data, status) {
        	
			var c = "";
			closeBlockUI();   
			var cHeader = "<tr>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>수집</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>주문자</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>수령자</td>"
				+"<td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>옵션</td>"
				+"<td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>상태</td>"
				+"<td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>매입원가</td>"
				+"<td width='50' align='center' bgcolor='e7e7e7' class='tx12B'>업체명</td>"
				+"<td width='30' align='center' bgcolor='e7e7e7' class='tx12B'>수량</td>"
				+"</tr>";  
			var a = 1; 
			var collectDt = "";
			
			if(data.searchRealStockList.length == 0){
            	c = "<tr><td colspan='8' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>";
          		$("#search_realstock_order").html(cHeader+c);
          		
            }else{
            	
	            $.each(data.searchRealStockList, function() {
	            	var bbColor = '#FFFFFF';
	                var ordererTmp = this.orderer;
	                if(this.cnt > 1){
	                	bbColor = '#e1f1c9';
	                }
	                
	            	collectDt = this.collectDt;
	            	
	            	c += "<tr bgcolor='#FFFFFF' style=cursor:hand;>"
	      			  +"<td width='110' height='10' align='center'>"+collectDt+"</td>"
	      			  +"<td width='55' align='center' bgcolor="+bbColor+"><div style='width:55px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'><a href='javascript:packageInfoPopup(\""+this.seq+"\")'>"+this.orderer+"</a></div></td>"
	      			  +"<td width='55' align='center' ><div style='width:55px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'><a href='javascript:onOrderInfoPopup(\""+this.seq+"\")'>"+this.receiver+"</a></div></td>"
	      			  +"<td width='55' align='center' >"+this.orderOption+"</font></td>"	  
	      			  +"<td width='60' align='center' >"+this.orderStat+"</font></td>"	  
	      			  +"<td width='60' align='center' >"+commify(parseInt(this.originalPrice)*parseInt(this.orderQy))+"</td>"
	      			  +"<td width='50' align='center' ><img src='/images/"+this.shopImg+".gif'></td>"
	      			  +"<td width='30' align='right' ><b>"+commify(this.orderQy)+"</b></td>"
	      			 +"</tr>";
	            	a++;
	            });
	            
	            $("#search_realstock_order").html(cHeader+c);
            }                      
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	closeBlockUI();        	
        }
	});
}

function stockSave(){      
    var changeRealStockTmp = frm.changeRealStock.value;
    var rmTmp = frm.rm.value;
    var productCodeTmp = frm.productCode.value;
    var stockOptTmp = frm.stockOpt.value;
        
    $.ajax({
        type:"POST",
        cache: false,
        data:{
            "productCode": productCodeTmp,
            "realStock": changeRealStockTmp,
            "stockOpt":stockOptTmp,
            "rm": rmTmp
        },
        dataType: "json",
        url:"/admin/orderManage/saveRealStock.action",
        success:function(data, status) {
        },
        error:function(request, status) {
            alert(status);
        },
        complete:function(xhr, textStatus) {
            var pp = frm.pageNumPop.value;
            var aa = frm.trIndex.value;
            opener.search(pp, aa);
            self.close();
        }
    }); 
    
}

</script>
</head>
<body bgcolor="4b4b4b">
<form name="realStockfrm" method="post" action="/admin/orderManage/saveRealStock.action">
<input type="hidden" name="pageNumTmp" value="1">
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" valign="bottom" background="">&nbsp;&nbsp;<font color="white" size="5"><b>◎ 재고수정</b></font></td>
  </tr>
</table>
<table width="760" border="7" align="center" cellpadding="15" cellspacing="0" bordercolor="4b4b4b">
  <tr>
    <td bgcolor="#FFFFFF">
    <table width="700" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
      <tr>
        <td width="30%" align="center" bgcolor="e7e7e7" class="tx12B">제품명</td>
        <td width="70%" align="center" bgcolor="#FFFFFF"><c:out value="${product}"/></td>
      </tr>
      <tr>
        <td width="30%" align="center" bgcolor="e7e7e7" class="tx12B">재고/증감</td>
        <td width="70%" align="center" bgcolor="#FFFFFF">
            <span id="realStock"></span> / <input type="text" name="changeRealStock" maxlength="6" onkeypress="onlyNum()" value = "0">
        </td>
        <script>   
        $("#realStock").empty().html(commify(<c:out value="${realStock}"/>));
        </script>
      </tr>
      <tr>
        <td width="30%" align="center" bgcolor="e7e7e7" class="tx12B">재고옵션</td>
        <td width="70%" align="center" bgcolor="#FFFFFF"><input type="text" style="width:95%" name="stockOpt" value="<c:out value='${stockOpt}'/>"></td>
      </tr>
      <tr>
        <td width="30%" align="center" bgcolor="e7e7e7" class="tx12B">비고</td>
        <td width="70%" align="center" bgcolor="#FFFFFF"><input type="text" style="width:95%" name="rm" value=""></td>
      </tr>
    </table>
      <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="40" align="center" class="tx14B" style="padding-left:10px">
            <a href="javascript:stockSave();"><img src="/images/button/btn_ok.gif"></a>&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="javascript:self.close();"><img src="/images/button/btn_can.gif"></a>
        </td>
      </tr>
    </table>
    <table width="760" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_realstock_order">
	</table>
    </td>
  </tr>
</table>
<input type='hidden' name='pageNumPop' value='<c:out value="${pageNumPop}"/>'>
<input type='hidden' name='productCode' value='<c:out value="${productCode}"/>'>
<input type='hidden' name='trIndex' value='<c:out value="${trIndex}"/>'>
</form>
</body>
</html>

