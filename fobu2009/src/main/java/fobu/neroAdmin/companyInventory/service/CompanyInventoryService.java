package main.java.fobu.neroAdmin.companyInventory.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import jxl.write.WriteException;
import main.java.fobu.neroAdmin.productInventory.service.ProductInventoryVO;


/**
 * TotalOrder Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface CompanyInventoryService {	
	
	/**
	 * 제품 정보 가져오기, 상세보기
	 * @param paramMap
	 * @return List<CompanyInventoryVO>
	 * @throws SQLException 
	 */
	public List<CompanyInventoryVO> listCompanyInfo(Map paramMap) throws SQLException;
	
	/**
	 * 제품 저장
	 * @param paramMap
	 * @return void
	 * @throws SQLException 
	 */
	public void saveCompanyInfo(Map paramMap) throws SQLException;
	
	/**
	 * 정산목록검색
	 * @param paramMap
	 * @return ProductInventoryVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<CompanyInventoryVO> listCompanyInventory(Map paramMap) throws SQLException;
	
	/**
	 * 정산목록검색 총건수
	 * @param paramMap
	 * @return int
	 * @throws SQLException 
	 */
	int listCompanyInventoryCount(Map paramMap) throws SQLException;
}
