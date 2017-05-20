package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductCompanyService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;



/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Service
public class ProductCompanyServiceImpl implements ProductCompanyService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "productCompanyDAO")
	private ProductCompanyDAO productCompanyDAO;
	
	/**
	 * The Constructor
	 */
	public ProductCompanyServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	
	@Override
	public List<ProductCompanyVO> listCompany2(Map paramMap) throws SQLException {
		List<ProductCompanyVO> listCategory = productCompanyDAO.listCompany2(paramMap);
		return listCategory;
	}
	
	@Override
	public int saveProductCompany(ProductCompanyVO productCompany) throws SQLException {		
		
		try{
			productCompanyDAO.saveProductCompany(productCompany);
		
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	@Override
	public int updateProductCompany(ProductCompanyVO productCompany) throws SQLException {		
		
		try{
			productCompanyDAO.updateProductCompany(productCompany);
		
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
}
