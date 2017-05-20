
function showMsg(str) {
	$.blockUI({ 
		message: '<font size=2>'+str+'</font>',
		css: { 
	        border: 'none', 
	        padding: '15px',
	        left: ($(window).width() - 300) /2 + 'px', 
	        width: '300px', 
	        textAlign: 'center', 
	        backgroundColor: '#000', 
	        opacity: .5, 
	        color: '#fff',
	        cursor: 'wait',
	        fadeOut: 100
	        
		}, 
		overlayCSS:  { 
	        backgroundColor: 'white',
	        opacity:         0.5 
	    },
	    
	    centerX: true,
		  centerY: true
	}); 
}

function closeBlockUI(){
	$.unblockUI();
}

function memoSave2(seq){ 
    //var memoTmp = frm.memoChange.value +"\n"+frm.memo.value;
    var memoChange = frm.memoSel.value;
    var memo = frm.memo.value;
    if(memoChange=="" || memoChange == null){
        alert("관리자메모를 입력하신 후 저장하세요.");
        return;
    }
    $.ajax({
        type:"POST",
        cache: false,
        data:{
            "seq": seq,
            "memoChange" : memoChange,
            "memo": memo
        },
        dataType: "json",
        url:"/admin/orderManage/saveMemo.action",
        success:function(data, status) {
        },
        error:function(request, status) {
            alert(status);
        },
        complete:function(xhr, textStatus) {
            viewList(seq);  
        }
    }); 
    
}

//AJAX 상태 글+닫기
function showMsgNClose(str) {
	$.blockUI({ 
		message: '<font size=2>'+str+'</font>',
			css: { 
	        border: 'none', 
	        padding: '15px',
	        left: ($(window).width() - 300) /2 + 'px', 
	        width: '320px', 
	        textAlign: 'center', 
	        backgroundColor: '#000', 
	        opacity: .5, 
	        color: '#fff',
	        cursor: 'wait', 
	        fadeOut: 100          
			}, 
			overlayCSS:  { 
	        backgroundColor: 'white',
	        opacity:         0.5 
	  	},
	    
	    centerX: true,
		  centerY: true
	}); 
	
	setTimeout($.unblockUI, 1000); 
}
/**
 * 객체의 값이 숫자인지 검사한다.
 * 
 * @param obj 객체 ID
 * @param msg 객체 이름
 * @return 
 */
function isNumber(obj, msg){
 if(!isObject(obj))
  return false;

 if(isNull(obj, msg))
  return false;

 var str = trim(obj.value);

 for(var i=0; i < str.length ; i++) {
  var code = str.charCodeAt(i);

  if ((code < 48) || (code > 57))
  {
   if(msg) {
    window.alert("[" + str.charAt(i) + "]은(는) 숫자가 아닙니다. " + msg + "은(는) 숫자로 입력해 주세요.");
    obj.value = str;
    obj.focus();
   }

   return false;
  }
 }
 /**
  * 입력 문자열의 앞뒤 공백(white space)을 제거한다.
  *
  * @param str 문자열
  * @return
  */
 function trim(str) {
  var n = str.length;

  var i;
  for(i=0; i<n; i++) {
   if(str.charAt(i) != " ") {
    break;
   }
  }

  var j;
  for(j=n-1; j>=0; j--) {
   if(str.charAt(j) != " ") {
    break;
   }
  }

  if(i>j) {
   return "";
  }else{
   return str.substring(i,j+1);
  }
 }

 if(msg) {
  obj.value = str;
 }

 return true;
}

/**
 * 입력 객체가 실제로 페이지상에 존재하는 HTML객체인지를 검사한다.
 *
 * @param obj 객체 ID
 * @return
 */
function isObject(obj){
 if(typeof(obj) != "object") {
  window.alert("객체가 존재하지 않습니다. 객체의 철자를 확인하세요.");
  return false;
 }
 
 return true;
}

/**
 * 입력 객체의 값이 널(null)인지를 검사한다.
 *
 * @param obj 객체 ID
 * @param str 객체 이름
 * @return
 */
function isNull(obj, msg){
 var str = trim(obj.value);

 if(strlen(str) == 0){
  if(msg) {
   window.alert(msg + "을(를) 입력하세요.");
   obj.value = str;
   obj.focus();
  }

  return true;
 }

 if(msg){
  obj.value = str;
 }

 return false;
}


