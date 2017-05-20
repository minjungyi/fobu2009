<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/fobu/admin/ainclude/top.jsp" %>
<style type="text/css">
<!--

.number0 {overflow: hidden;position: relative;font-family: sans-serif;font-size: 21px;font-color: black;}
.number0 span {position: relative;}
.number1 {overflow: hidden;position: relative;font-family: sans-serif;font-size: 21px;font-color: black;}
.number1 span {position: relative;}
.number2 {overflow: hidden;position: relative;font-family: sans-serif;font-size: 21px;font-color: black;}
.number2 span {position: relative;}
.number3 {overflow: hidden;position: relative;font-family: sans-serif;font-size: 21px;font-color: black;}
.number3 span {position: relative;}
.number4 {overflow: hidden;position: relative;font-family: sans-serif;font-size: 21px;font-color: black;}
.number4 span {position: relative;}
.number5 {overflow: hidden;position: relative;font-family: sans-serif;font-size: 21px;font-color: black;}
.number5 span {position: relative;}
.number6 {overflow: hidden;position: relative;font-family: sans-serif;font-size: 21px;font-color: black;}
.number6 span {position: relative;}
.number7 {overflow: hidden;position: relative;font-family: sans-serif;font-size: 21px;font-color: black;}
.number7 span {position: relative;}
.number8 {overflow: hidden;position: relative;font-family: sans-serif;font-size: 21px;font-color: black;}
.number8 span {position: relative;}
-->
</style>
<script language="javascript">
function changeNumber(newNo, newId) {

    // Get the current value
    var $number = $('.'+newId),
        oldNo = $number.text(),
        oldSplit = oldNo.split(""),
        newSplit = newNo.split(""),
        diffSplit = [];
    // Clear the number from the holder
    $number.html('');

    for (var i = 0; i < oldSplit.length; i++) {
        // Replace the number with spans wrapping each number
        $number.append('<span data-col="' + i + '">' + oldSplit[i] + '</span>').delay(1000);
        // See what the different between the two numbers is
        diffSplit.push(newSplit[i] - oldSplit[i]);
    }

    // Loop through and layout the spans
    for (var i = 0; i < diffSplit.length; i++) {

        // Find the current span for this digit
        var $span = $number.find('span:eq(' + i + ')');
        $span.attr('data-topFinish', $span.height() * (diffSplit[i]) * -1);

        // Layout all the span's which are needed for animation.
        if (diffSplit[i] !== 0) {
            var direction = diffSplit[i] > 0 ? 1 : -1;
            var n = Math.abs(diffSplit[i]);

            for (var j = 1; j < n + 1; j++) {
                var top = $span.position().top + $span.height() * j * direction;
                var left = $span.position().left;
                var topFinish = top - n * $span.height() * direction;

                $number.append('<span data-col="' + i + '" data-topFinish="' + topFinish + '" style="position: absolute; top:' + top + 'px; left:' + left + 'px;">' + (j * direction + (+oldSplit[i])) + '</span>').delay(1000);
            }
        }
    }

    // Animate all the spans up and down as required
    $number.find('span').each(function() {
        var finish = $(this).attr('data-topFinish') + 'px';
        $(this).animate({
            top: finish
        }, function() {
            $number.html(newNo);
        });
    });
}


// Listen for an ENTER key press on the input field

$(function() {
   
   // $("#no").keypress(function(event){
    	//alert(234);
        if (event.keyCode === 13) {
        	 for(var i = 0; i <9; i++){
        		 changeNumber($('#no').val(), "number"+i);
        	} 
        } 
  //  });
});


