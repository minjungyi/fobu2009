package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.ProductBrandVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Brand Data Access Object
 *
 * @author min
 * @since 2011. 10. 12.
 */
@Repository
public class ProductBrandDAO extends AbstractDao {
	
	
	/**
	 *	제품브랜드 key 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	public Object getLastInsertID() throws SQLException {		
		return (Object) getSqlMapClientTemplate().queryForObject("ProductBrandDAO.getLastInsertID", null);
	}
	
	/**
	 *	제품브랜드 정보 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ProductBrandVO> listBrand(Map paramMap) throws SQLException {		
		return (List<ProductBrandVO>) list("ProductBrandDAO.listBrand", paramMap);
	}
	
	/**
	 *	제품브랜드 상세정보 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ProductBrandVO> listBrandDetail(Map paramMap) throws SQLException {		
		return (List<ProductBrandVO>) list("ProductBrandDAO.listBrandDetail", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<ProductBrandVO> selectBrandDetail(Map paramMap) throws SQLException {		
		return (List<ProductBrandVO>) list("ProductBrandDAO.selectBrandDetail", paramMap);
	}
	
	/**
	 * 제품브랜드 등록
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void insertProductBrand(ProductBrandVO ProductBrand) throws SQLException {	
		update("ProductBrandDAO.insertProductBrand", ProductBrand);
	}
	
	/**
	 * 제품브랜드 수정
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void updateProductBrand(ProductBrandVO ProductBrand) throws SQLException {	
		update("ProductBrandDAO.updateProductBrand", ProductBrand);
	}
}
