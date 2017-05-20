package main.java.fobu.admin.excel.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;


import main.java.fobu.admin.excel.service.ProductExcelService;
import main.java.fobu.admin.excel.service.ProductExcelVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * ProductExcel Service Implementation
 *
 * @author min
 * @since 2012. 03. 10.
 */
@Service
public class ProductExcelServiceImpl implements ProductExcelService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "productExcelDAO")
	private ProductExcelDAO productExcelDao;
	
	/**
	 * The Constructor
	 */
	public ProductExcelServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}	
	
	@Override
	public List<ProductExcelVO> listProductExcel(Map paramMap) throws SQLException {
		List<ProductExcelVO> listTotalProduct = productExcelDao.listProductExcel(paramMap);
		return listTotalProduct;
	}
	
	@Override
	public List<ProductExcelVO> listProductCompanyExcel(Map paramMap) throws SQLException {
		List<ProductExcelVO> listCompany = productExcelDao.listProductCompanyExcel(paramMap);
		return listCompany;
	}
	
	@Override
	public List<ProductExcelVO> listProductCompanySumExcel(Map paramMap) throws SQLException {
		List<ProductExcelVO> listCompanySum = productExcelDao.listProductCompanySumExcel(paramMap);
		return listCompanySum;
	}
}
