package main.java.fobu.admin.shoplinker.service.impl;

import java.sql.SQLException;
import java.util.Map;
import javax.annotation.Resource;

import main.java.fobu.admin.shoplinker.service.ShoplinkerInitService;

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
public class ShoplinkerInitServiceImpl implements ShoplinkerInitService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "shoplinkerInitDAO")
	private ShoplinkerInitDAO shoplinkerInitDAO;
	
	/**
	 * The Constructor
	 */
	public ShoplinkerInitServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	
	
	@Override
	public int updateSoldOutOpenMarket(Map paramMap) throws SQLException {		
		
		try{
			shoplinkerInitDAO.updateSoldOutOpenMarket(paramMap);
		
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
}
