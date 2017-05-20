package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class ProductCompanyDAO extends AbstractDao {
	
	
	
	/**
	 *	업체 정보 가져오기, 상세보기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ProductCompanyVO> listCompany2(Map paramMap) throws SQLException {		
		return (List<ProductCompanyVO>) list("ProductCompanyDAO.listCompany2", paramMap);
	}
	
	/**
	 * 거래처(업체) 등록
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void saveProductCompany(ProductCompanyVO productCompany) throws SQLException {	
		
		update("ProductCompanyDAO.saveProductCompany", productCompany);
	}
	
	/**
	 * 거래처(업체) 수정
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void updateProductCompany(ProductCompanyVO productCompany) throws SQLException {	
		
		update("ProductCompanyDAO.updateProductCompany", productCompany);
	}
}
