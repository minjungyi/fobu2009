package main.java.fobu.admin.product.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;



/**
 * OpenmarketManager Service Interface
 *
 * @author psycoder
 * @since 2013. 01. 12.
 */
public interface OpenmarketManagerService {
	
	public List<OpenMarketMarginVO> listOpenmarketManager(Map paramMap) throws SQLException;
	public int listOpenmarketManagerCount(Map paramMap) throws SQLException;
}