</script>
<br>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="300" height="176" align="center" valign="top" background="/images/main/tbg_01.gif">
    <!--게시판 -->
    <table width="270" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="42"><a href="#"><img src="/images/main/blank.gif" width="270" height="30"></a></td>
      </tr>
      <tr>
        <td height="24">작업중입니다...</td>
      </tr>
      <tr>
        <td height="24"></td>
      </tr>
      <tr>
        <td height="24"></td>
      </tr>
      <tr>
        <td height="24"></td>
      </tr>
      <tr>
        <td height="24"></td>
      </tr>
    </table></td>
    <td width="12"><img src="/images/main/blank.gif" width="12" height="1"></td>
    <td width="288" align="center" valign="top" background="/images/main/tbg_02.gif">
    <!--판매현황 -->
    <table width="260" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="36">&nbsp;</td>
        </tr>
      <tr>
        <td width="184" height="42" align="right">
            <div class="number0">00000</div>
            <!-- <img src="/images/main/1.gif" width="14" height="23">
            <img src="/images/main/2.gif" width="17" height="23">
            <img src="/images/main/3.gif" width="18" height="23">
            <img src="/images/main/4.gif" width="17" height="23"> -->
        </td>
      </tr>
      <tr>
        <td height="42" align="right">
            <div class="number1">00000</div>
            <!-- img src="/images/main/5.gif" width="17" height="23">
            <img src="/images/main/6.gif" width="18" height="23">
            <img src="/images/main/7.gif" width="17" height="23">
            <img src="/images/main/8.gif" width="18" height="23"-->
        </td>
      </tr>
      <tr>
        <td height="42" align="right">
            <div class="number2">00000</div>
            <!-- img src="/images/main/9.gif" width="18" height="23">
            <img src="/images/main/0.gif" width="17" height="23"-->
        </td>
      </tr>
    </table></td>
    <td width="12"><img src="/images/main/blank.gif" width="12" height="1"></td>
    <td width="288" align="center" valign="top" background="/images/main/tbg_03.gif">
    <!--클레임현황 -->
    <table width="260" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="36" colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td width="127" align="right">
            <div class="number3">00000</div>
	        <!--img src="/images/main/1.gif" width="14" height="23">
	        <img src="/images/main/2.gif" width="17" height="23">
	        <img src="/images/main/3.gif" width="18" height="23">
	        <img src="/images/main/4.gif" width="17" height="23"-->
        </td>
        <td width="137" height="42" align="right">
            <div class="number4">00000</div>
	        <!--img src="/images/main/1.gif" width="14" height="23" />
	        <img src="/images/main/2.gif" width="17" height="23" />
	        <img src="/images/main/3.gif" width="18" height="23" />
	        <img src="/images/main/4.gif" width="17" height="23" /-->
        </td>
      </tr>
      <tr>
        <td align="right">
            <div class="number5">00000</div>
	        <!--img src="/images/main/5.gif" width="17" height="23">
	        <img src="/images/main/6.gif" width="18" height="23">
	        <img src="/images/main/7.gif" width="17" height="23">
	        <img src="/images/main/8.gif" width="18" height="23"-->
        </td>
        <td height="42" align="right">
            <div class="number6">00000</div>
	        <!-- img src="/images/main/1.gif" width="14" height="23" />
	        <img src="/images/main/2.gif" width="17" height="23" />
	        <img src="/images/main/3.gif" width="18" height="23" />
	        <img src="/images/main/4.gif" width="17" height="23" /-->
        </td>
      </tr>
      <tr>
        <td align="right">
            <div class="number7">00000</div>
	        <!--img src="/images/main/9.gif" width="18" height="23">
	        <img src="/images/main/0.gif" width="17" height="23"-->
        </td>
        <td height="42" align="right">
            <div class="number8">00000</div>
	        <!--img src="/images/main/1.gif" width="14" height="23" />
	        <img src="/images/main/2.gif" width="17" height="23" />
	        <img src="/images/main/3.gif" width="18" height="23" />
	        <img src="/images/main/4.gif" width="17" height="23" /-->
        </td>
      </tr>
    </table></td>
    <td width="12">
	    <img src="/images/main/blank.gif" width="12" height="1">
    </td>
    <td width="288" align="center" valign="top" background="/images/main/tbg_04.gif">
    <!--회원현황 -->
    <table width="260" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td height="36">&nbsp;</td>
      </tr>
      <tr>
        <td width="50" align="right">&nbsp;</td>
        <td width="42" align="right">&nbsp;</td>
        <td width="42" align="right">&nbsp;</td>
        <td width="42" align="right">&nbsp;</td>
        <td width="42" align="right">&nbsp;</td>
        <td width="42" height="16" align="right">&nbsp;</td>
        </tr>
      <tr>
        <!-- td align="right">&nbsp;</td>
        <td align="right"></td>
        <td align="right"></td>
        <td align="right"></td>
        <td align="right"></td-->
        <td colspan="5">작업중입니다.</td>
        <td height="28" align="right"></td>
      </tr>
      <tr>
        <td align="right">&nbsp;</td>
        <td align="right"></td>
        <td align="right"></td>
        <td align="right"></td>
        <td align="right"></td>
        <td height="28" align="right"></td>
      </tr>
      <tr>
        <td align="right">&nbsp;</td>
        <td align="right"></td>
        <td align="right"></td>
        <td align="right"></td>
        <td align="right"></td>
        <td height="28" align="right"></td>
        </tr>
      <tr>
        <td align="right">&nbsp;</td>
        <td align="right"></td>
        <td align="right"></td>
        <td align="right"></td>
        <td align="right"></td>
        <td height="28" align="right"></td>
        </tr>
    </table></td>
  </tr>
