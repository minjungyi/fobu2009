<?
include("../lib/db.inc");				// DB connect
include("../lib/db_func.inc");			// Connect fuction
include("../lib/lib.inc");				// fuction
include("../lib/table.inc");			// table infomation
include("../lib/MysqlClass.inc");		// class include
include("../lib/config.inc") ;			// config

$mysql = new MysqlClass;		// 객체 생성

if ($_POST[regist] == "ok")	{
	require_once $DOCUMENT_ROOT . "/outsource/excel/reader.php" ;
	// =================== EXCEL FILE UPLOAD START ======================
	$xls_upload_dir = $DOCUMENT_ROOT . "/outsource/xls_upload" ;
	$upload_file = $_FILES['upfile'];
	$user_file = $upload_file['tmp_name'];

	if ($upload_file["tmp_name"] != "") {
		$file_ext = strtolower (substr (strrchr ($upload_file[name], "."), 1)) ;
		if ($file_ext != "xls") {
			echo ("<script> alert('EXCEL (xls) 파일만 업로드 할 수 있습니다.'); history.go(-1); </script>") ;
			exit ;
		}

		if (is_dir ($xls_upload_dir . "/" . date (Ym))) {
			$xls_upload_dir .= "/" . date (Ym) ;
		} else {
			if (mkdir ($xls_upload_dir . "/" . date (Ym), 0707)) {
				$xls_upload_dir .= "/" . date (Ym) ;
			} else {
				echo ("<script> alert('디렉토리 생성 실패!\\n서버상의 디렉토리 생성에 실패하였습니다.\\n웹팀 관리자에게 문의하여 주십시요.'); history.go(-1); </script>") ;
				exit ;
			}
		}

		$file_path = $xls_upload_dir . "/shoplinker_" . date(YmdHis) . "." . $file_ext ;
		copy ($upload_file["tmp_name"], $file_path) ;
		$xls_file = basename ($file_path) ;
	}

	$xl_reader = new Spreadsheet_Excel_Reader() ;
	$xl_reader->setOutputEncoding('CP949') ;
	$xl_reader->read($file_path) ;
	
	$xl_reader->sheets[x][y];
	$size = sizeof($xl_reader);

	$rows = $xl_reader->sheets[0]['numRows'];
	$cols = $xl_reader->sheets[0]['numCols'];

	for($i=1; $i<=$rows; $i++) {
		$code = trim($xl_reader->sheets[0]['cells'][$i][1]);
		$COLUMN = "face";
		$WHERE = "ifriend_code='$code'";
		$Row = $mysql -> get_one($table[product], $COLUMN, $WHERE);

		if($Row[face] != "") {
			if($Row[face] == 1) {
				$UP_WHERE = "prod_code='$code'";
				$FIELDS[]="face";		$VALUES[]="1";
				$UPDATE = $mysql -> update_query("JT_twist_price", $FIELDS, $VALUES, $UP_WHERE);
				$FIELDS = "";
				$VALUES = "";
			} else {	
				$UP_WHERE = "prod_code='$code'";
				$FIELDS[]="face";		$VALUES[]="2";
				$UPDATE = $mysql -> update_query("JT_twist_price", $FIELDS, $VALUES, $UP_WHERE);
				$FIELDS = "";
				$VALUES = "";
			}
		} else {
			$UP_WHERE = "prod_code='$code'";
			$FIELDS[]="face";		$VALUES[]="3";
			$UPDATE = $mysql -> update_query("JT_twist_price", $FIELDS, $VALUES, $UP_WHERE);
			$FIELDS = "";
			$VALUES = "";
		}
	}
	redirect("$PHP_SELF",0);
	exit;
}
?>
<html>
<head>
<title> SHOPLINKER 외주배송정보 자동입력 </title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<LINK href='/css/common.css' rel=STYLESHEET title='text spacing' type=text/css>
<script language="javascript" src="../js/default.js"></script>
<script language="javascript">
function submitchk() {
	document.auctionregist.submit() ;
}
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr> 
		<td width="14" valign="top" bgcolor="EBEBE8"><img src="/images/popLeft.gif" width="14" height="259"></td>
		<td valign="top" class="TbrdAll_none">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="294"><img src="/images/pop/pop_60.gif"></td>
					<td width="100%" bgcolor="34BBF6">&nbsp;</td>
					<td width="150"><img src="/images/popT_right.jpg" width="150" height="42"></td>
				</tr>
			</table>
			<!--content 시작-->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td align="center" valign="top" class="box_01" style="padding:0 15 5 15">
						<table width="98%" border="0" cellspacing="0" cellpadding="4" class="Tb_all">
							<tr>
								<td align='center'>
									<br>
									<br>
									<table width='100%' border='0' cellspacing='0' cellpadding='0' align='center'>
										<tr>
											<td align='right' style='padding-left:10px;' colspan='2' style='padding:0 5 0 0'>
												<table width='100%' height='100%' border='0' cellpadding='0' cellspacing='0'>
													<tr> 
														<td width='13' align='right' valign='bottom'><img src='/images/balloon01.gif' width='13' height='13'></td>
														<td height='13' valign='bottom' background='/images/balloon02_bg.gif'><img src='/images/spacer.gif' width='1' height='13'></td>        
														<td width='13' align='left' valign='bottom'><img src='/images/balloon02.gif' width='13' height='13'></td>
													</tr>
													<tr> 
														<td width='13' valign='top' background='/images/balloon01_bg.gif'></td>
														<td height='100%' bgcolor='f4feff' style='font-family:굴림,Vernada ; font-size: 12px; padding:2 2 2 2'>
															<table width='100%' border='0' cellspacing='0' cellpadding='0'>
																<tr>
																	<td>
																		<table width='100%' border='0' cellspacing='0' cellpadding='0'>
																			<tr height="100">
																			<form method="post" name="auctionregist" action="<?=$PHP_SELF?>" enctype="multipart/form-data" OnSubmit="submitchk(); return false;">
																			<input type="hidden" name="regist"		value="ok">
																			<input type="hidden" name="mode"		value="<?=$mode?>">
																				<td style="padding:0 0 0 22;" bgcolor="#FFFFFF" valign="center">
																				EXCEL 파일 업로드 : <input type="file" name="upfile" size="60">
																				</td>
																			</tr>
																			<tr>
																				<td align="center" bgcolor="#FFFFFF" style="padding:12 0 12 0">
																					<table width="600" cellpadding="0" cellspacing="0" border="0">
																						<tr>
																							<td width="280" align="right"><input type="image" src="/images/c_regist.gif" border="0" style="border:0"></td>
																							<td width="10"></td>
																							<td width="280" align="left"><a href="javascript:self.close();"><img src="/images/c_cancel.gif" border="0"></a></td>
																						</tr>
																					</table>
																				</td>
																			</tr>
																			</form>
																		</table>
																	</td>
																</tr>
															</table>
														</td>
														<td width='13' valign='top' background='/images/balloon04_bg.gif'></td>
													</tr>
													<tr> 
														<td width='13' align='right' valign='top'><img src='/images/balloon03.gif' width='13' height='13'></td>
														<td background='/images/balloon03_bg.gif'></td>
														<td width='13' align='left' valign='top'><img src='/images/balloon04.gif' width='13' height='13'></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!--제품이용후기끝-->
					</td>
				</tr>
			</table>
			<!--content 끝-->
		</td>
		<td width="14" valign="top" bgcolor="EBEBE8"><img src="/images/popRight.gif" width="14" height="259"></td>
	</tr>
	<tr> 
		<td valign="top" bgcolor="EBEBE8">&nbsp;</td>
		<td height="41" bgcolor="EBEBE8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td width="10"><img src="/images/popFo01.gif" width="10" height="19"></td>
					<td width="100%" background="/images/popFo03.gif">&nbsp;</td>
					<td width="11"><img src="/images/popFo02.gif" width="11" height="19"></td>
				</tr>
				<tr> 
					<td colspan="3">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td height="22" valign="top"><img src="/images/popCopy.gif" width="97" height="15"></td>
								<td align="right" valign="top" style="padding : 2 10 0 0"><img src="/images/popClose.gif" width="47" height="13" onclick="javascript:self.close();" style="cursor:hand;"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
		<td width="14" valign="top" bgcolor="EBEBE8">&nbsp;</td>
	</tr>
</table>
</body>
</html>
