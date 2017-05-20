package main.java.fobu.admin.accountManage.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.accountManage.service.AccountVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class AccountExcelDAO extends AbstractDao {
	
	/**
	 * 정산목록검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<AccountVO> listAccountExcel(Map paramMap) throws SQLException {
		return (List<AccountVO>) list("AccountDAO.listAccountExcel", paramMap);
	}
	
	/**
	 * 정산상태검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<AccountVO> listAccountStat(Map paramMap) throws SQLException {
		return (List<AccountVO>) list("AccountDAO.listAccountStat", paramMap);
	}
	
	/**
	 * 정산 후 변경 목록검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<AccountVO> listAccountAccidentExcel(Map paramMap) throws SQLException {
		return (List<AccountVO>) list("AccountDAO.listAccountAccidentExcel", paramMap);
	}
	
	/**
	 * 정산 후 변경상태검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<AccountVO> listAccountAccidentStat(Map paramMap) throws SQLException {
		return (List<AccountVO>) list("AccountDAO.listAccountAccidentStat", paramMap);
	}
}
