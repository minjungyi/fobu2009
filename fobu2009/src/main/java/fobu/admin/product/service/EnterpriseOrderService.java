package main.java.fobu.admin.product.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;



/**
 * 2012.10.02
 * @author psycoder
 *
 */
public interface EnterpriseOrderService {
	
	public List<ProductVO> listEnterpriseOrder(Map paramMap) throws SQLException ;
	public int listEnterpriseOrderCount(Map paramMap) throws SQLException;
	public int updateEnterpriseOrderStatus(ProductListVO productList, String status) throws SQLException;
	public int updateEnterpriseOrderQy(ProductListVO productList) throws SQLException;
}
