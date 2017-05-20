<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script language="JavaScript">
	function logout(){		
		location.href("./logout.jsp");			
	}
	function openDashBoard(){
		var url = "dashBoard.do";		
		//window.open(url,"dashboard","fullscreen");
		window.open(url,"dashboard","height=860px,width=1044px,menubar=no");
	}
</script> 
<div id="login">	
	<span> ${userAuthItem.usrNm}</span>
<%  	
	String usrGroupCd =  (String)session.getAttribute("usrGroupCd");
	if (usrGroupCd.equals("SHUG0001") || usrGroupCd.equals("SHUG0002") || usrGroupCd.equals("SHUG0003")) {
		out.println("<a href='admin.do' onfocus='this.blur()'><img width='60' height='15' src='img/admin.gif'></a>");
	}
%>  
	<a href='javascript:logout();' onfocus='this.blur()'><img width='59' height='15' src='img/logout.gif'></a>	
  </div>

  <div id="header"> <!-- start .header -->
    <div id="topLeft"><a href="main.do" onfocus="this.blur()"><img class="top_log" width="242" height="43" src="img/logo.png" /></a>
      <ul id="topMenu">
	    <li class="menuitem"><a href="tsvclist.do" onfocus="this.blur()"><img src="img/top_menu1_1.png" id="mainMenu1"/></a></li>
        <li class="menuitem"><a href="rqst.do?step=1" onfocus="this.blur()"><img src="img/top_menu2_1.png" id="mainMenu2"/></a></li>
        <li class="menuitem"><a href="javascript:alert('준비중입니다.');" onfocus="this.blur()"><img src="img/top_menu3_1.png" id="mainMenu3"/></a></li>
        <li class="menuitem"><a href="javascript:alert('준비중입니다.');" onfocus="this.blur()"><img src="img/top_menu4_1.png" id="mainMenu4"/></a></li>
        <li class="menuitem"><a href="javascript:openDashBoard();" onfocus="this.blur()"><img src="img/top_menu5_1.png" id="mainMenu5"/></a></li>
<!--
 		<li class="menuitem"><a href="twsitelist.do"><img src="img/top_menu1_2.png"/></a></li>
        <li class="menuitem"><img src="img/top_menu2_1.png" /></li>
        <li class="menuitem"><img src="img/top_menu3_1.png"/></li>
        <li class="menuitem"><img src="img/top_menu4_1.png"/></li>
        <li class="menuitem"><img src="img/top_menu5_1.png"/></li>		  -->       
      </ul>
    </div>
    <div id="topRight"> </div>
  </div>