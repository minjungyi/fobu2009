<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>

<script language="javascript">
var fileExist = true;
var companyHtml = "";
var frm = null;
var trIndex = 1;

$(function() {	
	$("#btnExport").click(function (e) {
		
		
	   /*  window.open('data:application/vnd.ms-excel,' + $('#dvData').html());
	    e.preventDefault(); */
	    
		var table = $("#dvData");
	    var strCopy = $('<div></div>').html(table.clone()).html(); 
	    window.clipboardData.setData("Text", strCopy);
	    var objExcel = new ActiveXObject("Excel.Application");
	    objExcel.visible = false; 
	    var objWorkbook = objExcel.Workbooks.Add; 
	    var objWorksheet = objWorkbook.Worksheets(1); 
	    objWorksheet.Paste; 
	    objExcel.visible = true;
	    
	});
	
	$("#btnCopy").click(function (e) {
		 var table = $("#dvData");
	     var strCopy = $('<div></div>').html(table.clone()).html(); window.clipboardData.setData("Text", strCopy);
	});
	$("#btnDel").click(function (e) {
		$("#tblData tr").remove();
		var html = "<tr><th>uid</th><th>제품명</th><th>소비자가</th><th>판매가</th><th>도매가</th></tr>";
		$("#tblData").append(html);
		
	});
	
	
});
function doGetData(){
	var content = $('#txtaContent').val();
	//alert($.parseHTML(content));
	getHtmlData($.parseHTML(content));
}
function doGetData2(){
	var urlPath = $('#txtUrlPath').val();
	
	var urlTmp = "/admin/product/product_list2.action";
  	
	$.ajax({
        type:"POST",
        cache: false,
        data:{		
		"urlPath": urlPath
        },
        dataType: "html",
        url:urlTmp,
        beforeSend:function(xhr) {
        	showMsg("데이터를 엑셀로 변환하고 있습니다.<br><br>잠시만 기다려 주세요!");			
		},
        success:function(data, status) {
        	getHtmlData(data);
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	closeBlockUI();
        }
	});
}

function getHtmlData(data){
	//alert(data);
	var i = 0;
	showMsg("추출중입니다...");
	
	var companyNo = $('#selCompany').val();
	if(companyNo == '36'){
		//제품명, 컬러, 소비자가, 판매가, 몰가, 패밀리가, 원가, 브랜드	
		$(".listbox",data).find("li").each(function(){
			//alert(data);
			var uid = $(this).find(".tit").attr("href").split("&")[1].replace("uid=","");
			var product = $(this).find(".tit").text();
			var retailPrice = $(this).find(".p").text().split(":")[1].replace(" ","").replace("원","").replace(",","");
			var sellPrice = $(this).find(".basePrice").text().split(":")[1].replace(" ","").replace("원","").replace(",","");
			var originalPrice = $(this).find(".s").text().split(":")[1].replace(" ","").replace("원","").replace(",","");
			
			var html = "<tr>"
					 + "  <td>"+uid+"</td>"
					 + "  <td>"+product+"</td>" 
					 + "  <td>"+retailPrice+"</td>"
					 + "  <td>"+sellPrice+"</td>"
					 + "  <td>"+originalPrice+"</td>"
					 +"</tr>";
			$("#tblData").append(html);
			//$("#tblData").append("<td>"+product+"</td>");
			//$("#tblData").append("<td>"+retailPrice+"</td>");
			//$("#tblData").append("<td>"+retailPrice+"</td>");
			//$("#tblData").append("</tr>");
		});
	}else if( companyNo == '25'){
		//제품명, 컬러, 소비자가, 판매가, 몰가, 패밀리가, 원가, 브랜드	
		$(".ga09list",data).find("li").each(function(){
			//alert(data);
			var uid = $(this).find(".name").find("a").attr("href").split("&")[0].split("=")[1];
			var product = $(this).find(".name").text();
			var retailPrice = $(this).find(".price").text().replace(" ","").replace("won","").replace(",","");
			var sellPrice = "";
			var originalPrice = "";
			
			var html = "<tr>"
					 + "  <td>"+uid+"</td>"
					 + "  <td>"+product+"</td>" 
					 + "  <td>"+retailPrice+"</td>"
					 + "  <td>"+sellPrice+"</td>"
					 + "  <td>"+originalPrice+"</td>"
					 +"</tr>";
			$("#tblData").append(html);
			//$("#tblData").append("<td>"+product+"</td>");
			//$("#tblData").append("<td>"+retailPrice+"</td>");
			//$("#tblData").append("<td>"+retailPrice+"</td>");
			//$("#tblData").append("</tr>");
		});
	}
	
	closeBlockUI();
	//alert(i);
}

</script>
<form name="productfrm" method="post" target="iframe_proc">
<input id="hdnPageNum" name="hdnPageNum" type="hidden" value="1"/>
<input type="hidden" name="pageNumTmp" value="1">
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 제품통합검색</td>
  </tr>
  <tr>
  	<td>
  		<select id="selCompany" >
  			<option value="25">가방쟁이</option>
  			<option value="28">허브인</option>
  			<option value="30">로즈마리</option>
  			<option value="32">푸카푸카</option>
  			<option value="1">지원</option>
  			<option value="34">그린피플</option>
  			<option value="35">SD도매</option>
  			<option value="36">싸울스포츠</option>
  		</select>
		<input type="text" id="txtUrlPath" style="width:800px;" value="http://1020bag.com/product/list.html?cate_no=83"/> &nbsp;
		<br/>
		<textarea id="txtaContent" style="width:100%; height:300px;"></textarea>
		<br/>
		<input type="button" id="btnGetData" value="가져오기" onclick="doGetData2();"/>
		
		  		
  	</td>
  </tr>
</table>
<br/>
<br/>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<input type="button" id="btnCopy" value=" Copy Data " />&nbsp;&nbsp;
		<input type="button" id="btnDel" value=" Delete Data " />
		<br/>
		<br/>
		<div id="dvData"  style="overflow:auto; width:100%; height:600px; line-height:150%">
		    <table border="1" id="tblData">
		        <tr>
		        	<th>uid</th>
		            <th>제품명</th>
		            <th>소비자가</th>
		            <th>판매가</th>
		            <th>도매가</th>
		        </tr>
		    </table>
		</div>
	</td>
</tr>
</table>

 </form>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>

<!-- top end-->


