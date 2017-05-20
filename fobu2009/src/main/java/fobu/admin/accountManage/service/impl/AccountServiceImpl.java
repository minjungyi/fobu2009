package main.java.fobu.admin.accountManage.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.admin.accountManage.service.AccountService;
import main.java.fobu.admin.accountManage.service.AccountVO;
import main.java.fobu.common.service.UserVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Service
public class AccountServiceImpl implements AccountService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "accountDAO")
	private AccountDAO accountDao;
	
	/**
	 * The Constructor
	 */
	public AccountServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public List<AccountVO> listAccount(Map paramMap) throws SQLException {
		List<AccountVO> listAccount = accountDao.listAccount(paramMap);
		return listAccount;
	}	
	
	@Override
	public int listAccountCount(Map paramMap) throws SQLException {
		int accountCount = accountDao.listAccountCount(paramMap);
		return accountCount;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveAccountStat(Map paramMap) throws SQLException {	
		System.out.println("=====================saveAccountStat start===========================================");
		System.out.println("paramMap : "+paramMap);
		//정산그룹 PK, name(날짜) 가지고 오기
		List<AccountVO> accountGroupPk = accountDao.listAccountGroupPk(paramMap);
		String accountPk = accountGroupPk.get(0).getAccountSeq();
		String accountName = accountGroupPk.get(0).getAccountName();	
		//사용자가지고 오기
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		String userIdTmp = "";
		if(userInfo != null) {
			userIdTmp = userInfo.getUserId();
		} else {
			userIdTmp = "SYSTEM";
		}
		
		paramMap.put("accountSeq", accountPk);
		paramMap.put("accountName", accountName);
		paramMap.put("modifiers", userIdTmp);
		System.out.println("modifiers===========================================" + userIdTmp);
		accountDao.saveAccountStat(paramMap);
		accountDao.insertAccountGroup(paramMap);
	}
	
	@Override
	public List<AccountVO> listAccountGroup(Map paramMap) throws SQLException {
		List<AccountVO> listAccount = accountDao.listAccountGroup(paramMap);
		return listAccount;
	}	
	
	@Override
	public int listAccountGroupCount(Map paramMap) throws SQLException {
		int accountCount = accountDao.listAccountGroupCount(paramMap);
		return accountCount;
	}
	
	
	
	
	
	
	
	
	
	
	@Override
	public List<AccountVO> listAccountAccident(Map paramMap) throws SQLException {
		List<AccountVO> listAccount = accountDao.listAccountAccident(paramMap);
		return listAccount;
	}	
	
	@Override
	public int listAccountAccidentCount(Map paramMap) throws SQLException {
		int accountCount = accountDao.listAccountAccidentCount(paramMap);
		return accountCount;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveAccountAccidentStat(Map paramMap) throws SQLException {	
		System.out.println("=====================saveAccountStat start===========================================");
		System.out.println("paramMap : "+paramMap);
		//정산그룹 PK, name(날짜) 가지고 오기
		List<AccountVO> accountGroupPk = accountDao.listAccountGroupPk(paramMap);
		String accountPk = accountGroupPk.get(0).getAccountSeq();
		String accountName = accountGroupPk.get(0).getAccountName();	
		//사용자가지고 오기
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		String userIdTmp = "";
		if(userInfo != null) {
			userIdTmp = userInfo.getUserId();
		} else {
			userIdTmp = "SYSTEM";
		}
		
		paramMap.put("accountSeq", accountPk);
		paramMap.put("accountName", accountName);
		paramMap.put("modifiers", userIdTmp);
		accountDao.saveAccountAccidentStat(paramMap);
		accountDao.insertAccountAccidentGroup(paramMap);
	}
	
	@Override
	public List<AccountVO> listAccountAccidentGroup(Map paramMap) throws SQLException {
		List<AccountVO> listAccount = accountDao.listAccountAccidentGroup(paramMap);
		return listAccount;
	}	
	
	@Override
	public int listAccountAccidentGroupCount(Map paramMap) throws SQLException {
		int accountCount = accountDao.listAccountAccidentGroupCount(paramMap);
		return accountCount;
	}
}

