package main.java.fobu.admin.product.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


/**
 * TotalOrder Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface ProductCompanyService {
	
	public List<ProductCompanyVO> listCompany2(Map paramMap) throws SQLException;
	public int saveProductCompany(ProductCompanyVO productCompany) throws SQLException;
	public int updateProductCompany(ProductCompanyVO productCompany) throws SQLException;
	
}