</table>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="20">&nbsp;</td>
  </tr>
  <tr>
    <td height="71" align="center" background="/images/main/bannerbg.gif">
	    <a href="/admin/orderManage/totalList.html?type=111"><img src="/images/main/banner4.gif" width="202" height="71" border="0"></a>
	    <a href="/admin/product/shop_manager.html"><img src="/images/main/banner5.gif" width="201" height="71" border="0"/></a>
	    <a href="/admin/product/product_company.html"><img src="/images/main/banner6.gif" width="195" height="71" border="0"></a>
	    <a href="/admin/statisticsManage/statisticsList.html"><img src="/images/main/banner8.gif" width="195" height="71"  border="0"/></a>
	    <a href="#"><img src="/images/main/banner7.gif" width="198" height="71" border="0"></a>
    </td>
  </tr>
  <tr>
    <td height="20">&nbsp;</td>
  </tr>
</table>
<!--월별상세현황 -->
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="380" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><b>TOTAL</b>&nbsp; 이번달 판매현황</td>
        </tr>
        <tr>
          <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2" /></td>
        </tr>
        <tr>
          <td><table width="100%%" border="0" cellpadding="3" cellspacing="1" bgcolor="e0e0e0">
              <tr>
                <td width="100" height="24" align="center" bgcolor="f7f7f7"><p>총주문건수</p></td>
                <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].totalOrder0}"/></span></td>
                <td width="100" align="center" bgcolor="f7f7f7">취소요청건수</td>
                <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].totalOrder5}"/></span></td>
              </tr>
              <tr>
                <c:set var="totalDeliveryCnt" value="${listMainMonth[0].totalOrder3 + listMainMonth[0].totalOrder7 + listMainMonth[0].totalOrder8 + listMainMonth[0].totalOrder9 + listMainMonth[0].totalOrder10  + listMainMonth[0].totalOrder10}"/>
                <td height="24" align="center" bgcolor="f7f7f7">총배송건수</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${totalDeliveryCnt}"/></span></td>
                <td align="center" bgcolor="f7f7f7">반품요청건수</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].totalOrder7}"/></span></td>
              </tr>
              <tr>
                <td height="24" align="center" bgcolor="f7f7f7">신규제품등록수</td>
                <td align="right" bgcolor="#FFFFFF">-</td>
                <td align="center" bgcolor="f7f7f7">교환요청건수</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].totalOrder9}"/></span></td>
              </tr>
              <tr>
                <td height="24" align="center" bgcolor="f7f7f7">판매금액</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].totalOrderPrice}"/></span></td>
                <td align="center" bgcolor="f7f7f7">배송비</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].totalDeliverPrice}"/></span></td>
              </tr>
              <tr>
                <td height="24" align="center" bgcolor="f7f7f7">마진률</td>
                <td align="right" bgcolor="#FFFFFF"><span class="totalRound"><c:out value="${listMainMonth[0].totalMarginPrice}"/></span></td>
                <td align="center" bgcolor="f7f7f7">마진금액</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].totalMarginPrice}"/></span></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2" /></td>
        </tr>
    </table></td>
    <td><table width="380" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src='/images/logo_fobu.gif' width='30' >&nbsp; 이번달 판매현황</td>
        </tr>
        <tr>
          <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2" /></td>
        </tr>
        <tr>
          <td><table width="100%%" border="0" cellpadding="3" cellspacing="1" bgcolor="e0e0e0">
              <tr>
                <td width="100" height="24" align="center" bgcolor="f7f7f7"><p>총주문건수</p></td>
                <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].fobuOrder0}"/></span></td>
                <td width="100" align="center" bgcolor="f7f7f7">취소요청건수</td>
                <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].fobuOrder5}"/></span></td>
              </tr>
              <tr>
                <c:set var="fobuDeliveryCnt" value="${listMainMonth[0].fobuOrder3 + listMainMonth[0].fobuOrder7 + listMainMonth[0].fobuOrder8 + listMainMonth[0].fobuOrder9 + listMainMonth[0].fobuOrder10  + listMainMonth[0].fobuOrder10}"/>
                <td height="24" align="center" bgcolor="f7f7f7">총배송건수</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${fobuDeliveryCnt}"/></span></td>
                <td align="center" bgcolor="f7f7f7">반품요청건수</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].fobuOrder7}"/></span></td>
              </tr>
              <tr>
                <td height="24" align="center" bgcolor="f7f7f7">신규제품등록수</td>
                <td align="right" bgcolor="#FFFFFF">-</td>
                <td align="center" bgcolor="f7f7f7">교환요청건수</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].fobuOrder9}"/></span></td>
              </tr>
              <tr>
                <td height="24" align="center" bgcolor="f7f7f7">판매금액</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].fobuOrderPrice}"/></span></td>
                <td align="center" bgcolor="f7f7f7">배송비</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].fobuDeliverPrice}"/></span></td>
              </tr>
              <tr>
                <td height="24" align="center" bgcolor="f7f7f7">마진률</td>
                <td align="right" bgcolor="#FFFFFF"><span class="fobuRound"><c:out value="${listMainMonth[0].fobuMarginPrice}"/></span></td>
                <td align="center" bgcolor="f7f7f7">마진금액</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].fobuMarginPrice}"/></span></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2" /></td>
        </tr>
    </table></td>
    <td><table width="380" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src='/images/logo_choco.gif' width='30'>&nbsp; 이번달 판매현황</td>
        </tr>
        <tr>
          <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2" /></td>
        </tr>
        <tr>
          <td><table width="100%%" border="0" cellpadding="3" cellspacing="1" bgcolor="e0e0e0">
              <tr>
                <td width="100" height="24" align="center" bgcolor="f7f7f7"><p>총주문건수</p></td>
                <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].chocoOrder0}"/></span></td>
                <td width="100" align="center" bgcolor="f7f7f7">취소요청건수</td>
                <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].chocoOrder5}"/></span></td>
              </tr>
              <tr>
                <c:set var="chocoDeliveryCnt" value="${listMainMonth[0].chocoOrder3 + listMainMonth[0].chocoOrder7 + listMainMonth[0].chocoOrder8 + listMainMonth[0].chocoOrder9 + listMainMonth[0].chocoOrder10  + listMainMonth[0].chocoOrder10}"/>
                <td height="24" align="center" bgcolor="f7f7f7">총배송건수</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${chocoDeliveryCnt}"/></span></td>
                <td align="center" bgcolor="f7f7f7">반품요청건수</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].chocoOrder7}"/></span></td>
              </tr>
              <tr>
                <td height="24" align="center" bgcolor="f7f7f7">신규제품등록수</td>
                <td align="right" bgcolor="#FFFFFF">-</td>
                <td align="center" bgcolor="f7f7f7">교환요청건수</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].chocoOrder9}"/></span></td>
              </tr>
              <tr>
                <td height="24" align="center" bgcolor="f7f7f7">판매금액</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].chocoOrderPrice}"/></span></td>
                <td align="center" bgcolor="f7f7f7">배송비</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].chocoDeliverPrice}"/></span></td>
              </tr>
              <tr>
                <td height="24" align="center" bgcolor="f7f7f7">마진률</td>
                <td align="right" bgcolor="#FFFFFF"><span class="chocoRound"><c:out value="${listMainMonth[0].chocoMarginPrice}"/></span></td>
                <td align="center" bgcolor="f7f7f7">마진금액</td>
                <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].chocoMarginPrice}"/></span></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2" /></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="right">&nbsp;</td>
  </tr>
  <tr>
    <td width="400"><table width="380" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src='/images/icon_sun.gif' width='30'>&nbsp; 이번달 판매현황</td>
      </tr>
      <tr>
        <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2" /></td>
      </tr>
      <tr>
        <td><table width="100%%" border="0" cellpadding="3" cellspacing="1" bgcolor="e0e0e0">
            <tr>
              <td width="100" height="24" align="center" bgcolor="f7f7f7"><p>총주문건수</p></td>
              <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].minOrder0}"/></span></td>
              <td width="100" align="center" bgcolor="f7f7f7">취소요청건수</td>
              <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].minOrder5}"/></span></td>
            </tr>
            <tr>
              <c:set var="minDeliveryCnt" value="${listMainMonth[0].minOrder3 + listMainMonth[0].minOrder7 + listMainMonth[0].minOrder8 + listMainMonth[0].minOrder9 + listMainMonth[0].minOrder10  + listMainMonth[0].minOrder10}"/>
              <td height="24" align="center" bgcolor="f7f7f7">총배송건수</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${minDeliveryCnt}"/></span></td>
              <td align="center" bgcolor="f7f7f7">반품요청건수</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].minOrder7}"/></span></td>
            </tr>
            <tr>
              <td height="24" align="center" bgcolor="f7f7f7">신규제품등록수</td>
              <td align="right" bgcolor="#FFFFFF">-</td>
              <td align="center" bgcolor="f7f7f7">교환요청건수</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].minOrder9}"/></span></td>
            </tr>
            <tr>
              <td height="24" align="center" bgcolor="f7f7f7">판매금액</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].minOrderPrice}"/></span></td>
              <td align="center" bgcolor="f7f7f7">배송비</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].minDeliverPrice}"/></span></td>
            </tr>
            <tr>
              <td height="24" align="center" bgcolor="f7f7f7">마진률</td>
              <td align="right" bgcolor="#FFFFFF"><span class="minRound"><c:out value="${listMainMonth[0].minMarginPrice}"/></span></td>
              <td align="center" bgcolor="f7f7f7">마진금액</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].minMarginPrice}"/></span></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2" /></td>
      </tr>
    </table></td>
    <td width="400"><table width="380" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src='/images/logo_twin.gif' width='30'>&nbsp; 이번달 판매현황</td>
      </tr>
      <tr>
        <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2"></td>
      </tr>
      <tr>
        <td><table width="100%%" border="0" cellpadding="3" cellspacing="1" bgcolor="e0e0e0">
            <tr>
              <td width="100" height="24" align="center" bgcolor="f7f7f7"><p>총주문건수</p></td>
              <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].twinOrder0}"/></span></td>
              <td width="100" align="center" bgcolor="f7f7f7">취소요청건수</td>
              <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].twinOrder5}"/></span></td>
            </tr>
            <tr>
              <c:set var="twinDeliveryCnt" value="${listMainMonth[0].twinOrder3 + listMainMonth[0].twinOrder7 + listMainMonth[0].twinOrder8 + listMainMonth[0].twinOrder9 + listMainMonth[0].twinOrder10  + listMainMonth[0].twinOrder10}"/>
              <td height="24" align="center" bgcolor="f7f7f7">총배송건수</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${twinDeliveryCnt}"/></span></td>
              <td align="center" bgcolor="f7f7f7">반품요청건수</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].twinOrder7}"/></span></td>
            </tr>
            <tr>
              <td height="24" align="center" bgcolor="f7f7f7">신규제품등록수</td>
              <td align="right" bgcolor="#FFFFFF">-</td>
              <td align="center" bgcolor="f7f7f7">교환요청건수</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].twinOrder9}"/></span></td>
            </tr>
            <tr>
              <td height="24" align="center" bgcolor="f7f7f7">판매금액</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].twinOrderPrice}"/></span></td>
              <td align="center" bgcolor="f7f7f7">배송비</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].twinDeliverPrice}"/></span></td>
            </tr>
            <tr>
              <td height="24" align="center" bgcolor="f7f7f7">마진률</td>
              <td align="right" bgcolor="#FFFFFF"><span class="twinRound"><c:out value="${listMainMonth[0].twinMarginPrice}"/></span></td>
              <td align="center" bgcolor="f7f7f7">마진금액</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].twinMarginPrice}"/></span></td>
            </tr>
            
        </table></td>
      </tr>
      <tr>
        <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2"></td>
      </tr>
    </table></td>
    <td width="400"><table width="380" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src='/images/logo_gf.gif' width='30'>&nbsp; 이번달 판매현황</td>
      </tr>
      <tr>
        <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2" /></td>
      </tr>
      <tr>
        <td><table width="100%%" border="0" cellpadding="3" cellspacing="1" bgcolor="e0e0e0">
            <tr>
              <td width="100" height="24" align="center" bgcolor="f7f7f7"><p>총주문건수</p></td>
              <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].goodOrder0}"/></span></td>
              <td width="100" align="center" bgcolor="f7f7f7">취소요청건수</td>
              <td width="90" align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].goodOrder5}"/></span></td>
            </tr>
            <tr>
              <c:set var="goodDeliveryCnt" value="${listMainMonth[0].goodOrder3 + listMainMonth[0].goodOrder7 + listMainMonth[0].goodOrder8 + listMainMonth[0].goodOrder9 + listMainMonth[0].goodOrder10  + listMainMonth[0].goodOrder10}"/>
              <td height="24" align="center" bgcolor="f7f7f7">총배송건수</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${goodDeliveryCnt}"/></span></td>
              <td align="center" bgcolor="f7f7f7">반품요청건수</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].goodOrder7}"/></span></td>
            </tr>
            <tr>
              <td height="24" align="center" bgcolor="f7f7f7">신규제품등록수</td>
              <td align="right" bgcolor="#FFFFFF">-</td>
              <td align="center" bgcolor="f7f7f7">교환요청건수</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].goodOrder9}"/></span></td>
            </tr>
            <tr>
              <td height="24" align="center" bgcolor="f7f7f7">판매금액</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].goodOrderPrice}"/></span></td>
              <td align="center" bgcolor="f7f7f7">배송비</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].goodDeliverPrice}"/></span></td>
            </tr>
            <tr>
              <td height="24" align="center" bgcolor="f7f7f7">마진률</td>
              <td align="right" bgcolor="#FFFFFF"><span class="goodRound"><c:out value="${listMainMonth[0].goodMarginPrice}"/></span></td>
              <td align="center" bgcolor="f7f7f7">마진금액</td>
              <td align="right" bgcolor="#FFFFFF"><span class="price"><c:out value="${listMainMonth[0].goodMarginPrice}"/></span></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="2" bgcolor="535353"><img src="/images/main/blank.gif" width="1" height="2" /></td>
      </tr>
    </table></td>
  </tr>
