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
	
	frm = document.all.companyInventoryFrm;
	
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
	
	companyBind();		
});

function companyBind(){	
	init('U');
	$('#companyCate').empty();
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"companyName": $("#companySearchName").val()	
	    },
	    dataType: "json",
	    url:"/neroAdmin/companyInventory/companyList.action",
	    beforeSend:function(xhr) {
			//showMsg("로딩중입니다...");
		},
	    success:function(data, status) {
		    var i = 0;
	    	$.each(data.listCompanyInfo, function() {
	    		$('#companyCate').get(0).options[i] = new Option("["+this.companySeq+"] "+this.companyName,this.companySeq);
		    	i++;
	    	});
	    	$("#totalCompanyCnt").empty().html("총거래처수 "+data.listCompanyInfo.length+"건");   
		},
	    error:function(request, status) {
			closeBlockUI();
	        alert(status);
	     },
	    complete:function(xhr, textStatus) {	    	 
	    	 //closeBlockUI();
	    	$("#companyCate > option[index=0]").attr("selected", "true"); 
	    	selectCompany($("#companyCate > option:selected").val());
            search(1);
	     }
	});		
}

function selectCompany(seq){
	init('U');
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
	    "companySeq" : seq,
		"companyName": $("#companyName").val()
	    },
	    dataType: "json",
	    url:"/neroAdmin/companyInventory/companyList.action",
	    beforeSend:function(xhr) {
		    
			showMsg("로딩중입니다...");
		},
	    success:function(data, status) {
		    if(data.listCompanyInfo != null)
		    {   
		    	$("#companyName").val(data.listCompanyInfo[0].companyName);
		    	$("#companyNumber").val(data.listCompanyInfo[0].companyNumber);
		    	$("#companyContactPersn").val(data.listCompanyInfo[0].companyContactPersn);
		    	$("#companyTelNo").val(data.listCompanyInfo[0].companyTelNo);
		    	$("#companyFaxNo").val(data.listCompanyInfo[0].companyFaxNo);
		    	$("#companyAddr").val(data.listCompanyInfo[0].companyAddr);
		    	$("#companySeq").val(data.listCompanyInfo[0].companySeq);
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

function saveCompanyInfo(){	
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
			"companyName" : $("#companyName").val(),
			"companyNumber" : $("#companyNumber").val(),
			"companyContactPersn" : $("#companyContactPersn").val(),
			"companyTelNo" : $("#companyTelNo").val(),
			"companyFaxNo" : $("#companyFaxNo").val(),
			"companyAddr" : $("#companyAddr").val(),
			"companySeq" : $("#companySeq").val()
		    },
		    dataType: "json",
		    url:"/neroAdmin/companyInventory/saveCompanyInfo.action",
		    beforeSend:function(xhr) {
		    	if($("input[name='companyName']").val()==''){
                    alert('거래처를 입력하세요.');
                    return false;
                }

		    	if($("input[name='companyNumber']").val()==''){
                    alert('거래처 사업자번호를 입력하세요.');
                    return false;
                }

		    	if($("input[name='companyContactPersn']").val()==''){
                    alert('거래처 담당자를 입력하세요.');
                    return false;
                }

		    	if($("input[name='companyTelNo']").val()==''){
                    alert('거래처 전화번호를 입력하세요.');
                    return false;
                }

		    	if($("input[name='companyFaxNo']").val()==''){
                    alert('거래처 팩스번호를 입혁하세요.');
                    return false;
                }

		    	if($("input[name='companyAddr']").val()==''){
                    alert('거래처 주소를 입력하세요.');
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
		    	companyBind();
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
            "companySeq": $("#companyCate > option:selected").val(),
            "productName":productName,
            "barcode" : barcode 
        },
        dataType: "json",
        url:"/neroAdmin/companyInventoryManage/init.action",
        beforeSend:function(xhr) {
            showMsg("로딩중입니다...");
        },
        success:function(data, status) {
            var c = "";
            
            var cHeader = "<tr>"
                +"<td width='110' align='center' bgcolor='e7e7e7' class='tx12B'>거래처</td>"
                +"<td width='110' align='center' bgcolor='e7e7e7' class='tx12B'>바코드</td>"
                +"<td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
                +"<td width='70' align='center' bgcolor='e7e7e7' class='tx12B'>소비자가</td>"
                +"<td width='70' align='center' bgcolor='e7e7e7' class='tx12B'>재고</td>"
                //+"<td width='90' align='center' bgcolor='e7e7e7' class='tx12B'>등록일</td>"
                +"<td width='110' align='center' bgcolor='e7e7e7' class='tx12B'>등록일</td>"
                +"</tr>";
            var a = 1;  

            if(data.companyInventoryList.length == 0){
                c = "<tr><td colspan='9' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>";
                $("#search_companyManage").html(cHeader+c);
                
            }else{
                
                $.each(data.companyInventoryList, function() {
                     
                    c += "<tr onclick='rowSelect(this, \""+this.seq+"\");' bgcolor='#FFFFFF' style=cursor:hand;>"
                    +"<td align='center' bgcolor='#FFFFFF'>"+this.companyName+"</td>"
                    +"<td align='center' bgcolor='#FFFFFF'>"+this.productBarcode+"</td>"
                    +"<td align='left' bgcolor='#FFFFFF'>"+this.productName+"</td>"
                    +"<td align='right' bgcolor='#FFFFFF'>"+commify(this.productPrice)+"</td>"
                    +"<td align='right' bgcolor='#FFFFFF'>"+commify(this.inventoryCnt)+"</td>"
                    //+"<td align='center' bgcolor='#FFFFFF'>"+this.createDate+"</td>"
                    +"<td align='center' bgcolor='#FFFFFF'>"+this.createDt+"</td>"
                    +"</tr>";
                    
                    a++;
                });
                $("#search_companyManage").html(cHeader+c);
            }
            var totalPage = Math.ceil(parseInt(data.companyInventoryCount)/parseInt(listScale));
            $("#spanCount").empty().html("전체 "+data.companyInventoryCount+" 개 : "+pageNum+" / "+totalPage+" 페이지");                     
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
	//trIndex = $("#search_companyManager tr").index(obj);
	$("#search_companyManage tr").css("backgroundColor","#FFFFFF");
	obj.style.backgroundColor="#e0eeee";	
}

function init(arg){
	//$(":text").val("");
	$("#initYn").val(arg);
	$("#companySeq").val("");
	$("#companyName").val("");
	$("#companyNumber").val("");
	$("#companyContactPersn").val("");
	$("#companyTelNo").val("");
	$("#companyFaxNo").val("");
	$("#companyAddr").val("");
	
}

//간격조절 스트립트 끝
		
</script>
</head>

<body>
<form name="companyInventoryFrm" method="post" onsubmit="return false">
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
<div class="div_space"></div>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="38" align="right" background="/images/nero/osb_t.gif" style="padding-right:20px"><table width="1170" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="872" align="left"><strong>▶ 거래처별 입출고관리</strong></td>
        <td width="298" align="right"><span id="totalCompanyCnt">거래처수 </span></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="center" background="/images/nero/osb_m.gif"><table width="1160" border="0" cellspacing="0" cellpadding="3">
      <tr>
        <td width="25%" valign="top">
        	<select name='companyCate' id="companyCate" size='10' style='font-size:12px;width:320px;' onChange="selectCompany(this.value);">
        	</select>       
        </td>
        <td width="816" align="center" style="vertical-align:top;"><table width="816" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
          <tr>
            <td align="center" bgcolor="e7e7e7" class="tx12B">거래처검색</td>
            <td bgcolor="#FFFFFF" align="left" style="padding : 1 0 3 0">
            	<input type="text" id="companySearchName" name="companySearchName" style="width:73%;"/>
                <input type="button" value="검색" style="cursor:hand;" onclick="companyBind();"/>
                <input type="hidden" id="companySeq" name="companySeq"/>
            </td>
            <td width="20%" align="center" bgcolor="e7e7e7" class="tx12B">거래처명</td>
            <td width="30%" bgcolor="#FFFFFF" align="left" style="padding : 1 0 3 0">
            	<input type="text" id="companyName" name="companyName" style="width:90%;"/>
           	</td>
          </tr>
          <tr>
            <td width="20%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">사업자번호</td>
            <td width="30%" bgcolor="#FFFFFF" align="left" style="padding : 1 0 3 0">
            	<input type="text" id="companyNumber" name="companyNumber" style="width:90%;"/>
            </td>
            <td width="20%" align="center" bgcolor="e7e7e7" class="tx12B">담당자</td>
            <td width="30%" bgcolor="#FFFFFF" align="left" style="padding : 1 0 3 0">
            	<input type="text" id="companyContactPersn" name="companyContactPersn" style="width:90%;"/>
            </td>
          </tr>
          <tr>
            <td  height="28" align="center" bgcolor="e7e7e7" class="tx12B">연락처</td>
            <td  bgcolor="#FFFFFF" align="left" style="padding : 1 0 3 0">
            	<input type="text" id="companyTelNo" name="companyTelNo" style="width:90%;"/>
            </td>
            <td  height="28" align="center" bgcolor="e7e7e7" class="tx12B">팩스</td>
            <td  bgcolor="#FFFFFF" align="left" style="padding : 1 0 3 0">
            	<input type="text" id="companyFaxNo" name="companyFaxNo" style="width:90%;"/>
            </td>
          </tr>
          <tr>
            <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">주소</td>
            <td colspan="3" align="left" bgcolor="#FFFFFF" style="padding : 1 0 3 0">
            	<input type="text" id="companyAddr" name="companyAddr" style="width:90%;"/>
            </td>
          </tr>
        </table>
        <table width="500" border="0" cellspacing="0" cellpadding="0">
        	<tr>
            	<td height="25" align="center" valign="bottom">
            		<input type="hidden" value="N" name="initYn" id ="initYn"/>
                	<input type="button" value="신규" onclick="init('I');" style="cursor:hand;" />
                  	<input type="button" value="저장" onclick="saveCompanyInfo();" style="cursor:hand;" />
                 </td>
            </tr>
        </table>
       </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><img src="/images/nero/osb_b.gif" width="1200" height="27" /></td>
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
            <select name="inventoryType">
                <option value="">전체검색</option>
                <option value="in">입고</option>
                <option value="out">출고</option>
            </select>
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
      <table  width="1170" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9" id="search_companyManage">
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
