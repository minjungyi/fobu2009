package main.java.fobu.admin.shoplinker.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.OpenMarketMarginListVO;


/**
 * 2012.04.27
 * @author psycoder
 *
 */
public interface ShoplinkerInitService {
	
	public int updateSoldOutOpenMarket(Map paramMap) throws SQLException;
	
}
