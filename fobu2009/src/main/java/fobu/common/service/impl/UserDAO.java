package main.java.fobu.common.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;

import main.java.fobu.common.service.UserVO;

/**
 * 사용자 Data Access Object (MSO_USER Table)
 *
 * @author min™
 * @since 2011. 07. 24
 */
@Repository
public class UserDAO extends AbstractDao {
	
	/**
	 * 사용자 목록 조회
	 * @param userNm 사용자명
	 * @param loginId 로그인ID
	 * @param userTyCode 사용자유형
	 * @param userSttusCode 사용자상태
	 * @return 사용자 목록
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<UserVO> listUser(String userNm, String loginId, String userTyCode, String userSttusCode) throws SQLException {
		Map<String, String> param = new HashMap<String, String>();
		param.put("userNm", userNm);
		param.put("loginId", loginId);
		param.put("userTyCode", userTyCode);
		param.put("userSttusCode", userSttusCode);
		
		return (List<UserVO>) list("UserDAO.listUser", param);
	}
	
	/**
	 * 사용자 조회
	 * @param loginId 로그인ID
	 * @param userPassword 비밀번호
	 * @return 사용자
	 * @throws SQLException 
	 */
	public UserVO selectUser(String loginId, String userPassword) throws SQLException {
		Map<String, String> param = new HashMap<String, String>();
		param.put("loginId", loginId);
		param.put("userPassword", userPassword);
		
		return (UserVO) getSqlMapClientTemplate().queryForObject("UserDAO.selectUser", param);
	}
}
