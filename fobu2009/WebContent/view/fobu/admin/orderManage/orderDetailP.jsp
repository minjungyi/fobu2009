<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>::::::::: 주문상세조회 입니다 :::::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" href="/css/css.css" rel="stylesheet" />
<link type="text/css" href="/css/themes/base/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script language="javascript">
</script>
</head>
<body>
<form name="productfrm" method="post" action="product_write.action" target="iframe_proc">
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="28" valign="bottom" class="tx14B" style="padding-left:10px">▣ 주문상세조회</td>
	</tr>
</table>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="110" height="110"><img src="../images/111.jpg" width="100" height="100"></td>
    <td align="right"><table width="580" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
      <tr>
        <td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">제품명</td>
        <td colspan="3" bgcolor="#FFFFFF"><span style="padding : 1 0 3 0"><c:out value="${totalOrderDetailList[0].product}"/><a href="#"><img src="../images/button/btn_link.gif" width="37" height="21" align="absmiddle"></a> </span></td>
      </tr>
      <tr>
        <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">주문번호</td>
        <td width="27%" bgcolor="#FFFFFF"><strong><c:out value="${totalOrderDetailList[0].seq}"/></strong></td>
        <td width="14%" align="center" bgcolor="e7e7e7" class="tx12B">배송방법</td>
        <td width="44%" bgcolor="#FFFFFF">
        <c:out value="${totalOrderDetailList[0].deliverType}"/>
        <!-- select name='deliver_type'>
          <option value="0">무료배송</option>
          <option value="3">선결제</option>
          <option value="4">착불</option>
          <option value="1">퀵서비스</option>
          <option value="2">방문수령</option>
        </select>
              <input type='text' size='10' name='deliver' value='0' style="text-align:right">원-->
        </td>
      </tr>
      <tr>
        <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">수량</td>
        <td bgcolor="#FFFFFF"><span style="padding : 1 0 3 0"><c:out value="${totalOrderDetailList[0].seq}"/></span></td>
        <td align="center" bgcolor="e7e7e7" class="tx12B">옵션</td>
        <td bgcolor="#FFFFFF"><c:out value="${totalOrderDetailList[0].seq}"/></td>
      </tr>
      <tr>
        <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">원가/단가</td>
        <td bgcolor="#FFFFFF">
        	<c:out value="${totalOrderDetailList[0].orderPrice}"/>/<c:out value="${totalOrderDetailList[0].orderPrice}"/>
        	<!-- input type='text' size='10' name='deliver3' value='0' style="text-align:right">원/20,000원-->
        </td>
        <td align="center" bgcolor="e7e7e7" class="tx12B">거래처</td>
        <td bgcolor="#FFFFFF">
        	<c:out value="${totalOrderDetailList[0].seq}"/>
        	<!--select name='st4' onChange="state_change2(this.form)" style='font-size:12px;'>
          		<option>지원유통</option>
        	</select-->
        </td>
      </tr>
    </table></td>
  </tr>
</table>
<br>
<table width="700" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
  <tr>
    <td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B"><strong>주문자</strong></td>
    <td width="35%" bgcolor="#FFFFFF"><span style="padding : 1 0 3 0"><c:out value="${totalOrderDetailList[0].orderer}"/></span></td>
    <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">E-mail</td>
    <td width="35%" bgcolor="#FFFFFF"><c:out value="${totalOrderDetailList[0].ordererEmail}"/></td>
  </tr>
  <tr>
    <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">전화번호</td>
    <td bgcolor="#FFFFFF"><span style="padding : 1 0 3 0"><c:out value="${totalOrderDetailList[0].ordererTel}"/></span></td>
    <td align="center" bgcolor="e7e7e7" class="tx12B">휴대폰</td>
    <td bgcolor="#FFFFFF"><c:out value="${totalOrderDetailList[0].ordererHp}"/></td>
  </tr>
  <tr>
    <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">주소</td>
    <td bgcolor="#FFFFFF" colspan="3"><c:out value="${totalOrderDetailList[0].seq}"/></td>
  </tr>
  <tr>
    <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">주문자메모</td>
    <td bgcolor="#FFFFFF" colspan="3"><c:out value="${totalOrderDetailList[0].deliverMemo}"/></td>
  </tr>
  <tr>
    <td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B"><strong>수령인</strong></td>
    <td width="35%" bgcolor="#FFFFFF">
    	<span style="padding : 1 0 3 0">
    		<c:out value="${totalOrderDetailList[0].receiver}"/> 
    	</span>
    	<!-- span style="padding : 1 0 3 0">
      		<input type="text" id="receiver3" name="receiver3" style="width:90%;" value="김미량"/>
    	</span-->
    </td>
    <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">E-mail</td>
    <td width="35%" bgcolor="#FFFFFF"><c:out value="${totalOrderDetailList[0].seq}"/></td>
  </tr>
  <tr>
    <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">전화번호</td>
    <td bgcolor="#FFFFFF">
    	<span style="padding : 1 0 3 0">
        	<c:out value="${totalOrderDetailList[0].receiverTel}"/>
        	<!-- input type="text" id="receiverTel3" name="receiverTel3" style="width:90%;" value="010-9021-5659"/-->
    	</span>
    </td>
    <td align="center" bgcolor="e7e7e7" class="tx12B">핸드폰번호</td>
    <td bgcolor="#FFFFFF">
    	<span style="padding : 1 0 3 0">
    		<c:out value="${totalOrderDetailList[0].receiverHp}"/>
      		<!-- input type="text" id="receiverHp3" name="receiverHp3" style="width:90%;" value="010-9021-5659"/-->
    	</span>
    </td>
  </tr>
  <tr>
    <td height="28" align="center" bgcolor="e7e7e7" class="tx12B">배송주소</td>
    <td bgcolor="#FFFFFF" colspan="3">
    	<span style="padding : 1 0 3 0">
    		[<c:out value="${totalOrderDetailList[0].receiverZipcode}"/>] <c:out value="${totalOrderDetailList[0].receiverAddress}"/>
      		<!-- input type="text" id="receiverZipcode3" name="receiverZipcode3" style="width:90%;" value="[132-793] 서울 도봉구 창5동 동아그린아파트 102동 1409호"/-->
    	</span><!-- a href="#">[우편번호]</a--></td>
  </tr>
