/**
 * Revision History
 *
 * Author     Date      Description
 * ------     -----     ------------
 * 장성욱 2010.03.01 최초생성
 *
 */
package main.java.fobu.common.web.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import net.sf.ehcache.Cache;

import main.java.fobu.common.service.UserVO;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


/**
 * 관리자페이지 메뉴별 권한검사를 위한 전처리기
 */
@Service
public class SecurityInterceptor extends HandlerInterceptorAdapter
{
	/**
     * 전처리기
     *
     * @param ServletRequest request
     * @param ServletResponse response
     * @param Object handler
     * @return boolean
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
    {    	
    	//System.out.println("===============================================================================");
    	//System.out.println("preHandle START");
    	//System.out.println("===============================================================================");
    	//boolean isPermission = false;
    	boolean isPermission = true;
    	HttpSession session = request.getSession();
    	
    	String url = request.getRequestURI();
    	//System.out.println("preHandle url //url=====>"+url);
    	
    	if("/admin/index.html".equals(url)||"/".equals(url)||"/common/login/login.action".equals(url)||
    			"/admin/outView/recommendProduct_list.html".equals(url) || "/admin/outView/recommendProduct_list3.html".equals(url)){
    		isPermission = true;
    		return isPermission;
    	}else{	    	
	    	UserVO userVO = (UserVO)session.getAttribute("userInfo");
	    	if(userVO == null){
	    		System.out.println("userId null");
	    		response.sendRedirect("/admin/index.html");
	    		isPermission = false;
	    		return isPermission;
	    	}else{
	    		String userId = (String)userVO.getUserId();
	    		if(userId.equals("nero")){
	    			String urlSubString = url.substring(0, 11);
	    			if(urlSubString.equals("/neroAdmin/")){
	    				isPermission = true;
	    			}else{
	    				response.sendRedirect("/admin/index.html");
	    				isPermission = false;
	    	    		return isPermission;
	    			}
	    		}
	    	}
    	}
    	return isPermission;
    }
}
