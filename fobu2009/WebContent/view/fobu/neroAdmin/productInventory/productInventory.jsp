<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>::::::::: 네로 관리자페이지 입니다 :::::::::</title>
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<link type="text/css" href="/css/nero/css.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/jquery-ui-1.8.18.custom.min.js" ></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/jquery.alphanumeric.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script language="javascript">

var frm = null;
var trIndex = 1;
//로딩

$(function() {
	
	frm = document.all.productInventoryFrm;
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
	
	productBind();		
});

function productBind(){	
	init('U');
	$('#productCate').empty();
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"saleType": $("#saleType").val(),
			"productName": $("#productSearchName").val()	
	    },
	    dataType: "json",
	    url:"/neroAdmin/productInventory/productList.action",
	    beforeSend:function(xhr) {
			//showMsg("로딩중입니다...");
		},
	    success:function(data, status) {
		    var i = 0;

	    	$.each(data.listProductInfo, function() {
	    		$('#productCate').get(0).options[i] = new Option("["+this.productSeq+"] "+this.productName,this.productSeq);
		    	i++;
	    	});
	    	$("#totalProductCnt").empty().html("총제품수 "+data.listProductInfo.length+"건");   
		},
	    error:function(request, status) {
			//closeBlockUI();
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {	    	 
	    	 //closeBlockUI();
	    	 //$('#productCate').get(0).options[0].attr("selected","true");
	    	 $("#productCate > option[index=0]").attr("selected", "true"); 
	    	 selectProduct($("#productCate > option:selected").val());
	    	 search(1);
	     }
	});		
}

function selectProduct(seq){
	init('U');
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
	    "productSeq" : seq,
		"saleType": $("#saleType").val(),
		"productName": $("#productName").val()
	    },
	    dataType: "json",
	    url:"/neroAdmin/productInventory/productList.action",
	    beforeSend:function(xhr) {
		    
			showMsg("로딩중입니다...");
		},
	    success:function(data, status) {
		    if(data.listProductInfo != null)
		    {   
		    	$("#productName").val(data.listProductInfo[0].productName);
		    	$("#productBarcode").val(data.listProductInfo[0].productBarcode);
		    	$("#productPrice").val(data.listProductInfo[0].productPrice);
		    	$("#createDate").html(data.listProductInfo[0].createDt);
		    	$("#productStock").val(data.listProductInfo[0].productStock);
		    	$("#productSeq").val(data.listProductInfo[0].productSeq);
		    	$("#saleTypeTmp").val(data.listProductInfo[0].saleType);
		    	$("#productStock").empty().html(data.listProductInfo[0].inventoryCnt+"개");
		    }
		},
	    error:function(request, status) {
			closeBlockUI();
	        alert(status);
	    },
	    complete:function(xhr, textStatus) {
	    	closeBlockUI();
	    }
	});	
}

function saveProductInfo(){	
	var initYn = $("#initYn").val();
	var mag = "";
	if(initYn == "I"){
		mag = "신규저장";
	}else{
		mag = "수정";
	}
	if(confirm(mag+"하시겠습니까?")){
		$.ajax({
			type:"POST",
		    cache: false,
		    data:{
			"productName" : $("#productName").val(),
			"productBarcode" : $("#productBarcode").val(),
			"productSeq" : $("#productSeq").val(),
			"saleType" : $("#saleTypeTmp").val(),
			"productPrice" : $("#productPrice").val()
		    },
		    dataType: "json",
		    url:"/neroAdmin/productInventory/saveProductInfo.action",
		    beforeSend:function(xhr) {
		    	if($("input[name='productName']").val()==''){
                    alert('제품명을 입력하세요.');
                    return false;
                }

		    	if($("input[name='productBarcode']").val()==''){
                    alert('제품 바코드를 입혁하세요.');
                    return false;
                }

		    	if($("input[name='productPrice']").val()==''){
                    alert('제품 소비자가를 입력하세요.');
                    return false;
                }
				showMsg("저장중입니다......");
			},
		    success:function(data, status) {
		    	
		    },
		    error:function(request, status) {
		    	closeBlockUI();
		        alert(status);
		    },
		    complete:function(xhr, textStatus) {
		    	closeBlockUI();
		    	productBind();
		    }
		});	
	}
}
//inventorySave