</table>
<script language="javascript">

var order0= "<c:out value='${listMainDaily[0].order0}'/>";
var order1= "<c:out value='${listMainDaily[0].order4}'/>";
var order2= "<c:out value='${listMainDaily[0].order3}'/>";
var order3= "<c:out value='${listMainDaily[0].order5}'/>";
var order6= "<c:out value='${listMainDaily[0].order6}'/>";
var order4= "<c:out value='${listMainDaily[0].order7}'/>";
var order7= "<c:out value='${listMainDaily[0].order8}'/>";
var order5= "<c:out value='${listMainDaily[0].order9}'/>";
var order8= "<c:out value='${listMainDaily[0].order10}'/>";


for(var i = 0; i <9; i++){
    changeNumber(commify(eval("order"+i)), "number"+i);
} 

$(".price").each(function(){
	var arg = commify($(this).html());
	$(this).empty().html(arg);
});

$(".goodRound").each(function(){
	var goodRoundVal = "-";
	var value = parseInt('<c:out value="${listMainMonth[0].goodMarginPrice}"/>') / (parseInt('<c:out value="${listMainMonth[0].goodOrderPrice}"/>'));
	if(!isNaN(value)){
		goodRoundVal = Math.ceil(value*10000)/100;
	}
	$(this).empty().html(goodRoundVal);
});

