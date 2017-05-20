<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String key = "key";
	String happyPart = "happyPart";
	String word = "word";
	String sort = "1";
	String bbs_tid = "2";
	String keyTmep = "keyTmep";
	String wordTemp = "wordTemp";
	String pageNumber = "0";
	String page_count = "0";
	String count = "0";
	String m_name = "name";

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="/css/yong.css" rel="stylesheet" type="text/css">
<title><%=m_name %></title>

<script language="javascript">

	function selected() {
		for (var i = 0; i < selFrm.keyTemp.options.length; i++) {
			if (selFrm.keyTemp.options[i].value == "<%=key %>") {
				selFrm.keyTemp.options[i].selected = true;
			}
		}
		
		selFrm.sort.value = "<%=sort%>"
		var sortPart = selFrm.sort.value;
		if(sortPart=="asc"){
			selFrm.sort1.checked=false;
			selFrm.sort2.checked=true;
		}else{
			selFrm.sort1.checked=true;
			selFrm.sort2.checked=false;			
		}
		selFrm.wordTemp.value = "<%=wordTemp %>";
	}

	function search() {
		if(selFrm.sear.checked){
			selFrm.key.value = "<%=key%>"+"/"+selFrm.keyTemp.value;
			selFrm.word.value = "<%=word%>"+"/"+selFrm.wordTemp.value;
		}else{
			if(selFrm.wordTemp.value==null || selFrm.wordTemp.value==""){
				selFrm.key.value = "";
				selFrm.word.value = "";
			}else{
				selFrm.key.value = selFrm.keyTemp.value+"/";
				selFrm.word.value = selFrm.wordTemp.value+"/";
			}
		}
		
		selFrm.page_no.value = "1";
		selFrm.action="boardList.jsp";
		
		selFrm.submit();
	}
	
	function detail(bbs_idx, bbs_read_cnt, bbs_reg_uid) {
		selFrm.bbs_idx.value = bbs_idx;
		selFrm.bbs_reg_uid.value = bbs_reg_uid;
		selFrm.bbs_read_cnt.value = bbs_read_cnt;			
		selFrm.action="boardDetail.jsp";		
		selFrm.submit();
	}

	function boardIn() {
			
		selFrm.action="boardInsert.jsp";		
		selFrm.submit();
	}

	function boardMove() {
		var temp_array = "";
		len = selFrm.moveCk.length;
		
		if(selFrm.boardPart.value=="XXX"){
			alert("게시판을 선택해주세요.");	
			return;	
		}
		
		var bbs_tid = selFrm.bbs_tid.value;
		
		  for (i=0; i<len; i++) 
		  { 
		    if (selFrm.moveCk[i].checked) {
		    	temp_array += selFrm.moveCk[i].value+"&"; 
		    }
		    
		  }
		 selFrm.move.value = temp_array;
		selFrm.action="boardMoveProc.jsp";		
		selFrm.submit();
	}

	function allList() {
		if(selFrm.sear.checked){
			selFrm.key.value = "<%=key%>"+"/"+selFrm.keyTemp.value;
			selFrm.word.value = "<%=word%>"+"/"+selFrm.wordTemp.value;
		}else{
			if(selFrm.wordTemp.value==null || selFrm.wordTemp.value==""){
				selFrm.key.value = "";
				selFrm.word.value = "";
			}else{
				selFrm.key.value = selFrm.keyTemp.value+"/";
				selFrm.word.value = selFrm.wordTemp.value+"/";
			}
		}
		
		selFrm.action="boardAllList.jsp";
		
		selFrm.submit();
	}

	function searchInSerch(){
		if(selFrm.sear.checked){
			selFrm.key.value = "<%=key%>"+"/"+selFrm.keyTemp.value;
			selFrm.word.value = "<%=word%>"+"/"+selFrm.keyTemp.value;
		}
	}

	function searchPage(pageNo) {
		var page_no = pageNo;
		var max = <%=page_count%>;

		if(page_no < 1) {
			page_no = "1";
		}

		if(page_no > max) {
			page_no = max;
		}

		selFrm.page_no.value = page_no;
		selFrm.key.value = selFrm.keyTemp.value;
		selFrm.word.value = selFrm.wordTemp.value;
		selFrm.action="boardList.jsp";
		selFrm.submit();
	}

	function enter()
	{
		if(event.keyCode == 13){ 
		search();
	}
	}

	function sortStart(part){
		//오름차순 내림차순 정렬.
		if(part=="desc"){
			selFrm.sort.value = "desc";
			selFrm.sort1.checked=true;
			selFrm.sort2.checked=false;
		}else{
			selFrm.sort.value = "asc";
			selFrm.sort1.checked=false;
			selFrm.sort2.checked=true;
		}
		search();
	}

	function change(){
		if(selFrm.boardPart.value=="XX"){
			alert("게시판이 아닌 폴더입니다. 다시 선택해주세요.");	
			selFrm.boardPart.options[0].selected = true;	
		}		
	} 
		
