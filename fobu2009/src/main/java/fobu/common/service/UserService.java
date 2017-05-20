package main.java.fobu.common.service;

import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 사용자 로그인을 처리하는 Interface
 *
 * @author min™
 * @since 2011. 07. 24
 *
 */
public interface UserService {
	
	/**
	 * 로그인을처리한다.(EAM연동 안함)
	 * @param loginId 로그인ID
	 * @param userPassword 비밀번호
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @return 처리결과코드
	 * @exception Exception
	 */
	int login(String loginId, String userPassword, HttpServletRequest request, HttpServletResponse response) throws Exception;  
	
	/**
	 * 로그아웃을처리한다.(EAM연동 안함)
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @exception Exception
	 */
	void logout(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	/**
	 * 사용자 목록 조회
	 *
	 * @param userNm 사용자명
	 * @param loginId 로그인ID
	 * @param userTyCode 사용자유형
	 * @param userSttusCode 사용자상태
	 * @return UserVO List
	 * @throws SQLException 
	 */
	List<UserVO> listUser(String userNm, String loginId, String userTyCode, String userSttusCode) throws SQLException;
}


