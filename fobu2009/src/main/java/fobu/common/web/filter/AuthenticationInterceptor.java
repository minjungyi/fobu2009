/**
 * Revision History
 *
 * Author     Date      Description
 * ------     -----     ------------
 * 장성욱 2010.03.01 최초생성
 *
 */
package main.java.fobu.common.web.filter;

import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import net.sf.ehcache.Cache;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


/**
 * 관리자페이지 메뉴별 권한검사를 위한 전처리기
 */
public class AuthenticationInterceptor extends HandlerInterceptorAdapter
{
	/**
     * 전처리기
     *
     * @param ServletRequest request
     * @param ServletResponse response
     * @param Object handler
     * @return boolean
     */
	
	public static final String DES_KEY ="TO5GO333";
	
	public static final String ADMIN_SESSION_EO ="_admin";
	
	public static final String ADMIN_SESSION_ID ="_adminId";
	public static final String ADMIN_SESSION_NAME ="_adminName";
	public static final String ADMIN_SESSION_LEVEL ="_adminLevel";
	public static final String ADMIN_SESSION_CARD ="_adminCardInfo";
	public static final String ADMIN_SESSION_MERC ="_adminMerc";
	public static final String ADMIN_SESSION_SPECIAL ="_adminSpecialId";
	
	public static final String ADMIN_SESSION_PRIV ="_adminPriv";
	
	public static final String SAVE_COOKIE_NAME ="_saveId";
	public static final String SAVE_USER_COOKIE_NAME ="jNu3gAea7a";
	
	public static final String SUPER_ADMIN_LEVEL ="99";
	
	public static final String ADMIN_MAIN_PAGE ="/manager/main/index.do";
	public static final String ADMIN_LOGIN_PAGE ="/manager/member/login.do";
	public static final String ADMIN_LOGOUT_PAGE ="/manager/member/logout.do";
	
	public static final String WEB_MAIN_PAGE ="/webMain/main.do";
	public static final String WEB_LOGIN_PAGE ="/webMain/login.do?menuId=6";
	public static final String WAP_BLOG_PAGE ="/wap/wap/mercInfo.do";
	
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
    {    	
    	boolean isPermission = false;
    	HttpSession session = request.getSession();
    	
    	String url = request.getRequestURI();
    	
    	//관리자 경로 검사
    	if(url.startsWith("/manager"))
    	{    		
    		String userId = (String)session.getAttribute(ADMIN_SESSION_ID);
    		String userLevel = (String)session.getAttribute(ADMIN_SESSION_LEVEL);
    		List<?> privDetailList = (List<?>)session.getAttribute(ADMIN_SESSION_PRIV);
    		
    		//비로그인 페이지 (로그인페이지 등등)
    		if(url.startsWith("/manager/member"))
    		{   			
    			isPermission = true;
    		}
    		//로그인 여부 검사
    		else if(userId == null || "".equals(userId) || userLevel == null || "".equals(userLevel))
    		{    			
    			isPermission = false;
    			
    			response.sendRedirect(ADMIN_LOGIN_PAGE);
    		}
    		//관리등급 검사
    		else
    		{   			
    			//모든 관리자가 접근 가능 
    			if(url.startsWith("/manager/common")	//관리자 공통	
    				|| url.startsWith("/manager/main")	//관리자 메인페이지
    				|| url.startsWith("/manager/popup")	//관리자 공통팝업
    				//|| url.startsWith("/manager/popup/findMerc")	//가맹점찾기 팝업은 가맹점스페셜id 접근허용
    				)
    			{    				
    				isPermission = true;
    			}
    			//전체관리자 일 경우 성공
    			else if(userLevel != null && SUPER_ADMIN_LEVEL.equals(userLevel))
    			{    				
    				isPermission = true;
    			}
    			//가맹점,카드사,본사관리자 일 경우 본인의 권한목록에서 request.getRequestURI() 매칭 검사
    			else
    			{	
    				if(isPriv(privDetailList, url))
    				{    					
    					isPermission = true;
    				}
    				else
    				{    					
    					isPermission = false;
    					
    					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/common/message.jsp");		
    					request.setAttribute("returnMSG", "권한이 없습니다.");
    					request.setAttribute("returnURL", ADMIN_MAIN_PAGE);
    					
    					dispatcher.forward(request, response);
    				}
    			}
    		}
    		
    		//성공일 경우 메뉴정보 세팅
    		if(isPermission == true)
    		{
    			setMenuInfo(request, privDetailList, url);
    		}
    	}
    	else
    	{
    		isPermission = true;
    	}
    	
        return isPermission;
    }
    
    /**
     * 현재 url이 권한목록에 있는지 검사
     *
     * @param List<?> privList
     * @param String url
     * @return boolean
     */
    public boolean isPriv(List<?> privList, String url)
    {
    	boolean isPermission = false;
    	
    	if(privList != null && privList.size() > 0)
    	{
    		for(int i=0; i<privList.size() ; i++)
    		{
    			Map<?, ?> privMap = (Map<?, ?>)privList.get(i);
    			
    			if(privMap != null && privMap.get("REPR_URL") != null && url.startsWith((String)privMap.get("REPR_URL")))
    			{
    				isPermission = true;
    				break;
    			}
    		}
    	}   	
    	
    	return isPermission;
    }
   
    /**
     * 현재 관리자 권한의 메뉴내용을 전달 
     *
     * @param HttpServletRequest request
     * @param List<?> privList
     * @param String url
     * @return
     */
    public void setMenuInfo(HttpServletRequest request, List<?> privList, String url)
    {	
    	String rootMenuId = "";
    	String menuId = "";
    	
    	if(privList != null && privList.size() > 0)
    	{    		
    		for(int i=0; i<privList.size() ; i++)
    		{
    			Map<?, ?> privMap = (Map<?, ?>)privList.get(i);
    			
    			if(privMap != null && privMap.get("REPR_URL") != null && url.startsWith((String)privMap.get("REPR_URL")))
    			{
    				//현재메뉴아이디
    				menuId = (String)privMap.get("MENU_ID");
    				
    				//대메뉴 아이디
    				rootMenuId = menuId.substring(0, 2);
    			}
    		}
    	}
    	
		request.setAttribute("MENU_ID", menuId);
		request.setAttribute("ROOT_MENU_ID", rootMenuId);
		request.setAttribute("MENU_LIST", privList);
    }
}