(function($) {
	 $.fn.toPrice = function(cipher) {
	  var strb, len, revslice;
	  
	  strb = $(this).val().toString();
	  strb = strb.replace(/,/g, '');
	  strb = $(this).getOnlyNumeric();
	  strb = parseInt(strb, 10);
	  if(isNaN(strb))
	   return $(this).val('');
	   
	  strb = strb.toString();
	  len = strb.length;
	 
	  if(len < 4)
	   return $(this).val(strb);
	 
	  if(cipher == undefined || !isNumeric(cipher))
	   cipher = 3;
	 
	  count = len/cipher;
	  slice = new Array();
	 
	  for(var i=0; i<count; ++i) {
	   if(i*cipher >= len)
	    break;
	   slice[i] = strb.slice((i+1) * -cipher, len - (i*cipher));
	  }
	 
	  revslice = slice.reverse();
	  return $(this).val(revslice.join(','));
	 };
	 
	 $.fn.getOnlyNumeric = function(data) {
	  var chrTmp, strTmp;
	  var len, str;
	  
	  if(data == undefined) {
	   str = $(this).val();
	  }
	  else {
	   str = data;
	  }
	 
	  len = str.length;
	  strTmp = '';
	  
	  for(var i=0; i<len; ++i) {
	   chrTmp = str.charCodeAt(i);
	   if((chrTmp > 47 || chrTmp <= 31) && chrTmp < 58) {
	    strTmp = strTmp + String.fromCharCode(chrTmp);
	   }
	  }
	  
	  if(data == undefined)
	   return strTmp;
	  else 
	   return $(this).val(strTmp);
	 };

	 var isNumeric = function(data) {
	  var len, chrTmp;

	  len = data.length;
	  for(var i=0; i<len; ++i) {
	   chrTmp = str.charCodeAt(i);
	   if((chrTmp <= 47 && chrTmp > 31) || chrTmp >= 58) {
	    return false;
	   }
	  }

	  return true;
	 };
	})(jQuery);

function removeStr( arg0, arg1 )
{
    if( arg0 == "" || arg1 == "" ) return "";

    var str = arg0;

    var i = 0;
    var pos_str = 0;
    var rtn_str = "";

    while( i < str.length ) {
        pos_str = str.indexOf(arg1,i);

        if( pos_str == -1 ) {
            rtn_str += str.substring(i, str.length );
            break;
        }else {
            rtn_str += str.substring(i, pos_str );
            i = pos_str+1;
        }
    }
    return rtn_str;
}

//숫자에 콤마찍기
function commify(n) {
	  var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
	  n += '';                          // 숫자를 문자열로 변환
	
	  while (reg.test(n))
	    n = n.replace(reg, '$1' + ',' + '$2');
	
	  return n;
}


function openWindow(targetUrl, windowName, sizeX, sizeY, sScroll) {
	var positionX = (screen.width - sizeX) / 2;
	var positionY = (screen.height - sizeY) / 2;

	if (sScroll==null) sScroll = "no";

	var sOption = "";
	sOption = sOption + "toolbar=no, channelmode=no, location=no, directories=no, resizable=no, menubar=no";
	sOption = sOption + ", scrollbars=" + sScroll + ", left=" + positionX + ", top=" + positionY + ", width=" + sizeX + ", height=" + sizeY;

	var win = window.open(targetUrl, windowName, sOption);
	return win;
}

///이미지 사이즈맞춰서 팝업띄우기///////////////////////////
function imageView(what) { 
  var imgwin = window.open("",'WIN','scrollbars=yes,status=no,toolbar=no,resizable=no,location=no,menu=no,top=0, left=0,width=10,height=10'); 
  imgwin.focus(); 
  imgwin.document.open(); 
  
  imgwin.document.write("<html>\n"); 
  imgwin.document.write("<head>\n"); 
  imgwin.document.write("<title>Image Viwer</title>\n"); //오픈창 타이틀 이름 지정하는 부분
  imgwin.document.write("<sc"+"ript>\n"); 
  imgwin.document.write("function resize() {\n"); 
  imgwin.document.write("pic = document.il;\n"); 
  //imgwin.document.write("alert(eval(pic).height);\n"); 
  imgwin.document.write("if (eval(pic).height) { var name = navigator.appName\n"); 
  imgwin.document.write(" if (name == 'Microsoft Internet Explorer') { myHeight = eval(pic).height + 30; myWidth = eval(pic).width + 10;\n"); 
  imgwin.document.write(" } else { myHeight = eval(pic).height + 36; myWidth = eval(pic).width + 10; }\n"); 
  //imgwin.document.write(" clearTimeout();\n"); 
  imgwin.document.write(" var height = screen.height;\n"); 
  imgwin.document.write(" var width = screen.width;\n"); 
  imgwin.document.write(" var leftpos = width / 2 - myWidth / 2;\n"); 
  imgwin.document.write(" var toppos = height / 2 - myHeight / 2; \n"); 
  imgwin.document.write(" self.moveTo(leftpos, toppos);\n"); 
  imgwin.document.write(" self.resizeTo(myWidth, myHeight);\n"); 
  imgwin.document.write("}else setTimeOut(resize(), 100);}\n"); 
  imgwin.document.write("</sc"+"ript>\n");
  imgwin.document.write("</head>\n"); 
  
  imgwin.document.write('<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" bgcolor="#FFFFFF">\n');
  imgwin.document.write("<img border=0 src="+what+" xwidth=100 xheight=9 name=il onload='resize();' onclick='window.close()'>"); 
  imgwin.document.write("</body>\n");
  
  imgwin.document.write("</html>\n"); 
  imgwin.document.close(); 
}


