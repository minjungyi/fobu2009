<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/themes/base/ui.all.css"
	rel="stylesheet" />
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<title>오픈마켓등록 엑셀작업</title>
<style type="text/css">
<!--
.textbox {
	border: 0px none;
}
-->
</style>

<script language="javascript">
	$(function() {
		$("#marketType").val("${marketType}");
		$("#companyCategory").val("${companyCategory}");
	});

	function onNewProductUpload() {
		var frm = document.frm;
		frm.action = "/productUpload.action";
		frm.submit();
	}
	function onNewProductDown() {
		//showMsg("엑셀파일 변환중입니다...");
		//document.target = "_blank";
		//document.location.href = "/admin/excel/new_shop_product_list.html";
		var marketType = $("#marketType").val();
		var companyCategory = $("#companyCategory").val();
		var frm = document.frm;
		frm.target = "iframe_proc";
		frm.action = "/admin/excel/new_shop_product_list.html?deliver=pay&companyCategory=" + companyCategory + "&marketType=" + marketType;
		frm.submit();
	}
	function onNewProductDown2() {
		//showMsg("엑셀파일 변환중입니다...");
		//document.target = "_blank";
		//document.location.href = "/admin/excel/new_shop_product_list.html";
		var marketType = $("#marketType").val();
		var companyCategory = $("#companyCategory").val();
		var frm = document.frm;
		frm.target = "iframe_proc";
		frm.action = "/admin/excel/new_shop_product_list.html?deliver=free&companyCategory=" + companyCategory + "&marketType=" + marketType;
		frm.submit();
	}
	
	function onNewProductDown3(){
		
		var marketType = $("#marketType").val();
		var companyCategory = $("#companyCategory").val();
		var frm = document.frm;
		frm.target = "iframe_proc";
		frm.action = "/admin/excel/choco_mall_product_list.html?deliver=all&companyCategory=" + companyCategory + "&marketType=" + marketType;
		frm.submit();
		
	}
	function onShoplinkerUpload() {
		window.open('/admin/shoplinker/shoplinker_init.html?face=upload','shoplinker_init','width=1000, height=400, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');		
	}
</script>
</head>
<body bgcolor="4b4b4b">
	<form name="frm" method="post" enctype="multipart/form-data">
		<input type="hidden" id="marketType" name="marketType" /> 
		<input type="hidden" id="companyCategory" name="companyCategory" />
		<table width="760" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td height="50" valign="bottom" background="/images/title_new.gif">&nbsp;</td>
			</tr>
		</table>
		<table width="760" border="7" align="center" cellpadding="15"
			cellspacing="0" bordercolor="4b4b4b">
			<tr>
				<td bgcolor="#FFFFFF">
					<table width="100%" border="0" cellspacing="0" cellpadding="3">
						<tr height="35px">
							<td style="text-align: center;"><img
								src="/images/button/btn_news.gif" style="cursor: hand;"
								onclick="onNewProductDown();" /></td>
							<td style="text-align: center;"><img
								src="/images/button/btn_newm.gif" style="cursor: hand;"
								onclick="onNewProductDown2();" /></td>
							<td style="text-align: center;"><img
								src="/images/button/btn_newshop.gif" style="cursor: hand;"
								onclick="onNewProductDown3();" /></td>
						</tr>						
						<tr>
							<td colspan="3">&nbsp;</td>							
						</tr>
						<tr>
							<td colspan="3" align="center">
								<table width="100%" border="0" cellpadding="5" cellspacing="1"
									bgcolor="e1e1e1">
									<tr>
										<td width="50%" align="center" bgcolor="ffffff"><img
											src="/images/button/btn_newe.gif" style="cursor: hand;"
											onclick="onShoplinkerUpload();" /></td>
										<td align="center" bgcolor="ffffff"><input type="file"
											name="file"> <img src="/images/button/open_oder.gif"
											style='cursor: hand;' onclick="onNewProductUpload();"
											align="absmiddle"></td>
									</tr>
								</table>
							</td>
						</tr>						
					</table>
				</td>
			</tr>
		</table>
	</form>
	<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0
		height=0></iframe>
</body>
</html>
