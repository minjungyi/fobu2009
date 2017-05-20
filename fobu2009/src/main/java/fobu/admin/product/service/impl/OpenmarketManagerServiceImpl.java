package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.admin.product.service.OpenmarketManagerService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;


/**
 * OpenmarketManager Service Implementation
 *
 * @author psycoder
 * @since 2013. 01. 12.
 */
@Service
public class OpenmarketManagerServiceImpl implements OpenmarketManagerService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "openmarketManagerDAO")
	private OpenmarketManagerDAO openmarketManagerDAO;
	
	/**
	 * The Constructor
	 */
	public OpenmarketManagerServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<OpenMarketMarginVO> listOpenmarketManager(Map paramMap) throws SQLException {
				
		List<OpenMarketMarginVO> listOpenmarketManager = openmarketManagerDAO.listOpenmarketManager(paramMap);
		return listOpenmarketManager;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public int listOpenmarketManagerCount(Map paramMap) throws SQLException {
		
		if(paramMap.get("face").equals("new")){
			paramMap.put("new", "Y");
		}
		else if(paramMap.get("face").equals("status")){
			paramMap.put("status", "Y");
		}
		int listCount = openmarketManagerDAO.listOpenmarketManagerCount(paramMap);
		return listCount;
	}
	
}
