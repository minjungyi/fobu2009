package main.java.fobu.admin.product.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


/**
 * ProductBrand Service Interface
 *
 * @author min
 * @since 2011. 10. 12.
 */
public interface ProductBrandService {
	
	public int saveProductBrand(ProductBrandVO ProductBrand) throws SQLException;
	@SuppressWarnings("unchecked")
	public List<ProductBrandVO> listBrand(Map paramMap) throws SQLException;
	@SuppressWarnings("unchecked")
	public List<ProductBrandVO> listBrandDetail(Map paramMap) throws SQLException;
}
