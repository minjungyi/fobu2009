package main.java.fobu.common.service;
/**
 * 사용자 정보 VO
 *
 * @author min™
 * @since 2011. 07. 24
 *
 */
public class UserVO {
	
	private String userId;				/* 사용자아이디 */
	private String userNm;				/* 이름 */
	private String loginId;				/* 로그인아이디 */
	private String loginNm;				/* 로그인명 */
	private String userPassword;		/* 비밀번호 */
	private String userTyCode;			/* 사용자유형 */
	private String userSttusCode;		/* 사용자상태 */
	private String emailAdres;			/* 이메일주소 */
	private String tlphonNo;			/* 사용자전화번호 */
	private String mobileNo;			/* 모바일전화번호 */
	private String lastConectDt;		/* 최종접속일자 */
	private String ip;					/* 사용자 IP정보 */
	private int result;					/* 사용자 인증결과 */
	private String newPassword;			/* 비밀번호 */
	
	public String getUserId() {
		
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getLoginNm() {
		return loginNm;
	}
	public void setLoginNm(String loginNm) {
		this.loginNm = loginNm;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserTyCode() {
		return userTyCode;
	}
	public void setUserTyCode(String userTyCode) {
		this.userTyCode = userTyCode;
	}
	public String getUserSttusCode() {
		return userSttusCode;
	}
	public void setUserSttusCode(String userSttusCode) {
		this.userSttusCode = userSttusCode;
	}
	public String getEmailAdres() {
		return emailAdres;
	}
	public void setEmailAdres(String emailAdres) {
		this.emailAdres = emailAdres;
	}
	public String getTlphonNo() {
		return tlphonNo;
	}
	public void setTlphonNo(String tlphonNo) {
		this.tlphonNo = tlphonNo;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getLastConectDt() {
		return lastConectDt;
	}
	public void setLastConectDt(String lastConectDt) {
		this.lastConectDt = lastConectDt;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public String getNewPassword() {
		return newPassword;
	}
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
}
