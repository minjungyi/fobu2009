package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.InfoCategoryVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Category Data Access Object
 *
 * @author min
 * @since 2012. 12. 30.
 */
@Repository
public class InfoCategoryDAO extends AbstractDao {
	
	
	/**
	 *	카테고리 정보 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<InfoCategoryVO> listInfoCategory(Map paramMap) throws SQLException {		
		return (List<InfoCategoryVO>) list("InfoCategoryDAO.listInfoCategory", paramMap);
	}
	
}