</script>
</head>
<body onload="selected();">
<form name="selFrm" method="post" onsubmit="return false">
<input type="hidden" name="page_no">
<input type="hidden" name="bbs_read_cnt" value="">
<input type="hidden" name="bbs_reg_uid" value="">
<input type="hidden" name="move" value="">
<input type="hidden" name="bbs_tid" value="<%=bbs_tid%>">
<input type="hidden" name="happyPart" value="<%=happyPart%>">
<input type="hidden" name="bbs_idx" value="">
<input type="hidden" name="m_name" value="<%=m_name%>">
<input type="hidden" name="sort" name="desc">
<table width="669" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="./images/center_round_01.gif" width="13" height="9" alt=""></td>
		<td>
			<img src="./images/center_round_02.gif" width="644" height="9" alt=""></td>
		<td>
			<img src="./images/center_round_03.gif" width="12" height="9" alt=""></td>
	</tr>
	<tr>
		<td background="./images/center_round_04.gif">
			<img src="./images/center_round_04.gif" width="13" height="6" alt=""></td>
		<td width="647" >
			<!-- 제목 시작 -->
			<table width="643" height="37" border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td width= "27"><img src="./images/main_first_title_01.gif" width="27" height="37" alt=""></td>
					<td width="604" background="./images/main_first_title_02.gif"><%=m_name %></td>
					<td width= "12" ><img src="./images/main_first_title_03.gif" width="12" height="37" alt=""></td>
				</tr>
			</table><br>				
			<!-- 제목 끝 -->
			<!-- 내용 시작 -->
			<p>		
				<ul id="bortop_float">
					<li class="bor_blet pt3">총갯수 : <%=count%>개</li>
					<li class="pt3" style="padding-left:300px;">
						<input type="radio" name="sort1" value="desc" onclick="sortStart('desc');"/>
					</li>
					<li class="pt3">오름차순</li>
					<li class="pt3">
						<input type="radio" name="sort2" value="asc" onclick="sortStart('asc');"/>
					</li>
					<li class="pt3">내림차순</li>
					<li class="bor_btntop" style="border:0px;">
						<div class="fl pt3"><input type="checkbox" id="" name="" value="" onclick="allList();"/></div>
						<div class="fl pt3">전체보기</div>
					</li>
			
				</ul>
				<div id="board_topbg" class="cb">
					<ul>
						<li style="width:50px">선택</li>
						<li class="boardbar"></li>
						<li style="width:55px">번호</li>
						<li class="boardbar"></li>
						<li style="width:200px">제목</li>
						<li class="boardbar"></li>
						<li style="width:65px">첨부</li>
						<li class="boardbar"></li>
						<li style="width:80px">작성자</li>
						<li class="boardbar"></li>
						<li style="width:90px">작성일</li>
						<li class="boardbar"></li>
						<li style="width:60px">조회수</li>
					</ul>
				</div>
				<div id="borderbody_pad">
					<table id="bordertable" style="table-layout:fixed;">
						<colgroup><col width="51px"><col width="56px"><col width="201px"><col width="66px"><col width="81px"><col width="91px"></colgroup>
						
						
							<tr align="center">
								<td colspan="7">검색결과가 없습니다.</td>
							</tr>
								
					</table>
					<div class="sbtn">
					<select name="boardPart" onchange="change();" align="absmiddle">
					<option value="XXX">선택</option>
					
					</select>
					<img src="./images/btn_s_register.gif" onclick="boardMove();" style="cursor:hand" align="absmiddle">
				
					</div>
				</div>
				<div class="nunber_text">
					<div class="number_color">
						<span><img src="./images/btn_number_prev02.gif" onclick="searchPage('1');"></span>
						
					

						<span><img src="./images/btn_number_next02.gif" onclick="searchPage('<%=page_count%>');"></span>
					</div>
					<div class="pt20">
						<ul class="pl110">
							<li class="fl">
								<select name="keyTemp">
									<option value="BBS_TITLE">제목</option>
									<option value="BBS_CONTENT">내용</option>
									<option value="BBS_REG_UNAME">작성자</option>
								</select>
								&nbsp;
								<input type="text" name="wordTemp" value="" class="search_input" onkeydown="return enter();" align="absmiddle"/>
								&nbsp;
								<img src="./images/btn_s_serch.gif" onclick="search();" align="absmiddle" style="cursor:hand">
								<input type="hidden" name="key" value="">
								<input type="hidden" name="word" value="">					
							</li>
							<li class="fl pl15 pt2"><input type="checkbox" id="" name="sear" value="" /></li>
							<li class="fl pt2">결과내 재검색</li>
						</ul>
					</div>
				</div>			
			</P>
			<!-- 내용 끝 -->
		</td>
		<td background="./images/center_round_06.gif">
			<img src="./images/center_round_06.gif" width="12" height="6" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="./images/center_round_07.gif" width="13" height="13" alt=""></td>
		<td>
			<img src="./images/center_round_08.gif" width="644" height="13" alt=""></td>
		<td>
			<img src="./images/center_round_09.gif" width="12" height="13" alt=""></td>
	</tr>
</table>	
</form>
</body>
</html>
