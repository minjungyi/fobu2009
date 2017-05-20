package main.java.fobu.neroAdmin.productInventory.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.common.service.impl.AbstractDao;
import main.java.fobu.neroAdmin.productInventory.service.ProductInventoryVO;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min™
 * @since 2010. 09. 10.
 */
@Repository
public class ProductInventoryDAO extends AbstractDao {
	
	/**
	 *	제품 정보 가져오기, 상세보기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ProductInventoryVO> listProductInfo(Map paramMap) throws SQLException {		
		return (List<ProductInventoryVO>) list("ProductInventoryDAO.listProductInfo", paramMap);
	}
	
	/**
	 * 제품 저장
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public void insertProductInfo(Map paramMap) throws SQLException {		
		insert("ProductInventoryDAO.insertProductInfo", paramMap);
	}
	
	/**
	 * 제품 수정
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public void updateProductInfo(Map paramMap) throws SQLException {		
		insert("ProductInventoryDAO.updateProductInfo", paramMap);
	}
	
	/**
	 * 입출고내역 저장
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public void saveInventoryInfo(Map paramMap) throws SQLException {		
		insert("ProductInventoryDAO.saveInventoryInfo", paramMap);
	}
	
	/**
	 * 입출고내역 수정
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public void updateInventoryInfo(Map paramMap) throws SQLException {		
		update("ProductInventoryDAO.updateInventoryInfo", paramMap);
	}
	
	/**
	 * 입출고내역 삭제
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public void deleteInventoryInfo(Map paramMap) throws SQLException {		
		delete("ProductInventoryDAO.deleteInventoryInfo", paramMap);
	}
	
	/**
	 * 정산목록검색
	 * @param paramMap
	 * @return ProductInventoryVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<ProductInventoryVO> listProductInventory(Map paramMap) throws SQLException {
		return (List<ProductInventoryVO>) list("ProductInventoryDAO.listProductInventory", paramMap);
	}
	
	/**
	 * 정산목록검색 총건수
	 * @param paramMap
	 * @return ProductInventoryVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listProductInventoryCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("ProductInventoryDAO.listProductInventoryCount", paramMap));
	}
}
