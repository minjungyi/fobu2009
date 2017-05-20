<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<html>
<head>
<title>::::::::: FOBU 관리자페이지 입니다 :::::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/css.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script language=javascript>
<!--
function on(){document.regform.loginId.focus();}
function login2() 
{

if(document.regform.loginId.value=="")
	{
		alert("[아이디]를 입력해 주세요.");
		document.regform.loginId.focus();
		return;
	}
	
	if(document.regform.userPassword.value=="")
	{
		alert("[비밀번호]를 입력해 주세요.");
		document.regform.userPassword.focus();
		return;
	}
document.regform.submit();
}

function login(orderCode){
	var loginId = document.regform.loginId.value;
	var userPassword = document.regform.userPassword.value;
	$.ajax({
	type:"POST",
    cache: false,
    data:{
		"loginId": loginId,
		"userPassword": userPassword
    },
    dataType: "json",
    url:"/common/login/login.action",
    beforeSend:function(xhr) {
		showMsg("<font size=2>로그인 확인중......</font>");
	},
    success:function(data, status) {
    	if(data.nResult == 1){
    		//location.href = "/admin/orderManage/totalList.html";
    		location.href = "/admin/main.html";
    	}else if(data.nResult == 2){
    		location.href = "/neroAdmin/inventoryManage/inventoryManage.html";
        }else{
			alert("아이디와 비밀번호를 확인하세요.");
			document.regform.loginId.value = "";
			document.regform.userPassword.value = "";
        }
		//alert(data.totalOrderCount.count);
		//$("#count").append(data.totalOrderCount);
	},
    error:function(request, status) {
        alert(status);
     },
    complete:function(xhr, textStatus) {
    	 closeBlockUI();
     }
	});		
}

function showMsg(str) {
	$.blockUI({ 
		message: str,
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

</script>
</head>
<body onLoad="on();">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<table width="100%" height="405" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="center">
						<table width="951" border="0" cellspacing="0" cellpadding="0">
					 		 <tr>
								<td height="361" valign="top" background="/images/login_bg.gif" style="padding:185px 10px 10px 415px">
						          <table border="0" cellspacing="0" cellpadding="0">
							  <form method="post" action="/common/login/login.action" name="regform">
											<input type="hidden" name="member_log" value="login"> 										
											<tr>
										      <td width="165" height="26"><input type="text" name="loginId" size='18' tabindex="1"></td>
											  <td width="146" height="26"><input type="password" name="userPassword" size='18' tabindex="2"></td>
										      <td width="134"><input type="image" src="/images/button/blank.gif" width="100" height="100" border="2" onClick="login(); return false;" style="border:0"></a></td>
								</tr>
										</form>
							      </table>	
							   </td>
						    </tr>
				      </table>
				    </td>
			    </tr>
			</table>
		</td>
	</tr>
</table>
</body>