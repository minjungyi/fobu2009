package main.java.fobu.admin.product.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import main.java.fobu.admin.product.service.InfoCategoryVO;


/**
 * ProductCategory Service Interface
 *
 * @author min
 * @since 2011. 10. 12.
 */
public interface InfoCategoryService {
	
	public List<InfoCategoryVO> listInfoCategory(Map paramMap) throws SQLException;
}
