package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.admin.product.service.InfoCategoryService;
import main.java.fobu.admin.product.service.InfoCategoryVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * ProductCategory Service Implementation
 *
 * @author min
 * @since 2011. 10. 12.
 */
@Service
public class InfoCategoryServiceImpl implements InfoCategoryService {
	
	// Logger
	@SuppressWarnings("unused")
	private Log logger;
	
	@Resource(name = "infoCategoryDAO")
	private InfoCategoryDAO infoCategoryDAO;
	
	/**
	 * The Constructor
	 */
	public InfoCategoryServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}	
	
	@Override
	public List<InfoCategoryVO> listInfoCategory(Map paramMap) throws SQLException {
		List<InfoCategoryVO> listInfoCategory = infoCategoryDAO.listInfoCategory(paramMap);
		return listInfoCategory;
	}
	
}
