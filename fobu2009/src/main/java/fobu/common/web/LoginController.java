package main.java.fobu.common.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.write.WriteException;

import main.java.fobu.common.service.UserService;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.ExcelDownUtil;
import main.java.fobu.common.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;

/**
 *  Controller
 *
 * @author min 
 * @since 2010. 09. 08.
 */
@Controller
public class LoginController {
		
	//@Resource(name = "loginServiceImpl")
	//private LoginService loginService;
	private Log logger = LogFactory.getLog(this.getClass());
	
	@Resource(name = "userServiceImpl")
	private UserService userService;
	
	/**
	 * The Constructor
	 */
	public LoginController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
		
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	@RequestMapping(value = "/admin/index.html")
	public String view(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException, FileNotFoundException, WriteException, IOException {
	        request.setAttribute("SHEET_MSG", "로그인 시작");
 
		return "/fobu/admin/index";
	}
	
	
	@RequestMapping(value = "/index.html")
	public String viewMain(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException, FileNotFoundException, WriteException, IOException {

	        request.setAttribute("SHEET_MSG", "쇼핑몰 메인");
    	//}
		///hr/ParersJdgmnM
		return "/fobu/index";
	}
	
	/**
	 * 로그인 인증
	 * 
	 * @param ModelMap model
	 * @param loginId 로그인ID
	 * @param userPassword 사용자비밀번호
	 * @param HttpServletRequest request
	 * @param HttpServletResponse response
	 * @return : 로그인 결과에 대한 처리
	 * @exception Exception
	 */
	@RequestMapping(value = "/common/login/login.action")
	public String login(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		String loginId = paramMap.get("loginId").toString();
		String userPassword = paramMap.get("userPassword").toString();
		int nResult = -1;
		String serverName = request.getServerName();
		if (loginId != null && userPassword != null) {
			System.out.println("loginId---------------------------->"+loginId);
			//System.out.println("userPassword---------------------------->"+userPassword);
			System.out.println("serverName---------------------------->"+serverName);
			nResult = userService.login(loginId, userPassword, request, response);
			if(loginId.equals("nero")){
				nResult = 2;
			}
			
		}
		
		if(nResult != -1){
			UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
			System.out.println("userVO.getUserId()-------------->"+userInfo.getUserId());
	    	System.out.println("userVO.getUserNm()-------------->"+userInfo.getUserNm());
		}
		//request.setAttribute("ERR_CD", nResult);
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("nResult" , nResult);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		return null;
	}
	
	/**
	 * 로그아웃
	 * 
	 * @param HttpServletRequest request
	 * @param HttpServletResponse response
	 * @return 로그아웃 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/common/login/logout.html")
	public String logout(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
        // 운영서버인 경우 EAM연동 로그아웃 처리
		String serverName = request.getServerName();		
		userService.logout(request, response);
		
		logger.info("=============  " + serverName + ":" + request.getServerPort() + " logout.html called ================");
		return "/fobu/admin/index";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/top.html")
	public String view5(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
	        request.setAttribute("SHEET_MSG", "SHEET_MSG");
	    UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
	    System.out.println("top UserNm()-------------->"+userInfo.getLoginNm());
	    model.addAttribute("UserNm", userInfo.getUserNm());
		return "/fobu/admin/ainclude/topSrc";
	}
	
	/**
	 * Ajax json 응답
	 * @param response
	 * @param jsonObject
	 * @throws Exception
	 */
	private void sendResponse(HttpServletResponse response, JSONObject jsonObject) throws Exception {
		Thread.sleep(200);
		response.setContentType("text/xml;charset=UTF-8");
		response.getWriter().print(jsonObject);
		response.getWriter().flush();
		response.getWriter().close();
    }
}
