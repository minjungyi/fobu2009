package main.java.fobu.admin.shoplinker.service.impl;

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
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class ShoplinkerInitDAO extends AbstractDao {
	
	
	
	/**
	 * 샵링커 품절연동 동기화
	 * @param paramMap
	 * @throws SQLException
	 */
	public void updateSoldOutOpenMarket(Map paramMap) throws SQLException {	
		
		update("ShopManagerDAO.updateSoldOutOpenMarket", paramMap);
	}
}