$(".minRound").each(function(){
	var minRoundVal = "-";
    var value = parseInt('<c:out value="${listMainMonth[0].minMarginPrice}"/>') / (parseInt('<c:out value="${listMainMonth[0].minOrderPrice}"/>'));
    if(!isNaN(value)){
        minRoundVal = Math.ceil(value*10000)/100;
    }
    $(this).empty().html(minRoundVal);
});

$(".chocoRound").each(function(){
	var chocoRoundVal = "-";
    var value = parseInt('<c:out value="${listMainMonth[0].chocoMarginPrice}"/>') / (parseInt('<c:out value="${listMainMonth[0].chocoOrderPrice}"/>'));
    if(!isNaN(value)){
        chocoRoundVal = Math.ceil(value*10000)/100;
    }
    $(this).empty().html(chocoRoundVal);
});

$(".fobuRound").each(function(){
	var fobuRoundVal = "-";
    var value = parseInt('<c:out value="${listMainMonth[0].fobuMarginPrice}"/>') / (parseInt('<c:out value="${listMainMonth[0].fobuOrderPrice}"/>'));
    if(!isNaN(value)){
        fobuRoundVal = Math.ceil(value*10000)/100;
    }
    $(this).empty().html(fobuRoundVal);
});

$(".twinRound").each(function(){
	var twinRoundVal = "-";
    var value = parseInt('<c:out value="${listMainMonth[0].twinMarginPrice}"/>') / (parseInt('<c:out value="${listMainMonth[0].twinOrderPrice}"/>'));
    if(!isNaN(value)){
        twinRoundVal = Math.ceil(value*10000)/100;
    }
    $(this).empty().html(twinRoundVal);
});

$(".totalRound").each(function(){
	var totalRoundVal = "-";
    var value = parseInt('<c:out value="${listMainMonth[0].totalMarginPrice}"/>') / (parseInt('<c:out value="${listMainMonth[0].totalOrderPrice}"/>'));
    if(!isNaN(value)){
        totalRoundVal = Math.ceil(value*10000)/100;
    }
    $(this).empty().html(totalRoundVal);
});

</script>
<!-- top start -->
<%@ include file="/view/fobu/admin/ainclude/copyright.jsp" %>
<!-- top end--> 