</table>
<br>
<table width="700" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="d9d9d9">
  <tr>
    <td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">주문수집</td>
    <td width="35%" bgcolor="#FFFFFF">
    	<span style="padding : 1 0 3 0"><c:out value="${totalOrderDetailList[0].siteCode}"/></span></td>
    <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">결제수단</td>
    <td width="35%" bgcolor="#FFFFFF">
    	<span style="padding : 1 0 3 0"><c:out value="${totalOrderDetailList[0].seq}"/></span></td>
  </tr>
  <tr>
    <td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">결제정보</td>
    <td bgcolor="#FFFFFF"><span style="padding : 1 0 3 0"><c:out value="${totalOrderDetailList[0].seq}"/></span></td>
    <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">입금자</td>
    <td bgcolor="#FFFFFF">
    	<span style="padding : 1 0 3 0">
      		<c:out value="${totalOrderDetailList[0].seq}"/>
      		<!-- input type="text" id="receiver" name="receiver" style="width:90%;" value="김미량"/-->
    	</span>
    </td>
  </tr>
  <tr>
    <td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">주문진행상태</td>
    <td bgcolor="#FFFFFF">
    	<span style="padding : 1 0 3 0"><c:out value="${totalOrderDetailList[0].seq}"/></span>
    	<!-- select name='st2' onChange="state_change2(this.form)" style='font-size:12px;'>
	      <option value='0'selected>정상처리</option>
	      <option value='4'>취소완료</option>
	      <option value='5'>취소요청</option>
	      <option value='6'>반품요청</option>
	      <option value='7'>반품완료</option>
	      <option value='8'>교환요청</option>
	      <option value='9'>교환완료</option>
   		</select-->
   	</td>
    <td width="15%" align="center" bgcolor="e7e7e7" class="tx12B">주문처리상태</td>
    <td bgcolor="#FFFFFF">
    	<span style="padding : 1 0 3 0"><c:out value="${totalOrderDetailList[0].seq}"/></span>
    	<!-- select name='st' onChange="state_change2(this.form)" style='font-size:12px;'>
	      <option value='0'selected>정상처리</option>
	      <option value='4'>취소완료</option>
	      <option value='5'>취소요청</option>
	      <option value='6'>반품요청</option>
	      <option value='7'>반품완료</option>
	      <option value='8'>교환요청</option>
	      <option value='9'>교환완료</option>
    	</select-->
    </td>
  </tr>
  <tr>
    <td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">관리자메모</td>
    <td bgcolor="#FFFFFF" colspan="3">
    	<textarea name="textarea" cols="45" rows="6" style="width:100%;">
    		<c:out value="${totalOrderDetailList[0].managerMemo}"/>
    	</textarea>
    	<br>
        <input name="textfield2" type="text" id="textfield" size="66" style="width:80%;">
      	<a href="#"><img src="/images/button/s_button_03.gif" width="30" height="18" align="absmiddle"></a>
    </td>
  </tr>
  <tr>
    <td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">주문상품변경</td>
    <td bgcolor="#FFFFFF" colspan="3">제품번호/제품명/금액/차액(-5000원)<a href="#">[상품변경]</a></td>
  </tr>
  <tr>
    <td width="15%" height="28" align="center" bgcolor="e7e7e7" class="tx12B">추가금액</td>
    <td bgcolor="#FFFFFF" colspan="3">
    	<input type='text' size='10' name='deliver2' value='0' style="text-align:right">원
    </td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" class="tx14B" style="padding-left:10px"><STRONG>정산금액</STRONG> = 판매가(11,000 원) - 마켓수수료(1,620 원) = <strong>9,380 원 / <strong>마진(2,240 원) / 마진율 (20.36 %)</strong><br>
      판매마진 </strong>= 원판매가(11,000 원) - 원가(7,140 원) - 마켓수수료(1,620 원) - 배송료(0 원) - 추가금(0 원)</td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="40" align="center" class="tx14B" style="padding-left:10px">
			<a href="javascript:save();"><img src="/images/button/btn_confirm.gif"></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#"><img src="/images/button/btn_cancel.gif"></a>
		</td>
	</tr>
</table>
</form>
<iframe name='iframe_proc' src='about:blank;' frameborder='0' width=0 height=0></iframe>
</body>
</html>


