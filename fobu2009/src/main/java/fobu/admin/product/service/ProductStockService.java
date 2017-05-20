package main.java.fobu.admin.product.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.ProductSizeOptVO;
import main.java.fobu.admin.product.service.ProductSizeOptListVO;


/**
 * ProductCategory Service Interface
 *
 * @author min 
 * @since 2011. 10. 12.
 */
public interface ProductStockService {
	
	@SuppressWarnings("unchecked")
	public List<ProductSizeOptVO> listStock(Map paramMap) throws SQLException;
	public int updateProductStock(ProductSizeOptListVO productStock,Map paramMap) throws SQLException;
}
