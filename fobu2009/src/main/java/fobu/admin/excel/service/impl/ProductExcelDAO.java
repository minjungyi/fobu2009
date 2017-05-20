package main.java.fobu.admin.excel.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.excel.service.ProductExcelVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class ProductExcelDAO extends AbstractDao {
	
	/**
	 * 발주검색 - 발주 엑셀 목록
	 * @param 
	 * @return ProductExcelVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<ProductExcelVO> listProductExcel(Map paramMap) throws SQLException {		
		return (List<ProductExcelVO>) list("ProductExcelDAO.listProductOrderExcel", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<ProductExcelVO> listProductCompanyExcel(Map paramMap) throws SQLException {		
		return (List<ProductExcelVO>) list("ProductExcelDAO.listProductOrderCompanyExcel", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<ProductExcelVO> listProductCompanySumExcel(Map paramMap) throws SQLException {		
		return (List<ProductExcelVO>) list("ProductExcelDAO.listProductOrderCompanySumExcel", paramMap);
	}
}