function inventorySave(){	
	
	var companyName = frm.companyCategory.value;
	if($("#saleTypeTmp").val() == "N"){
		alert("품절시 입고/출고내역을 저장하지 못합니다. \n 판매로 수정 후 저장하세요.");
		return;
	}
	if(confirm("입/출고 내역을 저장하시겠습니까?")){
		$.ajax({
			type:"POST",
		    cache: false,
		    data:{
			"inventoryCnt" : $("#productCnt").val(),
			"productPrice" : $("#productPrice").val(),
			"companySeq" : companyName,
			"productSeq" : $("#productSeq").val()
		    },
		    dataType: "json",
		    url:"/neroAdmin/productInventory/saveInventoryInfo.action",
		    beforeSend:function(xhr) {
		    	if(companyName ==''){
                    alert('거래처를 선택하세요.');
                    return false;
                }

		    	if($("input[name='productSeq']").val()==''){
                    alert('제품를 선택하세요.');
                    return false;
                }

		    	if($("input[name='productCnt']").val()==''){
                    alert('입고/출고 수량을 입력하세요.');
                    return false;
                }
		    	
		    	if($("input[name='productCnt']").val()== 0){
                    alert('입고/출고 수량은 0을 입력할 수 없습니다.');
                    return false;
                }
		    	
				showMsg("저장중입니다......");
			},
		    success:function(data, status) {
		    	
		    },
		    error:function(request, status) {
		    	closeBlockUI();
		        alert(status);
		    },
		    complete:function(xhr, textStatus) {
		    	closeBlockUI();
		    	productBind();
		    }
		});	
	}
}

function ajaxPageSplit(num) {
	frm.pageNumTmp.value = num;
	search(num);
}


function search(pageNum, eqNum){
    
    var startDay = frm.startDay.value;
    var endDay = frm.endDay.value;
    var inventoryType = frm.inventoryType.value;
    var searchType = frm.searchType.value;
    var searchText = frm.searchText.value;

    var productName = "";
    var barcode = "";
    selectProduct($("#productCate > option:selected").val());
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
            "inventoryType" : inventoryType,
            "productName":productName,
            "productSeq": $("#productCate > option:selected").val(),
            "barcode" : barcode 
        },
        dataType: "json",
        url:"/neroAdmin/productInventoryManage/init.action",
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
                +"<td width='65' align='center' bgcolor='e7e7e7' class='tx12B'>재고</td>"
                +"<td width='110' align='center' bgcolor='e7e7e7' class='tx12B'>등록일</td>"
                +"<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>수정</td>"
                +"<td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>삭제</td>"              
                +"</tr>";
            var a = 1;  

            if(data.productInventoryList.length == 0){
                c = "<tr><td colspan='9' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>";
                $("#search_productManage").html(cHeader+c);
                
            }else{
                
                $.each(data.productInventoryList, function() {
                     
                    c += "<tr onclick='rowSelect(this, \""+this.seq+"\");' bgcolor='#FFFFFF' style=cursor:hand;>"
                    +"<td align='center' bgcolor='#FFFFFF'>"+this.companyName+"</td>"
                    +"<td align='center' bgcolor='#FFFFFF'>"+this.productBarcode+"</td>"
                    +"<td align='left' bgcolor='#FFFFFF'>"+this.productName+"</td>"
                    +"<td align='right' bgcolor='#FFFFFF'>"+commify(this.productPrice)+"</td>"
                    +"<td align='right' bgcolor='#FFFFFF'>"+commify(this.inventoryCnt)+"</td>"
                    //+"<td align='center' bgcolor='#FFFFFF'>"+this.createDate+"</td>"
                    +"<td align='center' bgcolor='#FFFFFF'>"+this.createDt+"</td>"
                    +"<td align='center' bgcolor='#FFFFFF'><a href='javascript:viewDialogOpen(\""+this.inventorySeq+"\", \""+this.productPrice+"\", \""+this.inventoryCnt+"\")'><img src='/images/nero/s_button_mo.gif' /></a></td>"
                    +"<td align='center' bgcolor='#FFFFFF'><a href='javascript:delInventory(\""+this.inventorySeq+"\")'><img src='/images/nero/s_button_de.gif' /></a></td>"
                    +"</tr>";
                    
                    a++;
                });
                $("#search_productManage").html(cHeader+c);
            }
            var totalPage = Math.ceil(parseInt(data.productInventoryCount)/parseInt(listScale));
            $("#spanCount").empty().html("전체 "+data.productInventoryCount+" 개 : "+pageNum+" / "+totalPage+" 페이지");                     
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
            $("#search_productManage tr:eq("+num+")").click(); 
            //frm.checkAllA.checked = false;
            //frm.checkAllB.checked = false;        
        }
    });
}