function fileUploadPreview(thisObj, preViewer) {
	if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(thisObj.value)) {
		alert("이미지 형식의 파일을 선택하십시오");
		return;
	} 
	
	preViewer = (typeof(preViewer) == "object") ? preViewer : document.getElementById(preViewer);
	var ua = window.navigator.userAgent; 
	
	if (ua.indexOf("MSIE") > -1) {
		var img_path = "";
		
		if (thisObj.value.indexOf("\\fakepath\\") < 0) {
			img_path = thisObj.value;
		} else {
			thisObj.select();
			var selectionRange = document.selection.createRange();
			img_path = selectionRange.text.toString();
			thisObj.blur();
		}
		preViewer.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='fi" + "le://" + img_path + "', sizingMethod='scale')";
		preViewer.height = preViewer.offsetHeight;
		
	} else {
		preViewer.innerHTML = "";
		var W = preViewer.offsetWidth;
		var H = preViewer.offsetHeight;
		var tmpImage = document.createElement("img");
		preViewer.appendChild(tmpImage); 
		
		tmpImage.onerror = function () {
			return preViewer.innerHTML = "";
		}; 
		
		tmpImage.onload = function () {
			
			if (this.width > W) {
				this.height = this.height / (this.width / W);
				this.width = W;
			}
			if (this.height > H) {
				this.width = this.width / (this.height / H);
				this.height = H;
			}
		};
		
		if (ua.indexOf("Firefox/3") > -1) {
			var picData = thisObj.files.item(0).getAsDataURL();
			tmpImage.src = picData;
		} else {
			tmpImage.src = "file://" + thisObj.value;
		}
	}
}

function onProductUpdatePop(seq){
	///admin/product/product_updatePop.html?seq="+data.listProduct[z].seq+"
	window.open('/admin/product/product_updatePop.html?seq=' + seq, 'productUpdatePop', 'width=1200, height=750, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}

function onOrderInfoPopup(seq){
	var pageNumPop = frm.pageNumTmp.value;
	var orderDetailPopWin = window.open('/admin/orderManage/orderDetailPop.html?seq=' + seq+'&trIndex='+trIndex+'&pageNumPop='+pageNumPop, 'orderDetailPop', 'width=780, height=780, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
	orderDetailPopWin.focus();
}

function onOrderChangePopup(seq){
	var pageNumPop = frm.pageNumTmp.value;
	window.open('/admin/orderManage/orderProductC.html?seq=' + seq+'&trIndex='+trIndex+'&pageNumPop='+pageNumPop, 'changeProductPop', 'width=780, height=760, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
}

function packageInfoPopup(seq){
	var pageNumPop = frm.pageNumTmp.value;
	var packageInfoPopWin = window.open('/admin/orderManage/packageInfoP.html?seq=' + seq+'&trIndex='+trIndex+'&pageNumPop='+pageNumPop, 'packageInfoP', 'width=770, height=500, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
	packageInfoPopWin.focus(); 
}


function changeRealSrock(productCode, product, realStock, stockOpt){	
	var pageNumPop = frm.pageNumTmp.value;
	var realStockPopPopWin = window.open('/admin/orderManage/realStockPop.html?productCode='+productCode+'&stockOpt='+stockOpt+'&product='+product+'&realStock='+realStock+'&trIndex='+trIndex+'&pageNumPop='+pageNumPop, 'realStockPop', 'width=830, height=550, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes');
	realStockPopPopWin.focus(); 
}

function stockOptSave(productCode, seq){	
	//var memoTmp = frm.memoChange.value +"\n"+frm.memo.value;
	var stockOptChange = frm.stockOptChange.value;
	
	if(stockOptChange=="" || stockOptChange == null){
		alert("재고옵션을 입력하신 후 저장하세요.");
		return;
	}
	$.ajax({
		type:"POST",
	    cache: false,
	    data:{
			"productCode": productCode,
			"stockOpt" : stockOptChange
	    },
	    dataType: "json",
	    url:"/admin/orderManage/saveStockOpt.action",
	    success:function(data, status) {
	    },
	    error:function(request, status) {
	        alert(status);
	    },
	    complete:function(xhr, textStatus) {
	    	viewList(seq);  
	    }
	});	
	
}


/*
 * 숫자와 - 만 입력 받음
 * 
 */

function onlyNum() {
	if((event.keyCode != 45) && (event.keyCode < 45) || (event.keyCode > 57)) {
		event.returnValue = false;
	}
}

/*
 * 숫자 입력 받음
 * 
 */

function regOnlyNum() {
	
	if((event.keyCode < 47) || (event.keyCode > 58)) {
		event.returnValue = false;
	}
}

	

