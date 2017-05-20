package main.java.fobu.neroAdmin.companyInventory.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.common.service.impl.AbstractDao;
import main.java.fobu.neroAdmin.companyInventory.service.CompanyInventoryVO;
import main.java.fobu.neroAdmin.productInventory.service.ProductInventoryVO;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min™
 * @since 2010. 09. 10.
 */
@Repository
public class CompanyInventoryDAO extends AbstractDao {
	
	/**
	 *	거래처 정보 가져오기, 상세보기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<CompanyInventoryVO> listCompanyInfo(Map paramMap) throws SQLException {		
		return (List<CompanyInventoryVO>) list("CompanyInventoryDAO.listCompanyInfo", paramMap);
	}
	
	/**
	 * 거래처 저장
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public void insertCompanyInfo(Map paramMap) throws SQLException {		
		insert("CompanyInventoryDAO.insertCompanyInfo", paramMap);
	}
	
	/**
	 * 거래처 수정
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public void updateCompanyInfo(Map paramMap) throws SQLException {		
		insert("CompanyInventoryDAO.updateCompanyInfo", paramMap);
	}
	
	/**
	 * 정산목록검색
	 * @param paramMap
	 * @return ProductInventoryVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<CompanyInventoryVO> listCompanyInventory(Map paramMap) throws SQLException {
		return (List<CompanyInventoryVO>) list("CompanyInventoryDAO.listCompanyInventory", paramMap);
	}
	
	/**
	 * 정산목록검색 총건수
	 * @param paramMap
	 * @return ProductInventoryVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listCompanyInventoryCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("CompanyInventoryDAO.listCompanyInventoryCount", paramMap));
	}
}
