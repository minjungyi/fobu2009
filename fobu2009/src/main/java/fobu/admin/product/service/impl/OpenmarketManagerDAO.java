package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author psycoder
 * @since 2013. 01. 12.
 */
@Repository
public class OpenmarketManagerDAO extends AbstractDao {
	
	
	/**
	 * 오픈마켓 제품 목록 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<OpenMarketMarginVO> listOpenmarketManager(Map paramMap) throws SQLException {		
		return (List<OpenMarketMarginVO>) list("OpenmarketManager.listOpenmarketManager", paramMap);
	}
	
	/**
	 * 오픈마켓 제품 목록 갯수 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	public int listOpenmarketManagerCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("OpenmarketManager.listOpenmarketManagerCount", paramMap));
	}
	

}