function rowSelect(obj, seq){
    trIndex = $("#search_productManage tr").index(obj);
    $("#search_productManage tr").css("backgroundColor","#FFFFFF");
    obj.style.backgroundColor="#e0eeee";
    
}

function init(arg){
	//$(":text").val("");
	$("#initYn").val(arg);
	$("#productName").val("");
	$("#productBarcode").val("");
	$("#productPrice").val("");
	$("#createDate").html("");
	$("#productStock").val("");
	$("#productSeq").val("");
}

function viewDialogOpen(inventorySeq, productPrice, inventoryCnt){
    $("#pop_inventorySeq").val(inventorySeq);
    $("#pop_price").val(productPrice);
    $("#pop_qty").val(inventoryCnt);
       
    $("#viewDialog").dialog({
        modal:true, 
        width:250,
        title:"Detail Update"
    });
}

function saveDialog(){ 
    
    if(confirm("수정하시겠습니까?")){
        $.ajax({
            type:"POST",
            cache: false,
            data:{
            "productPrice" : $("#pop_price").val(),
            "inventoryCnt" : $("#pop_qty").val(),
            "inventorySeq" : $("#pop_inventorySeq").val()
            },
            dataType: "json",
            url:"/neroAdmin/productInventory/updateInventoryInfo.action",
            beforeSend:function(xhr) {
                if($("input[name='pop_price']").val()==''){
                    alert('소비자가격을 입력하세요.');
                    return false;
                }

                if($("input[name='pop_qty']").val()==''){
                    alert('입고/출고 수량을 입력하세요.');
                    return false;
                }
                showMsg("수정중입니다......");
            },
            success:function(data, status) {
            	$("#viewDialog").dialog("close");
            },
            error:function(request, status) {
            	$("#viewDialog").dialog("close");
                closeBlockUI();
                alert(status);
            },
            complete:function(xhr, textStatus) {
                closeBlockUI();
                search(frm.pageNumTmp.value);
            }
        }); 
    }
}

function delInventory(seq){ 
    
    if(confirm("삭제하시겠습니까?")){
        $.ajax({
            type:"POST",
            cache: false,
            data:{
            "inventorySeq" : seq
            },
            dataType: "json",
            url:"/neroAdmin/productInventory/deleteInventoryInfo.action",
            beforeSend:function(xhr) {
                showMsg("삭제중입니다......");
            },
            success:function(data, status) {
            },
            error:function(request, status) {
                closeBlockUI();
                alert(status);
            },
            complete:function(xhr, textStatus) {
                closeBlockUI();
                search(frm.pageNumTmp.value);
            }
        }); 
    }
}
//간격조절 스트립트 끝
		
