package main.java.fobu.admin.accountManage.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.admin.accountManage.service.AccountExcelService;
import main.java.fobu.admin.accountManage.service.AccountVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Service
public class AccountExcelServiceImpl implements AccountExcelService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "accountExcelDAO")
	private AccountExcelDAO accountExcelDao;
	
	/**
	 * The Constructor
	 */
	public AccountExcelServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public List<AccountVO> listAccountExcel(Map paramMap) throws SQLException {
		List<AccountVO> listAccountExcel = accountExcelDao.listAccountExcel(paramMap);
		return listAccountExcel;
	}
	
	@Override
	public List<AccountVO> listAccountStat(Map paramMap) throws SQLException {
		List<AccountVO> listAccountStat = accountExcelDao.listAccountStat(paramMap);
		return listAccountStat;
	}
	
	@Override
	public List<AccountVO> listAccountAccidentExcel(Map paramMap) throws SQLException {
		List<AccountVO> listAccountAccidentExcel = accountExcelDao.listAccountAccidentExcel(paramMap);
		return listAccountAccidentExcel;
	}	
	
	@Override
	public List<AccountVO> listAccountAccidentStat(Map paramMap) throws SQLException {
		List<AccountVO> listAccountAccidentStat = accountExcelDao.listAccountAccidentStat(paramMap);
		return listAccountAccidentStat;
	}	
}
