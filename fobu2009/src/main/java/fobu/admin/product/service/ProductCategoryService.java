package main.java.fobu.admin.product.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


/**
 * ProductCategory Service Interface
 *
 * @author min
 * @since 2011. 10. 12.
 */
public interface ProductCategoryService {
	
	public int saveProductCategory(ProductCategoryVO ProductCategory) throws SQLException;
	@SuppressWarnings("unchecked")
	public List<ProductCategoryVO> listCategory(Map paramMap) throws SQLException;
	public int updateProductCategory2(ProductVO product) throws SQLException;
	public int updateProductCategorySort(ProductCategoryVO ProductCategory) throws SQLException;
	public int updateProductCategoryInit(Map paramMap) throws SQLException ;
}