</script>
</head>
<body>
<form name="productInventoryFrm" method="post" onsubmit="return false">
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
    <td height="38" align="right" background="/images/nero/osb_t.gif" style="padding-right:20px"><table width="1170" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="799" align="left"><strong>▶ 품목별 입출고 관리</strong></td>
        <td width="371" align="right"><span id="totalProductCnt">총제품수 </span></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="center" background="/images/nero/osb_m.gif">
    <table width="1160" border="0" cellspacing="0" cellpadding="3">
      <tr>
        <td width="25%" valign="top">
        	<select name='productCate' id="productCate" size='10' style='font-size:12px;width:320px;height:220px;' onChange="selectProduct(this.value);">
        	</select>
        </td>
        <td width="816" align="center" style="vertical-align:top;">
	        <table width="816" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
	          <tr>
	            <td width="100" height="28" align="center" bgcolor="e7e7e7" class="tx12B">검색설정</td>
	            <td align="left" width="308" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
	            <select style="width:90%; height:20px" name="saleType" id="saleType">
	              <option value="Y">판매</option>
	              <option value="N">품절</option>
	              <option value="">전체</option>
	            </select>
	            </td>
	            <td width="100" align="center" bgcolor="e7e7e7" class="tx12B">제품검색</td>
	            <td align="left" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
	            	<input type="text" id="productSearchName" name="productSearchName" style="width:80%;"/>
	                <input type="button" value="검색" style="cursor:hand;" onclick="productBind();"/>
	                <input type="hidden" id="productSeq" name="productSeq"/>
	                <input type="hidden" id="productManufacture" name="productManufacture"/>
	            </td>
	          </tr>
	          </table>
	        <br/>
		   	<table width="816" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
	          <tr>
	            <td width="100" align="center" bgcolor="e7e7e7" class="tx12B">제품명</td>
	            <td align="left" width="308" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
	            	<input type="text" id="productName" name="productName" style="width:95%;"/>
	            </td>
	            <td width="100" height="28" align="center" bgcolor="e7e7e7" class="tx12B">바코드 / 상태</td>
	            <td align="left" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
	            	<input type="text" id="productBarcode" name="productBarcode" style="width:60%;"/>
	            	<select style="width:35%; height:20px" name="saleTypeTmp" id="saleTypeTmp">
	                  <option value="Y">판매</option>
	                  <option value="N">품절</option>
	                </select>
	            </td>
	          </tr>
	          <tr>
	            <td align="center" bgcolor="e7e7e7" class="tx12B">소비자가</td>
	            <td align="left" align="center" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
	            	<input type="text" id="productPrice" name="productPrice" style="width:90%;"/> 원
	            </td>
	            <td align="center" bgcolor="e7e7e7" class="tx12B">등록일</td>
	            <td bgcolor="#FFFFFF" style="padding : 1 0 3 0">
	            	<span id="createDate">2011.02.02</span>
				</td>
	          </tr>
	          </table>
	          <table width="816" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="25" align="right" valign="bottom">
                      <input type="hidden" value="N" name="initYn" id ="initYn"/>
                      <input type="button" value="신규" onclick="init('I');" style="cursor:hand;" />
                      <input type="button" value="저장" onclick="saveProductInfo();" style="cursor:hand;" />
                  </td>
                </tr>
            </table>
	          <br/>
	          <table width="816" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
	          <tr>
	            <td width="100" height="28" align="center" bgcolor="e7e7e7" class="tx12B">거래처</td>
	            <td align="left" width="308" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
	            	<select style="width:90%" name="companyCategory">
			          		<option value="">선택</option>
				          <c:forEach items="${listCompany}" var="listCompanyList">
				        	<option value="${listCompanyList.companySeq}">
				        	${listCompanyList.companyName }</option>
				          </c:forEach>
			          </select>
	            </td>
	            <td width="100" height="28" align="center" bgcolor="e7e7e7" class="tx12B">입/출고 / 재고</td>
	            <td align="left" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
	            	<input type="text" id="productCnt" name="productCnt" style="width:30%;"/>/
	            	<span id="productStock">500개</span>
	            	 &nbsp;&nbsp;(출고시 &quot;-&quot;입력)
	            </td>
	          </tr>
	        </table>
            <table width="816" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="25" align="right" valign="bottom">
                      <input type="button" value="입/출고저장" onclick="inventorySave();" style="cursor:hand;" />
                  </td>
                </tr>
            </table>
        </td>
      </tr>
    </table>
  </td>
  </tr>
  <tr>
    <td><img src="/images/nero/osb_b.gif" width="1200" height="27" /></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="center" background="/images/nero/osb_t.gif"><table width="1170" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width=406>
                      시작일 <input style="width:30%;" type="text" name="startDay" id="datepicker" readonly>
          ~
                      종료일 <input style="width:30%;" type="text" name="endDay" id="datepicker2" readonly>
        </td>
        <td width="387" align="right">
            <select name="inventoryType">
                <option value="">전체검색</option>
                <option value="in">입고</option>
                <option value="out">출고</option>
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
      <table  width="1170" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_productManage">
      </table>
      <table width="1170" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="30" align="center">
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
<input type="hidden" name="pageNumTmp" value="1">
</form>
<!-- 레이어 팝업시작 -->
        <div id="viewDialog" style="display: none; background: white;">
           <table>
             <tr>
               <td>소비자가</td>
               <td><input type="text" name="pop_price" id="pop_price" maxlength="20"/></td>
              </tr>
             <tr>
               <td>수량</td>
               <td><input type="text" name="pop_qty" id="pop_qty" maxlength="20"/></td>
              </tr>
              <tr>
                <td  colspan="2" align='right' bgcolor='#FFFFFF'>
                    <input type="hidden" name="pop_inventorySeq" id="pop_inventorySeq"/>    
	                <a href='javascript:saveDialog()'>
	                <img src='/images/nero/s_button_mo.gif' />
	                </a>
                </td>
              </tr>
           </table>  
       </div>
</body>
</html>
