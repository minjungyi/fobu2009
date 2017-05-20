package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Category Data Access Object
 *
 * @author min
 * @since 2011. 10. 12.
 */
@Repository
public class ProductCategoryDAO extends AbstractDao {
	
	
	/**
	 *	제품브랜드 key 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	public Object getLastInsertID() throws SQLException {		
		return (Object) getSqlMapClientTemplate().queryForObject("ProductCategoryDAO.getLastInsertID", null);
	}
	
	/**
	 *	카테고리 정보 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ProductCategoryVO> listCategory(Map paramMap) throws SQLException {		
		return (List<ProductCategoryVO>) list("ProductCategoryDAO.listCategory", paramMap);
	}
	
	/**
	 * 카테고리 등록
	 * @param ProductCategory
	 * @throws SQLException
	 */
	public void insertProductCategory(ProductCategoryVO ProductCategory) throws SQLException {	
		update("ProductCategoryDAO.insertProductCategory", ProductCategory);
	}
	
	/**
	 * 카테고리 수정
	 * @param ProductCategory
	 * @throws SQLException
	 */
	public void updateProductCategory(ProductCategoryVO ProductCategory) throws SQLException {	
		update("ProductCategoryDAO.updateProductCategory", ProductCategory);
	}
	
	/**
	 * 카테고리 삭제
	 * @param ProductCategory
	 * @throws SQLException
	 */
	public void deleteProductCategory(ProductCategoryVO ProductCategory) throws SQLException {	
		update("ProductCategoryDAO.deleteProductCategory", ProductCategory);
	}
	
	/**
	 * 제품 카테고리 수정
	 * @param ProductCategory
	 * @throws SQLException
	 */
	public void updateProductCategory2(ProductVO Product) throws SQLException {	
		update("ProductCategoryDAO.updateProductCategory2", Product);
	}
	
	/**
	 * 제품 카테고리 순서 수정
	 * @param ProductCategory
	 * @throws SQLException
	 */
	public void updateProductCategorySort(ProductCategoryVO ProductCategory) throws SQLException {	
		update("ProductCategoryDAO.updateProductCategory2", ProductCategory);
	}
	
	
	
	public void updateProductCategoryInit(Map paramMap) throws SQLException {	
		update("ProductCategoryDAO.updateProductCategoryInit", paramMap);
	}
}
