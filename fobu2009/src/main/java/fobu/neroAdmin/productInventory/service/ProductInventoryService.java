package main.java.fobu.neroAdmin.productInventory.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.ProductCompanyVO;

import jxl.write.WriteException;


/**
 * TotalOrder Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface ProductInventoryService {	
	
	/**
	 * 제품 정보 가져오기, 상세보기
	 * @param paramMap
	 * @return List<ProductInventoryVO>
	 * @throws SQLException 
	 */
	public List<ProductInventoryVO> listProductInfo(Map paramMap) throws SQLException;
	
	/**
	 * 제품 저장
	 * @param paramMap
	 * @return void
	 * @throws SQLException 
	 */
	public void saveProductInfo(Map paramMap) throws SQLException;
	
	/**
	 * 입출고내역 저장
	 * @param paramMap
	 * @return void
	 * @throws SQLException 
	 */
	public void saveInventoryInfo(Map paramMap) throws SQLException;
	
	/**
	 * 입출고내역 수정
	 * @param paramMap
	 * @return void
	 * @throws SQLException 
	 */
	public void updateInventoryInfo(Map paramMap) throws SQLException;
	
	/**
	 * 입출고내역 삭제
	 * @param paramMap
	 * @return void
	 * @throws SQLException 
	 */
	public void deleteInventoryInfo(Map paramMap) throws SQLException;
	
	/**
	 * 정산목록검색
	 * @param paramMap
	 * @return ProductInventoryVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<ProductInventoryVO> listProductInventory(Map paramMap) throws SQLException;
	
	/**
	 * 정산목록검색 총건수
	 * @param paramMap
	 * @return int
	 * @throws SQLException 
	 */
	int listProductInventoryCount(Map paramMap) throws SQLException;
	
}
