<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
	
      <div id="sidebar1"> <!-- start .sidebar1 --> 
 
     
      <c:if test="${userAuthItem.currentMenuId =='SHMN0001'}" >      
	    <img width="172" height="53" src="img/left_menu_title_history.gif">      
	  </c:if>  
      <c:if test="${userAuthItem.currentMenuId =='SHMN0002'}" >      
	    <img width="172" height="53" src="img/left_menu_title_application.gif">      
	  </c:if>  
      <c:if test="${userAuthItem.currentMenuId =='SHMN0003'}" >      
	    <img width="172" height="53" src="img/left_menu_title_3.gif">      
	  </c:if>  
      <c:if test="${userAuthItem.currentMenuId =='SHMN0004'}" >      
	    <img width="172" height="53" src="img/left_menu_title_4.gif">      
	  </c:if>  
      <c:if test="${userAuthItem.currentMenuId =='SHMN0005'}" >      
	    <img width="172" height="53" src="img/left_menu_title_5.gif">      
	  </c:if>  
      <c:if test="${userAuthItem.currentMenuId =='SHMN0006'}" >      
	    <img width="172" height="53" src="img/left_menu_administration.gif">      
	  </c:if> 	  	  	  	  	  
        <div id="sideImg"></div>
        <div id="side1">
          <ul id="sideMenu">
   
			<c:forEach var="oList" items="${userAuthItem.menuList}">			
				<c:if test="${oList.menuDepth =='2'}" > 
					<c:if test="${oList.menuUrl =='#'}" > 
						<li class="menuitem" id="menuitem1"><a href="<c:out value='${oList.menuUrl}'/>"><c:out value="${oList.menuNm}"/></a></li>
					</c:if>
					<c:if test="${oList.menuUrl != '#'}" > 
						<li class="menuitem" id="${oList.menuId}"><a href="<c:out value='${oList.menuUrl}'/>"><c:out value="${oList.menuNm}"/></a></li>
					</c:if>
				</c:if>				
				<c:if test="${oList.menuDepth =='3'}" > 
					<li class="menuitem2"><a href="<c:out value="${oList.menuUrl}"/>"> <c:out value="${oList.menuNm}"/></a></li>
				</c:if>				
			</c:forEach>          
			
			
<!--         <li class="menuitem"><a href="#">전체프로세스</a></li>
           <li class="menuitem">소스코드분석</li>
            <li class="menuitem">보안성검토</li>
            <li class="menuitem">웹방화멱 URL 등록</li>
            <li class="menuitem">웹사이트공격방어</li>    -->                                
          </ul>
        </div>
        <div id="left_informaiton"><img width="148" height="91" src="img/my informaiton.gif"></div>
        <div id="helpdesk"><img width="148" height="91" src="img/helpdesk.gif"></div>
      </div>
      <!-- end .sidebar1 -->

<!-- 
      <div id="sidebar1"> <
        <img width="172" height="53" src="img/left_menu_title_application.gif">
        <div id="side1">
          <ul id="sideMenu">
            <li class="menuitem_on">전체프로세스</li>
            <li class="menuitem">상시점검</li>
          </ul>
        </div>
        <div id="left_informaiton"><img width="148" height="91" src="img/my informaiton.gif"></div>
        <div id="helpdesk"><img width="148" height="91" src="img/helpdesk.gif"></div>
      </div>
       -->
      <!-- end .sidebar1 -->