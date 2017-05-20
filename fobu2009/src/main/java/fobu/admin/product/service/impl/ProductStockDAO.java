package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.ProductSizeOptVO;
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
public class ProductStockDAO extends AbstractDao {
	
	
	/**
	 * 재고량 정보 조회하기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ProductSizeOptVO> listStock(Map paramMap) throws SQLException {		
		return (List<ProductSizeOptVO>) list("ProductStockDAO.listStock", paramMap);
	}
	
	/**
	 * 재고량 정보 삭제하기
	 * @param productSizeOpt
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public void deleteProductStock(Map paramMap) throws SQLException {		
		
		update("ProductStockDAO.deleteStock", paramMap);

	}
	
	
	@SuppressWarnings("unchecked")
	public void updateProductStock(Map paramMap) throws SQLException {	
		
		update("ProductStockDAO.updateProductSizeOpt", paramMap);
		
		return;
	}
}
