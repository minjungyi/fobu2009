package main.java.fobu.common.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.common.service.UserService;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.SessionCookieUtil;

import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * 사용자 로그인 처리하는 서비스 구현 클래스
 *
 * @author min™
 * @since 2011. 07. 24
 *
 */
@Service
public class UserServiceImpl implements	UserService {

	
	// 사용자 정보 서비스
	@Resource(name = "userDAO")
	protected UserDAO userDAO;
	
	public int login(String loginId, String userPassword,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		// 개발자PC에서 개발하기 위새서 EAM연동해서 인증처리하는 부분이 없는 
		// 메서드로 대체함
		
		int nResultFail = -1;
		int nResultSucc = 1;
		
		// Client IP Address
		String remoteIp = (String) RequestContextHolder.getRequestAttributes().getAttribute("ip.client", RequestAttributes.SCOPE_REQUEST);
		System.out.println("loginTest remoteIp---------------------------->"+remoteIp);
		// 사용자 조회
		UserVO userVO = userDAO.selectUser(loginId, userPassword);
		// DB 사용자 미존재 - 로그인 실패
		if (userVO == null) {
			return nResultFail;
		}
		userVO.setIp(remoteIp);
		
		// 사용자 세션정보 저장 - 세션정보는 DB기준으로 세팅
		SessionCookieUtil.setSessionAttribute(request, "userInfo", userVO);
		
		//// 최종 로그인 일시 업데이트
		//userDAO.updateLoginDate(userVO.getUserId());
		
		// Login Logging
		//logService.loginLogging();
		
		return nResultSucc;
	}
	
	public void logout(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 개발자PC에서 개발하기 위해서 EAM연동해서 처리하는 부분을 
		// 삭제한 메서드로 대체함(신호경 2010.09.02)
		
		if (SessionCookieUtil.getSessionAttribute(request, "userInfo") != null) {
			//logService.logoutLogging();
			SessionCookieUtil.removeSessionAttribute(request, "userInfo");
		}
	}

	public List<UserVO> listUser(String userNm, String loginId, 
			String userTyCode, String userSttusCode) throws SQLException {
		userNm = userNm.replaceAll("'", "''");
		loginId = loginId.replaceAll("'", "''");
		return userDAO.listUser(userNm, loginId, userTyCode, userSttusCode);
	}	
}
