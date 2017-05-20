package main.java.fobu.neroAdmin.inventoryManage.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.common.service.UserVO;
import main.java.fobu.neroAdmin.inventoryManage.service.InventoryManageService;
import main.java.fobu.neroAdmin.inventoryManage.service.InventoryManageVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Service
public class InventoryManageServiceImpl implements InventoryManageService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "inventoryManageDAO")
	private InventoryManageDAO inventoryManageDao;
	
	/**
	 * The Constructor
	 */
	public InventoryManageServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public List<InventoryManageVO> listInventoryManage(Map paramMap) throws SQLException {
		List<InventoryManageVO> listInventoryManage = inventoryManageDao.listInventoryManage(paramMap);
		return listInventoryManage;
	}	
	
	@Override
	public int listInventoryManageCount(Map paramMap) throws SQLException {
		int inventoryManageCount = inventoryManageDao.listInventoryManageCount(paramMap);
		return inventoryManageCount;
	}
}

