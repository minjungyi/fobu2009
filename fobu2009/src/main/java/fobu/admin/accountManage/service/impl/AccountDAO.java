package main.java.fobu.admin.accountManage.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.accountManage.service.AccountVO;
import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class AccountDAO extends AbstractDao {
	
	/**
	 * 정산목록검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<AccountVO> listAccount(Map paramMap) throws SQLException {
		return (List<AccountVO>) list("AccountDAO.listAccount", paramMap);
	}
	
	/**
	 * 정산목록검색 총건수
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listAccountCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("AccountDAO.listAccountCount", paramMap));
	}
	
	/**
	 * 주문상태값 수정
	 * @param orderSeq, accountCode
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	public void saveAccountStat(Map paramMap) throws SQLException {	
		update("AccountDAO.saveAccountStat", paramMap);
	}
	
	/**
	 * 정산그룹목록검색
	 * @param paramMap
	 * @param 
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<AccountVO> listAccountGroup(Map paramMap) throws SQLException {
		return (List<AccountVO>) list("AccountDAO.listAccountGroup", paramMap);
	}
	
	/**
	 * 정산그룹목록검색 총건수
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listAccountGroupCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("AccountDAO.listAccountGroupCount", paramMap));
	}
	
	/**
	 * 정산그룹PK검색 
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<AccountVO> listAccountGroupPk(Map paramMap) throws SQLException {		
		return (List<AccountVO>)list("AccountDAO.listAccountGroupPk", paramMap);
	}
	
	/**
	 * 정산그룹 저장
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	public void insertAccountGroup(Map paramMap) throws SQLException {	
		update("AccountDAO.insertAccountGroup", paramMap);
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * 정산 후 변경 목록검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<AccountVO> listAccountAccident(Map paramMap) throws SQLException {
		return (List<AccountVO>) list("AccountDAO.listAccountAccident", paramMap);
	}
	
	/**
	 * 정산 후 변경 목록검색 총건수
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listAccountAccidentCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("AccountDAO.listAccountAccidentCount", paramMap));
	}
	
	/**
	 * 주문 후 변경 상태값 수정
	 * @param orderSeq, accountCode
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	public void saveAccountAccidentStat(Map paramMap) throws SQLException {	
		update("AccountDAO.saveAccountAccidentStat", paramMap);
	}
	
	/**
	 * 정산 후 변경 그룹목록검색
	 * @param paramMap
	 * @param 
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<AccountVO> listAccountAccidentGroup(Map paramMap) throws SQLException {
		return (List<AccountVO>) list("AccountDAO.listAccountAccidentGroup", paramMap);
	}
	
	/**
	 * 정산 후 변경 그룹목록검색 총건수
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listAccountAccidentGroupCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("AccountDAO.listAccountAccidentGroupCount", paramMap));
	}
	
	/**
	 * 정산 후 변경 그룹PK검색 
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<AccountVO> listAccountAccidentGroupPk(Map paramMap) throws SQLException {		
		return (List<AccountVO>)list("AccountDAO.listAccountAccidentGroupPk", paramMap);
	}
	
	/**
	 * 정산그룹 저장
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 */
	public void insertAccountAccidentGroup(Map paramMap) throws SQLException {	
		update("AccountDAO.insertAccountAccidentGroup", paramMap);
	}
}
